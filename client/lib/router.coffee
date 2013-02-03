Meteor.Router.add
  '/': 'landing'
  '/decks': 'decks'
  '/decks/:id': (id) ->
    Session.set 'currentDeck', id
    'cards'
