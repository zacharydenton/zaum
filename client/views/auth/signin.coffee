Template.signin.rendered = ->
  $('.signin').popover
    html: true
    content: """
      <input tabindex="1" class="input-block-level" type="text" placeholder="Email" />
      <input tabindex="2" class="input-block-level" type="password" placeholder="Password" />
      <input tabindex="3" class="btn btn-success btn-block" value="Sign in" type="submit" />
    """
