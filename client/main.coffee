import $ from 'jquery'
import _ from 'underscore'
import Backbone from 'backbone'

import Marionette from 'backbone.marionette'

import 'bootstrap'
# font-awesome 4.7
#import 'font-awesome/scss/font-awesome.scss'

# font-awesome 5
import "@fortawesome/fontawesome-free/scss/fontawesome.scss"
import "@fortawesome/fontawesome-free/scss/solid.scss"
import "@fortawesome/fontawesome-free/scss/regular.scss"


import App from './app'

# require default bootstrap
import "../node_modules/bootstrap/scss/bootstrap.scss"
import "../static/sass/screenly.scss"

app = new App

app.start()

