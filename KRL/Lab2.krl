ruleset Lab2 {
    meta {
        name "notify example2"
        author "Pete Copeland"
        logging off
    }
    dispatch {
        domain "ktest.heroku.com"
    }
    rule first_rule {
        select when pageview ".*" setting ()
        notify("Hello World!", "This is my first message!");
        
    }
    rule second_rule {
        select when pageview ".*" setting ()
        notify("Hello World", "This is a third sample rule.");
    }
}
