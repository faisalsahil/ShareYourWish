jQuery(function() {
    // When is this called? No other refs to it in the code that I can fund
	// no object with class 'validate_event_button'
    jQuery('.validate_event_button').click(function(){
      var _this = this
      var property = jQuery(_this).attr('data-validate-property')
      var element = jQuery('#event_' + property)
      jQuery.post(jQuery(_this).attr('href'), { value: element.val() }, function(response){
        jQuery('#tabs a[href="#tabs-' + this.id + '"]').attr('class',this.state).attr('title',this.message)
        element.removeClass('valid').removeClass('invalid')
        jQuery('#error__'+property).remove();
        if(response.result)
          element.addClass('valid')
        else
        {
          jQuery(_this).after('<label for="event_'+property+'" generated="true" class="error" id="error__'+property+'"> '+response.errors[property]+'</label>');
          element.addClass('invalid')
        }
      });
      return false;
    });
});
