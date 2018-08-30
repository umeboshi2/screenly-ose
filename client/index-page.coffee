import tc from 'teacup'
import {indexBody} from './templates'

baseBody = tc.renderable ->
  tc.body ->
    tc.div '#root-div.container-fluid', ->
      tc.div '.row', ->
        tc.div '.col-sm-2'
        tc.div '.col-sm-6.jumbotron', ->
          tc.h1 ->
            tc.text 'Loading ...'
            tc.i '.fa.fa-spinner.fa-spin'
        tc.div '.col-sm-2'
  

blankPage = tc.renderable ->
  tc.doctype()
  tc.html xmlns:'http://www.w3.org/1999/xhtml', ->
    tc.head ->
      tc.meta charset:'utf-8'
      #tc.meta name:'viewport', content:"width=device-width, initial-scale=1"
      tc.title "Screenly OSE"
    #baseBody()
    indexBody
      up_to_date: true
      player_name: "PlayerName"
 
export default blankPage
