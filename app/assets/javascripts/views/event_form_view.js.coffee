class ShareYourWish.Views.EventFormView

  constructor: (@$el) ->
    @._eventHandlers = {}

  submit: ->
    $.ajax(
      url: @.$el.attr('action')
      type: 'PUT'
      data: @._serializedData()
      dataType: "json"
      success: (jqXHR) =>
        @.trigger("success", [@.$el, jqXHR])
      error: (jqXHR) =>
        @.trigger("error", [@.$el, jqXHR])
    )

  on: (eventName, handler) ->
    @._eventHandlers[eventName] = handler

  trigger: (eventName, args = []) ->
    @._eventHandlers[eventName].apply(@, args)

  _serializedData: ->
    if @._anyCharitySelected()
      @._charitiesData()
    else
      @.$el.serialize()

  _anyCharitySelected: ->
    @.$el.children('#selected_charities').length > 0

  _charitiesData: ->
    charityIds = []
    @.$el.find('.selected_charities .charity_container').each(->
      charityIds.push($(this).attr('data-id'))
    )
    data =
      'event[charity_ids][]': charityIds
      'event[step_id]': @.$el.children('#event_step_id').val()
      'event[state]': @.$el.children('#event_state').val()
    data
