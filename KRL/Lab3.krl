ruleset Lab3{

  rule show_form{
    select when pageview
    pre{
      text = <<  
        <p>This is a paragraph. Aren't you proud of me?</p>
        <form id="myForm" >
        <input type="text" name="firstname" />
				<input type="text" name="lastname" />
				<input type="submit" value = "Submit"/>
        </form>
      >>;
    }
  
  }


}