ruleset Lab3{

  rule show_form{
    select when pageview
    pre{
      my_form = <<  
        <p>This is a paragraph. Aren't you proud of me?</p>
        <form id="myForm" onsubmit="return false">
        <input type="text" name="firstname" />
				<input type="text" name="lastname" />
				<input type="submit" value = "Submit"/>
        </form>
      >>;
    }
    if ent:username eq 0 then {
			replace_inner("#main", my_form);
			watch("#myForm", "submit");
		}
  
  }
  
  rule store{
  select when web submit "#myform"
		pre {
			firstname = event:attr("firstname");
			lastname = event:attr("lastname");
			username = firstname + " " + lastname;
		}
		{
			replace_inner("#main", "Hello #{username}");
		}
		fired {
			set ent:firstname firstname;
			set ent:lastname lastname;
		}
  }
  
  rule display_name{
		select when pageview
		pre {
			html = "<p>Hello, " + ent:firstname + " " + ent:lastname"</p>";
		}
		if not ent:username eq 0 then {
			replace_inner("#main", html);
		}
  }

	rule clear{
		select when pageview
		if page:url("query").match(re/clear=1/) then {
			replace_inner("#main", "Data cleared");
		}
		fired {
			clear ent:firstname;
			clear ent:lastname;
		}
	}

}
