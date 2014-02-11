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
        each {
            notify("Hello World", "This is a sample rule.") with sticky = true;
            notify("Hello World", "This is another sample rule.") with sticky = true;
        }
    }
    rule second_rule {
        select when pageview ".*" setting ()
        each {
            notify("Hello World", "This is a third sample rule.") with sticky = true;
        }
    }
}
