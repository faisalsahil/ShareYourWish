jQuery ->
  
  charities_selected_list_type = () ->
    if jQuery("button.choose_button.active.featured_button").length
      '&list=featured'
    else if jQuery("button.choose_button.active.top_recommended_button").length
      '&list=top_recommended'
    else
      '&list=all'

  charity_paging_callback = () -> 
    jQuery('body.events .public_charity_details, body.charities .public_charity_details').unbind 'click'
    jQuery("body.charities .public_charity_details").on 'click', ->
      id = jQuery(this).attr('charity_id')
      jQuery('#popup_container').load '/charity/'+id+'?full=true&public=true' + charities_selected_list_type(), -> 
        charity_paging_callback()
      jQuery('.mixed_popup').togglePopup()
      false
    jQuery("body.events .public_charity_details").on 'click', ->
      id = jQuery(this).attr('charity_id')
      jQuery('#popup_container').load '/charity/'+id+'?full=true&public=true' + charities_selected_list_type(), ->
        jQuery('#popup_container .charity_paging').hide()
      jQuery('.mixed_popup').togglePopup()
      false
  
    jQuery('#popup_container .charity_paging .pagination a').unbind 'click'
    jQuery('#popup_container .charity_paging .pagination a').on 'click', ->
      jQuery('#popup_container').load jQuery(this).attr('href'), ->
        charity_paging_callback()
      false;
      
    jQuery('#close_popup_button').button();
  
  charity_paging_callback()
  
  jQuery('.all_button, .top_recommended_button, .featured_button, .other_button').button();

  jQuery('body.charities .featured_button').on 'click', ->
    jQuery('.charities_for_selection').load '/charities/?featured=true&public=true', ->
      jQuery('.choose_button.active').removeClass('active');
      jQuery('.choose_button.featured_button').addClass('active');
      charity_paging_callback()

  jQuery('body.charities .top_recommended_button').on 'click', ->
    jQuery('.charities_for_selection').load '/charities/?top_recommended=true&public=true', ->
      jQuery('.choose_button.active').removeClass('active');
      jQuery('.choose_button.top_recommended_button').addClass('active');
      charity_paging_callback()

  jQuery('body.charities .all_button').on 'click', ->
    jQuery('.charities_for_selection').load '/charities/?public=true', ->
      jQuery('.choose_button.active').removeClass('active');
      jQuery('.choose_button.all_button').addClass('active');
      charity_paging_callback()
      
  jQuery('.close_popup_button').button()
  jQuery('.close_popup_top_button, .close_popup_button').on 'click', ->
    jQuery('#popup').togglePopup()
    false

