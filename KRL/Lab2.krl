ruleset Lab2 {
    meta {
        name "notify example"
        author "Pete Copelamd"
        logging off
    }
    dispatch {
        domain "ktest.heroku.com"
    }
    rule first_rule {
        select when pageview ".*" setting ()
        notify("Hello World", "This is a sample rule.") with sticky = true;
        notify("Hello World", "This is another sample rule.") with sticky = true;
    }
}
