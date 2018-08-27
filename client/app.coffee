import Backbone from 'backbone'

import Marionette from 'backbone.marionette'

class App extends Marionette.Application
  initialize: (options) ->
    console.log "app.initialize called"

  region: 'body'

  onStart: ->
    Backbone.history.start()


export default App

