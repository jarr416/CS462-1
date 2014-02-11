ruleset Lab2 {
    meta {
        name "notify example2"
        author "Pete Copelamd"
        logging off
    }
    dispatch {
        domain "ktest.heroku.com"
    }
    rule first_rule {
        select when pageview ".*" setting ()
        {
            notify("Hello World", "This is a sample rule.");
            notify("Hello World", "This is another sample rule.");
        }
    }
    rule second_rule {
        select when pageview ".*" setting ()
        notify("Hello World", "This is a sample rule.");
    }
}
