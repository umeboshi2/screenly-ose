import $ from 'jquery'
import _ from 'underscore'
import Backbone from 'backbone'

import Marionette from 'backbone.marionette'

import 'bootstrap'
import 'font-awesome/scss/font-awesome.scss'

import App from './app'

# require default bootstrap
require "../node_modules/bootstrap/scss/bootstrap.scss"

app = new App

app.start()

