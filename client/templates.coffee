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
      

export {
  assetRowTemplate
  }
