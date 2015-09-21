jQuery(function() {

    jQuery('#start_time_hours, #start_time_minutes, #start_time_noon').change(function(){
        if(jQuery('#start_time_noon').val() == 'AM')
        {
            jQuery('#event_start_time').val(jQuery('#start_time_hours').val() + ':' + jQuery('#start_time_minutes').val() + ':00')
        }
        else
        {
            var hours = parseInt(jQuery('#start_time_hours').val())+12;
            if(hours == 24) hours = '00';
            jQuery('#event_start_time').val(hours + ':' + jQuery('#start_time_minutes').val() + ':00');
        }
    });


    jQuery('#end_time_hours, #end_time_minutes, #end_time_noon').change(function(){
        if(jQuery('#end_time_noon').val() == 'AM')
        {
            jQuery('#event_end_time').val(jQuery('#end_time_hours').val() + ':' + jQuery('#end_time_minutes').val() + ':00')
        }
        else
        {
            var hours = parseInt(jQuery('#end_time_hours').val())+12;
            if(hours == 24) hours = '00';
            jQuery('#event_end_time').val(hours + ':' + jQuery('#end_time_minutes').val() + ':00');
        }
    });

    jQuery('#event_event_date_1i, #event_event_date_2i, #event_event_date_3i').change(function(){
    	var date = Date.parse(jQuery('#event_event_date_1i').val()+'.'+jQuery('#event_event_date_2i').val()+'.'+jQuery('#event_event_date_3i').val());
    	if(date != null){
	    	date.add({ days: -11 })
	    	jQuery('#event_rsvp_by_1i').val(date.toString('yyyy'))
	    	jQuery('#event_rsvp_by_2i').val(date.toString('M'))
	    	jQuery('#event_rsvp_by_3i').val(date.toString('d'))
		}
    });

	jQuery('#google_map_it').click(function(){
		if(jQuery('#event_location_address').val() != '') {
			var lnk='http://maps.google.com/?q='+jQuery('#event_location_address').val()
			window.open(lnk);
		}
		else {
			alert('Please enter a location before attempting to map it');
		}
		return false;
	});

    jQuery("#new_event, #edit_event").validate({ onkeyup: false, onkeydown: false,  onclick: true});

	// This forces select boxes to redraw for IE. When under jQueryUI, boxes in IE are rendering truncated until they are first clicked. This fixes that. Consider using globally/elsewhere
	jQuery('select').attr('style', '');
});

