Template.signup.rendered = ->
  langOptions = ("<option value='#{code}'>#{lang}</option>" for code, lang of languages).join('\n')
  $('.signup').popover
    html: true
    content: """
      <input tabindex="1" class="input-block-level" type="text" placeholder="Email" />
      <input tabindex="2" class="input-block-level" type="password" placeholder="Password" />
      <select tabindex="3" class="empty input-block-level language">
        <option value="" selected disabled>Native language?</option>
        #{langOptions}
      </select>
      <input tabindex="4" class="btn btn-success btn-block" value="Sign up" type="submit" />
    """
