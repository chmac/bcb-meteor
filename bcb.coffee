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

if Meteor.isServer
  Meteor.publish 'logs', ->
    Log.find()
    #Log.find {}, sort: [['when'], ['desc']]

if Meteor.isClient
  
  logsSubscription = Meteor.subscribe 'logs'

  Accounts.ui.config
    passwordSignupFields: 'USERNAME_AND_EMAIL'

  Template.openWrapper.ready = ->
    logsSubscription.ready()

  Template.open.rendered = ->
    elem = document.querySelector '.js-switch'
    init = new Switchery elem,
      secondaryColor: 'red'

  Template.open.open = ->
    log = Log.findOne {}, sort: [['when', 'desc']]
    log?.open

  Template.open.events
    'change input#open': (event) ->
      Log.insert open: event.target.checked
