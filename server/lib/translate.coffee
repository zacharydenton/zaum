Meteor.methods
  translate: (options) ->
    options ?= {}
    term = options.term
    origin = options.origin ? 'auto'
    target = options.target ? 'en'
  
    params =
      client: 't'
      hl: 'en'
      multires: 1
      sc: 1
      sl: origin
      ssel: 0
      tl: target
      tsel: 0
      uptl: "en"
      text: term
  
    headers =
      'User-Agent': 'Mozilla/5.0'
    
    data = Meteor.http.get("https://translate.google.com/translate_a/t", params: params, headers: headers).content
    if data and data.length > 4 and data[0] == '['
      parsed = eval(data)
      parsed = parsed[0] and parsed[0][0] and parsed[0][0][0]
      return parsed
    return null
