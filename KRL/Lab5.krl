ruleset lab5{
  meta{
  	author "Pete Copeland"
    use module a169x701 alias CloudRain
    use module a41x186  alias SquareTag
  }
  dispatch{
  }
  global{
    eci = "46EEE204-A4CD-11E3-BBE2-FD9FE71C24E1";
    ruleId = "b505161x5";
    eid = "1234567890";
    
    url = "https://cs.kobj.net/sky/event/" + eci + "/" + eid + "/foursquare/checkin?rids=" + ruleId;
  }

  rule process_fs_checkin{
    select when foursquare checkin
    
    pre{
      checkin = event:attr("checkin").decode();
		  venue = checkin.pick("$..venue");
		  city = checkin.pick("$..city");
		  shout = checkin.pick("$..shout");
		  createdAt = checkin.pick("$..createdAt");
    }
    
    fired{
      set ent:venue venue;
      set ent:city city;
			set ent:shout shout;
			set ent:createdAt createdAt;
			set ent:data event:attr("checkin").as("str");
    }
  }
  
  rule display_checkin{
    select when cloudAppSelected
	  pre {
		  venue = ent:venue.pick("$.name").as("str");
		  city = ent:city.as("str");
		  shout = ent:shout.as("str");
		  createdAt = ent:createdAt.as("str");
		  my_html = <<
			  <h2>Checkin Data:</h2>
			  <b>Venue: </b> #{venue}<br/>
			  <b>City: </b> #{city}<br/>
			  <b>Shout: </b> #{shout}<br/>
			  <b>Created: </b> #{createdAt}<br/>
			  <br/><br/>
			  >>;
	  }
	  CloudRain:createLoadPanel("Foursquare", {}, my_html);
  
  }
}
