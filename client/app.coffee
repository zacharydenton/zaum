Meteor.subscribe 'decks'

Meteor.autosubscribe ->
  deckId = Session.get 'currentDeck'
  if deckId
    Meteor.subscribe 'cards', deckId
    Meteor.subscribe 'schedules', deckId, ->
      if Schedules.find().count() is 0
        Meteor.call 'createSchedules', deckId, @userId
