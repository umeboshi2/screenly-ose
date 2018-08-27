import tc from 'teacup'

assetRowTemplate = tc.renderable (model) ->
  tc.td '.asset_row_name', ->
    tc.img src:"static/img/drag-handle.png"
    tc.i '.asset-icon'
    model.name
  tc.td style:"width:21%", model.start_date
  tc.td style:"width:21%", model.end_date
  tc.td '.asset_row_btns', ->
    tc.button ".download-asset-button.btn.btn-outline-secondary",
    type:'button', ->
      tc.i '.fas.fa-download'
    tc.button ".edit-asset-button.btn.btn-outline-secondary",
    type:'button', ->
      tc.i '.fas fa-pencil-alt'
    tc.button '.delete-asset-button.btn.btn-outline-secondary',
    data:html:"true", data:placement:"left", data:title:"Are you sure?",
    data:trigger:"manual", type:"button", ->
      tc.i ".far.fa-trash-alt"
  tc.td ".asset-toggle", style:"width:7%", ->
    tc.label ".is_enabled-toggle.checkbox.toggle.card.card-body.bg-light", ->
      tc.input type:"checkbox"
      tc.p ->
        tc.span '.on', "On"
        tc.span '.off', "Off"
      tc.a ".slide-button.btn.btn-primary"
      
confirmDeleteTemplate = tc.renderable ->
  tc.div '.popover-delete-content', ->
    tc.div '.float-left', ->
      tc.a '.confirm-delete.btn.btn-danger', href:'#', "Delete"
    tc.div ".float-right", ->
      tc.a '.cancel-delete.btn.btn-outline-secondary', href:"#", "Cancel"
      
processingMessageTemplate = tc.renderable ->
  tc.label ".processing-message", "Asset in processing"
  

requestErrorTemplate = tc.renderable ->
  tc.div ".container", ->
    tc.div ".alert.alert-danger", ->
      tc.button ".close", data:dismiss:"alert", type:"button", "&times"
      msg = "The operation failed. Please reload the page and try again."
      tc.span ".msg", msg

assetModalFieldset = tc.renderable ->
  tc.fieldset ->
    tc.div ".tabbable", ->
      tc.ul ".nav.nav-tabs", ->
        tc.li ".tabnav-uri.nav-item.active.show",
        style:"margin-left:180px", ->
          tc.a ".nav-link", href:"#tab-uri", "URL"
        tc.li ".tabnav-file_upload.nav-item", ->
          tc.a ".nav-link", href:"#tab-file_upload", "Upload"
      tc.div ".tab-content", ->
        tc.div "#tab-uri.tab-pane.active"
        tc.div "#tab-file_upload.tab-pane", ->
          tc.div ".control-group", ->
            tc.div ".filedrop", ->
              tc.div ".upload-header", ->
                tc.button ".btn", "Add Files.."
                tc.input name:"file_upload", type:"file"
                tc.br()
                tc.text "or"
              tc.div "drop files here to upload"
  
assetModalAddForm = tc.renderable ->
  tc.form "#add-form", ->
    tc.div ".form-group.row.uri", ->
      tc.label ".col-4.col-form-label", "Asset URL"
      tc.div ".col-7.controls", ->
        placeholder = "Public URL to this asset's location"
        tc.input ".form-control", name:'uri',
        placeholder:placeholder, type:'text'
      tc.div ".asset-location.edit", style:"display:none", ->
        tc.div '.form-group.row.name', ->
          tc.label ".col-4.col-form-label", "Name"
          tc.div ".col-7", ->
            placeholder = "Nickname for this asset"
            tc.input ".form-control", name:"name",
            placeholder:placeholder, type:"text"
        tc.div '.form-group.row', ->
          tc.label ".col-4.col-form-label", "Asset Location"
          tc.div ".col-8.controls", ->
            tc.div ".uri-text.first"
        tc.div '.form-group.row.mimetype', ->
          tc.label ".col-4.col-form-label", "Asset Type"
          tc.div ".col-4.controls", ->
            tc.select ".mime-select.form-control",
            name:"mimetype", ->
              tc.option value:"webpage", "Webpage"
              tc.option value:"image", "Image"
              tc.option value:"video", "Video"
              tc.option value:"streaming", "Streaming"
              tc.option value:"youtube_asset", "YouTubeAsset"
        tc.hr()
        tc.div ".form-group.row.start_date", ->
          tc.label ".col-4.col-form-label", "Start Date"
          tc.div ".col-7.controls", ->
            tc.input ".form-control.date", name:"start_date_date",
            type:"text", style:"margin-right:5px"
            tc.input ".form-control.time", name:"start_date_time",
            type:"text"
          tc.input name:"start_date", type:"hidden"
        tc.div ".form-group.row.end_date", ->
          tc.label ".col-4.col-form-label", "End Date"
          tc.div ".col-7.controls", ->
            tc.input ".form-control.date", name:"end_date_date",
            type:"text", style:"margin-right:5px"
            tc.input ".form-control.time", name:"end_date_time",
            type:"text"
          tc.input name:"end_date", type:"hidden"
        tc.div ".form-group.row.duration", ->
          tc.label ".col-4.col-form-label", "Duration"
          tc.div ".col-7.controls", ->
            tc.input ".form-control", name:"duration",
            type:"number", "seconds &nbsp"
        tc.div ".advanced-accordion.accordion",  ->
          tc.div ".accordion-group", ->
            tc.div ".accordion-heading", ->
              tc.i ".fas.fa-play.unrotated"
              tc.a ".advanced-toggle", href:"#", "Advanced"
            tc.div ".collapse-advanced.accordion-body.collapse", ->
              tc.div ".accordion-inner", ->
                tc.div ".form-group.row", ->
                  tc.label ".col-4.col-form-label", "Disable cache"
                  tc.div ".col-8.nocache.controls", ->
                    cardClasses = ".card.card-body.bg-light"
                    lblClasses = ".nocache-toggle.checkbox#{cardClasses}" # noqa 
                    tc.label lblClasses, ->
                      tc.input ".form-control", name:"nocache",
                      type:"checkbox"
                      tc.p ->
                        tc.span ".on", "Yes"
                        tc.span ".off", "No"
                      tc.a ".slide-button.btn.btn-primary"
  

assetModalTemplate = tc.renderable (model) ->
  tc.div ".modal.hide.fade", aria:hidden:"true",
  aria:labelledby:"myModalLabel", role:"dialog", tabindex:"-1", ->
    tc.div '.modal-dialog', role:"document", ->
      tc.div ".modal-content", ->
        tc.div ".form-horizontal", ->
          tc.div ".modal-header", ->
            tc.h3 "#modalLabel", "Add Asset"
          tc.div ".modal-body", ->
            tc.div ".asset-location.add", ->
              assetModalFieldset()
              assetModalAddForm()
          tc.div ".modal-footer", ->
            tc.div ".status"
            tc.div ".float-left.progress.active", style:"display:none", ->
              progressClasses = ".progress-bar-striped.progress-bar"
              progressClasses = "#{progressClasses}.progress-bar-animated"
              tc.div ".bar#{progressClasses}"
            tc.input ".btn.btn-outline-secondary.cancel", type:"button",
            value:"Cancel"
            tc.input "#save-asset.btn.btn-primary", type:"submit", value:"Save"


export {
  assetRowTemplate
  confirmDeleteTemplate
  processingMessageTemplate
  requestErrorTemplate
  assetModalTemplate
  }
