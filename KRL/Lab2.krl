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
	    notify("Hello ", name) with sticky = true;
    }
}
