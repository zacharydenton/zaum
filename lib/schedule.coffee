Schedules = new Meteor.Collection 'schedules'

Meteor.methods
  'createSchedule': (data) ->
    data ?= {}
    if data.card and data.user and data.deck
      data.date = Math.round(Date.now() / 1000)
      data.repetition = 0
      data.efactor = 2.5
      data.interval = 1
      data.quality = 5
      Schedules.insert data
  'createSchedules': (deckId, userId) ->
    deck = Decks.findOne _id: deckId
    for cardId in deck.cards
      Meteor.call 'createSchedule',
        card: cardId
        user: userId
        deck: deckId
