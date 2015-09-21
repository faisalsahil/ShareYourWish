class ShareYourWish.Views.PictureUploaderView

  ERROR_MESSAGES:
    maxFileSize: "File is too big"
    minFileSize: "File is too small"
    acceptFileTypes: "Filetype not allowed"
    maxNumberOfFiles: "Max number of files exceeded"
    uploadedBytes: "Uploaded bytes exceed file size"
    emptyResult: "Empty file upload result"

  uploadTemplate: _.template([
    '<tr class="template-upload fade">'
    '<td class="preview"><span class="fade"></span></td>'
    '<td class="name"><%= name %></td>'
    '<td><div class="progress"><div class="bar" style="width:0%;"></div></div></td>'
    '<td class="start"><button class="btn btn-primary"><i class="icon-upload icon-white"></i> Start</button></td>'
    '<td class="cancel"><button class="btn btn-warning"><i class="icon-ban-circle icon-white"></i> Cancel</button></td></tr>'
  ].join(""))

  uploadErrorTemplate: _.template([
    '<tr class="template-upload fade">'
    '<td class="preview"><span class="fade"></span></td>'
    '<td class="name"><%= name %></td>'
    '<td class="error" colspan="2"><%= error %></td>'
    '<td class="cancel"><button class="btn btn-warning"><i class="icon-ban-circle icon-white"></i> Cancel</button></td></tr>'
  ].join(""))

  downloadTemplate: _.template([
    '<tr class="template-download fade">'
    '<td class="preview"><img src="<%= thumbnail_url %>"/></td>'
    '<td class="name" colspan="3"><a href="<%= url %>" rel="gallery"><%= name %></a></td>'
    '<td class="delete"><button class="btn btn-danger" data-type="<%= delete_type %>" data-url="<%= delete_url %>"><i class="icon-trash icon-white"></i> Delete</button></td></tr>'
  ].join(""))

  downloadErrorTemplate: _.template([
    '<tr class="template-download fade">'
    '<td class="error" colspan="5"><%= error %></td></tr>'
  ].join(""))

  constructor: (@$el) ->
    @._picturesPath = @.$el.attr("action")
    @._initFileUpload()
    @._initImageRemoteUrl()
    @._loadEventPictures()

  _initFileUpload: ->
    @.$el.fileupload(
      acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i
      maxFileSize: 7840000 # 1400 x 1400 32bit
      uploadTemplateId: null
      uploadTemplate: @._uploadTemplateBuilder
      downloadTemplateId: null
      downloadTemplate: @._downloadTemplateBuilder
    )

  _uploadTemplateBuilder: (data) =>
    _(data.files).map((file) =>
      file = @._adjustFileData(file)
      if file.error?
        @.uploadErrorTemplate(file)
      else
        @.uploadTemplate(file)
    )

  _downloadTemplateBuilder: (data) =>
    _(data.files).map((file) =>
      file = @._adjustFileData(file)
      if file.error?
        @.downloadErrorTemplate(file)
      else
        @.downloadTemplate(file)
    )

  _errorMsgFor: (error) ->
    @.ERROR_MESSAGES[error] || error

  _loadEventPictures: ->
    @._sendAjax(
      type: "GET"
    )

  _initImageRemoteUrl: ->
    $remoteUrlCont = @.$el.find(".image-remote-url-cont")
    $remoteUrlCont.find(".upload-image-remote-url").on("click", (event) =>
      event.preventDefault()
      @._postFormData()
      @._closeDialog($remoteUrlCont)
    )
    @.$el.find(".photo-by-url-btn").on("click", (event) ->
      event.preventDefault()
      $remoteUrlCont.toggle()
    )
    @.$el.find(".cancel-image-remote-url").on("click", (event) =>
      event.preventDefault()
      @._closeDialog($remoteUrlCont)
    )

  _closeDialog: ($remoteUrlCont) ->
    $remoteUrlCont.find("#picture_image_remote_url").val("")
    $remoteUrlCont.hide()

  _postFormData: ->
    $progressBar = @.$el.find(".remote-progress-bar")
    $progressBar.show()
    @._sendAjax(
      data: @.$el.serialize()
      done: ->
        $progressBar.hide()
    )

  _sendAjax: (params) ->
    defaultParams =
      type: "POST"
      url: @._picturesPath
      dataType: "json"
      context: @.$el[0]
    $.ajax(_(params).defaults(defaultParams)).done((result) ->
      doneFn = $(@).fileupload('option', 'done')
      doneFn.call(@, null, {result: result})
      params.done() if params.done?
    ).error((result) ->
      failFn = $(@).fileupload('option', 'fail')
      failFn.call(@, null, result)
    )

  _adjustFileData: (fileData) ->
    fileData["name"] = _(fileData.name).truncate(24) if fileData.name?
    fileData["error"] = @._errorMsgFor(fileData.error) if fileData.error?
    fileData
