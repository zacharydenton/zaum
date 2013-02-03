require = __meteor_bootstrap__.require
path = require('path')
base = path.resolve('.')
isBundle = path.existsSync(base + '/bundle')
publicPath = base + (if isBundle then '/bundle/static' else '/public')

Meteor.startup ->
  if Decks.find().count() is 0
    data = require(path.resolve(publicPath, 'data.json'))
    for lang, words of data
      if languages[lang]
        cards = []
        total = 0
        for wordCount in words
          total += parseInt wordCount[1]

        runningTotal = 0
        for wordCount, i in words
          runningTotal += parseInt wordCount[1]
          break if runningTotal / total > 0.6
          word = wordCount[0]
          card_id = Cards.insert
            front: word
            back:
              en: Meteor.call('translate',
                term: word
                origin: lang
                target: 'en'
              )
          cards.push card_id

        Decks.insert
          title: "#{languages[lang]}"
          description: "A course designed to teach you the core of #{languages[lang]} as quickly as possible."
          cards: cards
