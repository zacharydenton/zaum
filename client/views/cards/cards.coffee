chooseNext = ->
  Session.set 'flipped', false
  Session.set 'currentSchedule', Schedules.findOne(date: $lt: Math.round(Date.now() / 1000))._id
  Session.set 'showTime', Date.now()

flipCard = ->
  Session.set 'flipped', true
  elapsed = Date.now() - Session.get 'showTime'
  if elapsed < 500
    quality = 5
  else if elapsed < 1000
    quality = 4
  else if elapsed < 2000
    quality = 3
  else if elapsed < 10000
    quality = 2
  else
    quality = 1
  updateEfactor Session.get('currentSchedule'), quality
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
  console.log quality
  if quality < 3
    Schedules.update _id: schedule._id,
      $set:
        repetition: 0
        quality: quality
  else
    efactor = schedule.efactor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
    efactor = Math.max efactor, 1.3
    Schedules.update _id: schedule._id,
      $set:
        efactor: efactor
        quality: quality

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

Template.cards.remaining = ->
  Schedules.find(date: $lt: Math.round(Date.now() / 1000)).count()

Template.cards.total = ->
  Schedules.find().count()

Template.cards.completed = ->
  Template.cards.total() - Template.cards.remaining()

Template.cards.good = ->
  good = Schedules.find
    date: $gt: Math.round(Date.now() / 1000)
    quality: $gt: 3
  Math.round(good.count() / Template.cards.total() * 100)

Template.cards.okay = ->
  okay = Schedules.find
    date: $gt: Math.round(Date.now() / 1000)
    quality: 3
  Math.round(okay.count() / Template.cards.total() * 100)

Template.cards.bad = ->
  bad = Schedules.find
    date: $gt: Math.round(Date.now() / 1000)
    quality: $lt: 3
  Math.round(bad.count() / Template.cards.total() * 100)

Template.cards.events
  'click .card': (e) ->
    e.preventDefault()
    if Session.get 'flipped'
      chooseNext()
    else
      flipCard()

