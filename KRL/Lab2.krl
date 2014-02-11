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
        every {
            notify("Hello World!", "This is my first message!");
            notify("Hello World!", "This is my second message!");
        }
        
    }
    rule second_rule {
        select when pageview ".*" setting ()
        pre {
            query = page:url("query");
        }
        notify("Hello World", "Hello Monkey ");
    }
}
