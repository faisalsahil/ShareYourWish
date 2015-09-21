jQuery ->
  
  jQuery("form#new_contribution #send_guest_contribution").click ->
    if jQuery("form#new_contribution").valid()
      jQuery("#contribution_form_wrapper").hide()
      jQuery("#checkout_confirmation").show()
      
  jQuery("#checkout_confirmation #submit_guest_contribution").click ->
    if jQuery("form#new_contribution").valid()
      jQuery(this).attr('disabled','disabled')
      jQuery("#checkout_confirmation").addClass('loading')
      jQuery("form#new_contribution").submit()
      
  jQuery("form#new_contribution #contribution_amount").change ->
    form = jQuery(this).parents("form")
    transaction_fee =  form.find('#transaction_fee')
    pay_transaction_fee = form.find('#contribution_pay_transaction_fee')
    if(pay_transaction_fee.is(':checked'))
      jQuery("#checkout_confirmation #total_amount").text((parseFloat(jQuery(@).val()) + parseFloat(transaction_fee.val())).toFixed(2))
    else
      jQuery("#checkout_confirmation #total_amount").text(parseFloat(jQuery(@).val()).toFixed(2))
  
  jQuery("form#new_contribution").submit ->
    if jQuery(this).valid()
      _this = this
      jQuery.ajax(
        url: jQuery(_this).attr('action')+'.json',
        type: 'POST'
        data: jQuery(_this).serialize()
        dataType: "json"
        success: (response) ->
          if response.result
            jQuery(_this).hide()
            jQuery('#contribution_form_with_buttons_wrapper').hide();
            jQuery('#contribution-given').show();
            jQuery('html, body').animate({ scrollTop: jQuery("#contribution_form_with_buttons_wrapper").offset().top - 80 }, 500)
          else
            jQuery.map(response.errors.contribution_errors, (error, property) ->
              nested_property_name = property.replace('payment.', 'payment_attributes_')
              element = jQuery('#contribution_' + nested_property_name)
              element.after('<label for="contribution_'+nested_property_name+'" generated="true" class="error" id="error_'+nested_property_name+'"> '+error+'</label>');
              element.addClass('invalid')
            )
            jQuery.map(response.errors.payment_errors, (error, property) ->
              jQuery('#contribution_form_wrapper #contribution_amount').after('<label for="contribution_payment_'+property+'" generated="true" class="error" id="error_'+property+'"> '+error+'</label>');
            )
            # show form 
            jQuery("#contribution_form_wrapper").show()
            jQuery("#checkout_confirmation").hide()
            jQuery("#checkout_confirmation #submit_guest_contribution").removeAttr('disabled')
            if jQuery(".error").length
              jQuery('html, body').animate({ scrollTop: jQuery(".error:first").offset().top - 40 }, 500)
         complete: ->
           jQuery("#checkout_confirmation").removeClass('loading')
      )
    false

  jQuery("#no_contribution_participate_button").on 'click', ->
    jQuery.ajax(
      url: jQuery(this).attr('data-url'),
      type: 'PUT'
      data:
        'guest[lookup_guests_status_id]': jQuery(this).attr('data-lookup-guests-status-id')
      success: ->
        alert("Thanks, we've sent your response to the Host. You can return and choose to participate at any time.")
    )
  jQuery("form#new_contribution #contribution_pay_transaction_fee, form.edit_contribution #contribution_pay_transaction_fee").on 'click', ->
    form = jQuery(this).parents("form")
    transaction_fee =  form.find('#transaction_fee')
    contribution_amount = form.find('#contribution_amount')
    pay_transaction_fee = form.find('#contribution_pay_transaction_fee')
    if(pay_transaction_fee.is(':checked'))
      jQuery("#checkout_confirmation #total_amount").text((parseFloat(contribution_amount.val()) + parseFloat(transaction_fee.val())).toFixed(2))
    else
      jQuery("#checkout_confirmation #total_amount").text(parseFloat(contribution_amount.val()).toFixed(2))
  jQuery("#active_admin_content #contribution_event_id").on 'change', ->
    event_id = jQuery(@).val()
    $('#active_admin_content #contribution_charity_id').load("/events/#{event_id}/charities");
    $('#active_admin_content #contribution_guest_id').load("/events/#{event_id}/guests");

