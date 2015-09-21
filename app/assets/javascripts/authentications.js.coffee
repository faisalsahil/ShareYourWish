jQuery ->
  authentications.initialize()

authentications =
  initialize: ->
    @handleProfileForm()

  link_facebook_account: ->
    ($ '#link_facebook_account')
  facebook_linked: ->
    ($ '#facebook-linked')
  unlink_facebook_account: ->
    ($ '#unlink_facebook_account')
  facebook_link: ->
    ($ '#facebook-link')
  link_google_account: ->
    ($ '#link_google_account')
  google_linked: ->
    ($ '#google-linked')
  unlink_google_account: ->
    ($ '#unlink_google_account')
  google_link: ->
    ($ '#google-link')
  link_twitter_account: ->
    ($ '#link_twitter_account')
  twitter_linked: ->
    ($ '#twitter-linked')
  unlink_twitter_account: ->
    ($ '#unlink_twitter_account')
  twitter_link: ->
    ($ '#twitter-link')

  handleProfileForm: ->
    _this = this
    @unlink_facebook_account().live "click", ->
      jQuery.ajax(
        url: ($ @).attr('href'),
        type: 'DELETE'
        success: (response) ->
          _this.facebook_linked().hide()
          _this.facebook_link().show()
      )
      false
      
    @unlink_google_account().live "click", ->
      jQuery.ajax(
        url: ($ @).attr('href'),
        type: 'DELETE'
        success: (response) ->
          _this.google_linked().hide()
          _this.google_link().show()
      )
      false
      
    @unlink_twitter_account().live "click", ->
      jQuery.ajax(
        url: ($ @).attr('href'),
        type: 'DELETE'
        success: (response) ->
          _this.twitter_linked().hide()
          _this.twitter_link().show()
      )
      false

this.authentications = authentications
