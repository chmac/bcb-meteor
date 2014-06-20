if Meteor.isClient
  Template.open.rendered = ->
    elem = document.querySelector '.js-switch'
    init = new Switchery elem,
      secondaryColor: 'red'
