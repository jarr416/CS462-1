ruleset rotten_tomatoes{
  meta{
    use module a169x701 alias CloudRain
    use module a41x186  alias SquareTag
  }
  
  dispatch{
  
  }
  global{
    api_key = "ymhqztdx34kqzev9bhgu7uab"
    	get_movie = function(title) {
					url = "http://api.rottentomatoes.com/api/public/v1.0/movies.json";
					http:get(url, {"apikey":api_key, "q":title}).pick("$.content").decode();
				}
	mydiv = << <div id="main"></div> >>;
	myform = <<
        <form id="myform">
		Movie Title: <input type="text" name="movie_title" />
		<input type="submit" />
		</form>
      >>;
  }
  
  rule HelloWorld is active {
    select when web cloudAppSelected
    {
      SquareTag:inject_styling();
      CloudRain:createLoadPanel("Rotten Tomatoes", {}, mydiv + myform);
	  watch("#myform", "submit");
    }
  }
  
  rule validate {
	select when web submit "#myform"
	pre {
		response = get_movie(event:attr("movie_title"));
	}
	if response.pick("$.total") eq 0 then {
		noop();
	}
	fired {
		raise explicit event display_error with search = event:attr("movie_title");
	}
	else {
		raise explicit event display_result with r = response;
	}
  }
  
  rule display_result {
	select when explicit display_result
	pre {
		thumbnail = event:attr("r").pick("$.movies[0].posters.thumbnail");
		title = event:attr("r").pick("$.movies[0].title");
		year = event:attr("r").pick("$.movies[0].year");
		synopsis = event:attr("r").pick("$.movies[0].synopsis");
		critic = event:attr("r").pick("$.movies[0].ratings.critics_score");
		audience = event:attr("r").pick("$.movies[0].ratings.audience_score");
		result_html = <<
					<img src="#{thumbnail}" /><br />
					<h2>#{title}</h2><h3>(#{year})</h3><br />
					<b>Critic Score: </b>#{critic}<br />
					<b>Audience Score: </b>#{audience}<br />
					<p>#{synopsis}</p>
					>>;
	}
	{
		//notify("response", "r: " + response) with sticky = true;
		//CloudRain:createLoadPanel("Rotten Tomatoes", {}, result_html + myform);
		replace_inner("#main", result_html);

	}
  }
  
  rule display_error {
	select when explicit display_error
	//CloudRain:createLoadPanel("Rotten Tomatoes", {}, "No movie results found for \"" + event:attr("search") + "\"" + myform);
	replace_inner("#main", "No movie results found for \"" + event:attr("search") + "\"");
  }
}
