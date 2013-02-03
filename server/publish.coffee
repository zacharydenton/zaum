Meteor.publish 'decks', ->
  Decks.find()

Meteor.publish 'cards', (deckId) ->
  deck = Decks.findOne _id: deckId
  Cards.find _id: $in: deck.cards

Meteor.publish 'schedules', (deckId) ->
  Schedules.find user: @userId, deck: deckId
