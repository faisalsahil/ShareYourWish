jQuery(function() {

	var event_id = jQuery('#event_id').val();
	addCharityCallbacks();

	jQuery('#step_select-charity, .featured_button, #event_details_button').click(function() {
		jQuery('.charities_for_selection').load('/charities/' + event_id + '/?featured=true' + get_selected_charities(), function() {
			addCharityCallbacks();
			jQuery('.choose_button.active').removeClass('active');
			jQuery('.choose_button.featured_button').addClass('active');
		});
	});

	jQuery('.top_recommended_button').click(function() {
		jQuery('.charities_for_selection').load('/charities/' + event_id + '/?top_recommended=true' + get_selected_charities(), function() {
			jQuery('.choose_button.active').removeClass('active');
			jQuery('.choose_button.top_recommended_button').addClass('active');
			addCharityCallbacks();
		});
	});

	jQuery('.all_button').click(function() {
		jQuery('.charities_for_selection').load('/charities/' + event_id + '/?' + get_selected_charities(), function() {
			jQuery('.choose_button.active').removeClass('active');
			jQuery('.choose_button.all_button').addClass('active');
			addCharityCallbacks();
		});
	});

	var search_event = function() {
		var params = [];
		var region = (jQuery("#search_by_region option:selected").val() != '') ? encodeURI(jQuery("#search_by_region option:selected").text()) : '';
		if (region.length > 0)
			params.push('region=' + region)
		var ntee_code = jQuery('#search_by_ntee_code').val();
		if (ntee_code.length)
			params.push('lookup_charity_code_id=' + ntee_code)
		var name = encodeURI(jQuery('#search_by_name').val());
		if (name.length)
			params.push('name=' + name)
		jQuery('.charities_for_selection').load('/charities/' + event_id + '/?' + params.join('&') + get_selected_charities(), function() {
			addCharityCallbacks();
		});
	}

	jQuery('#search_by_name').keypress(function(e) {
		if (e.which == 13) {
			jQuery('#search_by_name_button').click();
			return false;
		}
	});

	jQuery('#search_by_name_button').click(function() {
		if (jQuery('#search_by_name').val().length)
			search_event();
	});

	jQuery('#search_by_region, #search_by_ntee_code, #search_by_name').change(function() {
		search_event();
	});

	jQuery('#search_by_name_clear_button').click(function() {
		jQuery('#search_by_region, #search_by_ntee_code, #search_by_name').val('');
		jQuery('.featured_button').click();
	});

});

var get_selected_charities = function() {
	var selected_charities = [];
	jQuery('.selected_charities .charity_container').each(function() {
		selected_charities.push('selected_charities[]=' + jQuery(this).attr('data-id'))
	});
	return selected_charities.length ? '&' + selected_charities.join('&') : ''
}

function addCharityCallbacks() {
	jQuery('.charity_details').unbind('click');
	jQuery('.charity_details').click(function() {
		var id = jQuery(this).attr('charity_id')
		var charities_list = jQuery('#charity-filter-buttons button.active').data('list')
		if (jQuery(this).parents('.as').attr('id') == 'charities_for_selection') {
			if (!jQuery('#popup_container #charity_' + id).length) {
				jQuery('#popup_container').load('/charity/' + id + '?full=true&list='+charities_list+get_selected_charities(), function() {
					addCharityFullCallbacks();
				});
			}
			jQuery('#popup_container .remove_charity_f_button').hide();
			jQuery('#popup_container .add_charity_f_button').show();

		} else {
			jQuery('#popup_container').load('/charity/' + id + '?full=true&picked=true&list='+charities_list+get_selected_charities(), function() {
				addCharityFullCallbacks();
			});
		}
		jQuery('.mixed_popup').togglePopup();
		return false;
	});

	jQuery('.add_charity_button').unbind('click');
	jQuery(".add_charity_button").click(function() {
		if (jQuery('.selected_charities .charity_container').length < 3)// allow only 3 charity selections
		{
			var form_id = 'form.edit_event:visible'
			if (jQuery(form_id).length)
				jQuery(form_id).attr('changed', 'true')

			jQuery(this).hide();
			if (jQuery(this).parents('div.charity_container').length > 0)// was the button pressed inside a small charity div
			{
				var el = jQuery(this).parents('div.charity_container').clone(true)
				jQuery('.selected_charities').append(el);
				jQuery(el).find('input.remove_charity_button').show();
				jQuery('.charities_for_selection #' + jQuery(el).attr('id') + ' .charity_selected_check').removeClass('hidden');
				jQuery('html, body').animate({
					scrollTop : jQuery('#syw-logo').offset().top
				}, 500);
			} else if (jQuery(this).parents('div.charity_container_full').length > 0) // was the button pressed popup charity
			{
				jQuery('.charities_for_selection #' + jQuery(this).parents('div.charity_container_full').attr('id') + ' .add_charity_button').click();
			}
		}
	});

	jQuery('.remove_charity_button').unbind('click');
	jQuery(".remove_charity_button").click(function() {
		var form_id = 'form.edit_event:visible'
		if (jQuery(form_id).length)
			jQuery(form_id).attr('changed', 'true')
		jQuery('.charities_for_selection #' + jQuery(this).parents('div.charity_container').attr('id') + ' .add_charity_button').show().css('display', 'block');
		jQuery('.charities_for_selection #' + jQuery(this).parents('div.charity_container').attr('id') + ' .charity_selected_check').addClass('hidden');
		jQuery(this).parents('div.charity_container').detach();
	});

	jQuery('.add_charity_button').button();
	jQuery('.remove_charity_button').button();

}

function addCharityFullCallbacks() {
	jQuery('.add_charity_f_button').unbind('click');
	jQuery(".add_charity_f_button").click(function() {
		if (jQuery('.selected_charities .charity_container').length < 3) {
			jQuery('.charities_for_selection #' + jQuery(this).parents('div.charity_container_full').attr('id') + ' .add_charity_button').click();
			jQuery(this).next('.remove_charity_f_button').show().css('display', 'block');
			jQuery(this).hide();
		}
	});

	jQuery('.remove_charity_f_button').unbind('click');
	jQuery(".remove_charity_f_button").click(function() {
		jQuery('.charities_for_selection #' + jQuery(this).parents('div.charity_container_full').attr('id') + ' .add_charity_button').show().css('display', 'block');
		jQuery('.charities_for_selection #' + jQuery(this).parents('div.charity_container_full').attr('id') + ' .charity_selected_check').addClass('hidden');
		jQuery('.selected_charities #' + jQuery(this).parents('div.charity_container_full').attr('id')).detach();
		jQuery(this).prev('.add_charity_f_button').show().css('display', 'block');
		jQuery(this).hide();
	});

	jQuery('#popup_container .charity_paging .pagination a').unbind('click');
	jQuery('#popup_container .charity_paging .pagination a').click(function() {
		jQuery('#popup_container').load(jQuery(this).attr('href'), function() {
			addCharityFullCallbacks();
		});
		return false;
	});

	jQuery('.add_charity_f_button').button();
	jQuery('.remove_charity_f_button').button();

}

