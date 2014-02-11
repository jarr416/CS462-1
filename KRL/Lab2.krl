ruleset Lab2 {
    meta {
        name "notify example2"
        author "Pete Copeland"
        logging off
    }
    dispatch {
    }
    rule first_rule {
        select when pageview '.*'{
            notify("Notify 1", "First") with sticky = true;
	    notify("Notify 2", "Second") with sticky = true;
	    }
    }
    rule second_rule {
	    select when pageview '.*'
	    pre {
		    name = page:url("query") => page:url("query") | "Monkey";
	    }
	    notify("Notify 3 ", "Hello " + name) with sticky = true;
    }
    rule third_rule {
	select when pageview '.*'
	pre {
	query = page:url("query");
            getName = function(string) {
                (string.extract(re/(?:name=)(\w*)/g)).join("")
            };
		name = getName(query)=> getName(query) | "Monkey";
	}
	notify("Notify 4", "Hello " + name) with sticky = true;
	}
	
rule fourth_rule {
    select when pageview '.*'
    pre {
      shouldClear = page:url("query").match(re/clear/);
    }
    if shouldClear then {
      notify("Cleared Count", "Count set to 0") with sticky = true;
    }
    fired {
      clear ent:count;
    }
  }
  
  rule fifth_rule {
	select when pageview '.*'
	if ent:count < 5 then {
		notify("Count Notification", "Count = " + ent:count) with sticky = true;
	}
	fired {
		ent:count += 1 from 0;
	}
  }
}
