Template.signup.rendered = ->
  langOptions = ("<option value='#{code}'>#{lang}</option>" for code, lang of languages).join('\n')
  $('.signup').popover(
    html: true
    content: """
      <form id="signupForm">
      <input tabindex="1" id="signupEmail" class="input-block-level" type="text" placeholder="Email" />
      <input tabindex="2" id="signupPass" class="input-block-level" type="password" placeholder="Password" />
      <select tabindex="3" id="signupLang" class="empty input-block-level language">
        <option value="0" selected disabled>Native language?</option>
        #{langOptions}
      </select>
      <input tabindex="4" id="signupSubmit" class="btn btn-success btn-block" value="Sign up" type="submit" />
      </form>
    """
  ).click (e) ->
    $('select.language').change ->
      if $(this).val() is "0"
        $(this).addClass("empty")
      else
        $(this).removeClass("empty")

    $('#signupForm').submit (e) ->
      e.preventDefault()
      email = $('#signupEmail').val()
      pass = $('#signupPass').val()
      lang = $('#signupLang').val()
      if email and pass and lang
        Accounts.createUser
          username: email
          email: email
          password: pass
          profile:
            lang: lang

