chooseNext = ->
  Session.set 'flipped', false
  Session.set 'currentSchedule', Schedules.findOne(date: $lt: Math.round(Date.now() / 1000))._id
  Session.set 'showTime', Date.now()

flipCard = ->
  Session.set 'flipped', true
  elapsed = Date.now() - Session.get 'showTime'
  if elapsed < 1000
    quality = 5
  else if elapsed < 2000
    quality = 4
  else if elapsed < 5000
    quality = 3
  else if elapsed < 10000
    quality = 2
  else
    quality = 1
  updateEfactor Session.get 'currentSchedule', quality
  updateInterval Session.get 'currentSchedule'

updateInterval = (scheduleId) ->
  schedule = Schedules.findOne _id: scheduleId
  repetition = schedule.repetition + 1
  interval = schedule.interval
  if repetition == 1
    interval = 1
  else if repetition == 2
    interval = 6
  else
    interval = Math.round(schedule.efactor * interval)
  Schedules.update _id: schedule._id,
    $set:
      repetition: repetition
      interval: interval
      date: schedule.date + (interval * (3600 * 24))

updateEfactor = (scheduleId, quality) ->
  schedule = Schedules.findOne _id: scheduleId
  if quality < 3
    Schedules.update _id: schedule._id,
      $set: repetition: 0
  else
    efactor = schedule.efactor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
    efactor = Math.max efactor, 1.3
    Schedules.update _id: schedule._id,
      $set: efactor: efactor

Template.cards.rendered = ->
  $('.card').attr('unselectable','on').css('UserSelect','none').css('MozUserSelect','none')
  Meteor.autorun ->
    if Schedules.find().count() > 0 and not Session.get 'currentSchedule'
      chooseNext()

Template.cards.deck = ->
  Decks.findOne _id: Session.get 'currentDeck'

Template.cards.card = ->
  schedule = Schedules.findOne(_id: Session.get 'currentSchedule')
  if schedule
    Cards.findOne _id: schedule.card

Template.cards.flipped = ->
  Session.get 'flipped'

Template.cards.events
  'click': (e) ->
    e.preventDefault()
    if Session.get 'flipped'
      chooseNext()
    else
      flipCard()

