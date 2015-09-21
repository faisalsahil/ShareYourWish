jQuery(function() {

    // Goodies
    jQuery('form#goodies input[type=radio]').click(function(){
        alert('Switching Packages Will Reset Your Cart And All Goodie Selections');
		  //jQuery.post('/events/'+jQuery('#event_id').val()+'/clear_carts');
        //jQuery.get('/package/'+jQuery(this).val()+'/items', function(data) {
        //    jQuery('.items_container').html(data);
        // }, "html");
    });

   jQuery('.package_select_button').click(function(){
        if(confirm('Changing packages will reset all items in your Cart. Continue?'))
            jQuery('.package_select_button').toggleClass('hidden_important');
        else
            return false;
   })

});

// Goodies

function add_to_cart(item_id)
{
    jQuery.ajax({
        url: '/line_items.json',
        type: 'POST',
        data:{		"line_item[item_id]":item_id, 
						"line_item[quantity]":jQuery('#item_qty_'+item_id).val()
			}
    });
}

function delete_cart(field, item_id)
{
    jQuery.ajax({
        url: '/carts',
        type: 'DELETE',
        data:{"cart[event_id]":jQuery('#event_id').val(),"cart[item_id]":item_id}
    });
    jQuery('#item_' + item_id + '.item_container').remove();
}