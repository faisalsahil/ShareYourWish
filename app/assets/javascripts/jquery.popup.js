//additional properties for jQuery object
jQuery(document).ready(function(){
    //align element in the middle of the screen
    jQuery.fn.alignCenter = function() {
        //get margin left
        var marginLeft = Math.max(40, parseInt(jQuery(window).width()/2 - jQuery(this).width()/2)) + 'px';
        //get margin top
        var marginTop = Math.max(40, parseInt(jQuery(window).height()/2 - jQuery(this).height()/2)) + 'px';
        //return updated element
        return jQuery(this).css({
            'margin-left':marginLeft, 
            'margin-top':marginTop
        });
    };

    jQuery.fn.togglePopup = function(){
        //detect whether popup is visible or not
        if(jQuery('#popup').hasClass('hidden'))
        {
            //hidden - then display
            //when IE - fade immediately
            if(jQuery.browser.msie)
            {
                jQuery('#opaco').height(jQuery(document).height()).toggleClass('hidden');
            }
            else
            //in all the rest browsers - fade slowly
            {
                jQuery('#opaco').height(jQuery(document).height()).toggleClass('hidden').fadeTo('slow', 0.7);
            }

            jQuery('#popup')
            .append(jQuery(this).children())
            .alignCenter()
            .toggleClass('hidden');
        }
        else
        {
            //visible - then hide
            jQuery('#opaco').toggleClass('hidden').removeAttr('style');
            jQuery('#popup').toggleClass('hidden');
        }
        
        
    };
    
    jQuery(document).click(function(){
        if(!jQuery('#opaco').hasClass('hidden')){
            jQuery('#popup').each(function(){
                if(!jQuery(this).hasClass('hidden')){
                    jQuery('#opaco').toggleClass('hidden').removeAttr('style');
                    jQuery(this).toggleClass('hidden');
                }
            });	
        }
    });
    
	//TO DO: Fix. This is defunct, what did this refer to?
    jQuery('#browse_charity_button, #popup, #show_invitations_popup_button, .charity_details, .public_charity_details, .event_page_faq_btn').click(function(e){
        e.stopPropagation();
    });

});
