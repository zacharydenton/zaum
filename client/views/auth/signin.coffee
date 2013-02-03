Template.signin.rendered = ->
  $('.signin').popover(
    html: true
    content: """
      <form id="signinForm">
      <input tabindex="1" id="signinEmail" class="input-block-level" type="text" placeholder="Email" />
      <input tabindex="2" id="signinPass" class="input-block-level" type="password" placeholder="Password" />
      <input tabindex="3" id="signinSubmit" class="btn btn-success btn-block" value="Sign in" type="submit" />
      </form>
    """
  ).click (e) ->
    $('#signinForm').submit (e) ->
      e.preventDefault()
      email = $('#signinEmail').val()
      pass = $('#signinPass').val()
      if email and pass
        Meteor.loginWithPassword email, pass
        Meteor.Router.to '/decks'
