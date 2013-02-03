Meteor.publish 'decks', ->
  Decks.find()

Meteor.publish 'cards', ->
  Cards.find()
