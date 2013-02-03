Decks = new Meteor.Collection 'decks'

Meteor.methods
  createDeck: (data) ->
    data ?= {}
    data.cards ?= []
    if data.title? and data.description?
      Decks.insert data
