Template.signout.events
  'click': (e) ->
    e.preventDefault()
    Meteor.logout()
    Meteor.Router.to '/'
