Cards = new Meteor.Collection 'cards'

Meteor.methods
  createCard: (data) ->
    data ?= {}
    if data.front? and data.back?
      Cards.insert data
