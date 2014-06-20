Accounts.config
  sendVerificationEmail: true

@Log = new Meteor.Collection 'log'

Log.allow
  insert: (userId, obj) ->
    if not userId?
      throw new Meteor.Error 400, "Cannot insert unless logged in."
    _.extend obj,
      userId: userId
      'when': new Date()
  update: ->
    false
  remove: ->
    false

if Meteor.isClient
  Accounts.ui.config
    passwordSignupFields: 'USERNAME_AND_EMAIL'
  Template.open.rendered = ->
    elem = document.querySelector '.js-switch'
    init = new Switchery elem,
      secondaryColor: 'red'
