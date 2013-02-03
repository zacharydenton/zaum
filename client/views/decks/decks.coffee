Template.decks.decks = ->
  Decks.find()

Template.deck.events
  'click': ->
    Meteor.Router.to "/decks/#{@_id}"

Template.deck.numCards = ->
  @cards.length
