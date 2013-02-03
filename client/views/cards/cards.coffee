chooseRandomCard = ->
  Session.set 'currentCard', _.shuffle(Template.cards.deck().cards)[0]

Template.cards.rendered = ->
  Meteor.autorun ->
    if Template.cards.deck() and not Session.get('currentCard')?
      chooseRandomCard()

Template.cards.deck = ->
  Decks.findOne _id: Session.get 'currentDeck'

Template.cards.card = ->
  Cards.findOne _id: Session.get 'currentCard'

Template.cards.events
  'click': ->
    chooseRandomCard()
