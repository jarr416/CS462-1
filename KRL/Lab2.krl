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
        every {
            notify("Hello World!", "This is my first message!");
            notify("Hello Again!", "This is my second message!");
        }
    }
    rule second_rule {
        select when pageview ".*" setting ()
        every {
            notify("Hello World", "This is a third sample rule.");
        }
    }
}
