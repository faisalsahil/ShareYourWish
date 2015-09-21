//= require active_admin/base
//= require jquery
//= require best_in_place
//= require contribution
//= require tinymce-jquery
//= require jquery.selectlist.pack

jQuery(document).ready(function() {
	jQuery(".best_in_place").best_in_place();
	jQuery('.editor').tinymce({
		theme : 'advanced',
		theme_advanced_toolbar_location : 'top',
		theme_advanced_toolbar_align : 'left',
		plugins : "paste",
		theme_advanced_buttons1 : "bold,italic,underline,sub,sup,separator,outdent,indent,separator,styleselect,formatselect,fontselect,fontsizeselect,separator,cut,copy,paste,pastetext,pasteword,undo,link,unlink,image,separator,cleanup,hr,removeformat,separator,cleanup,hr,removeformat,code",
		theme_advanced_buttons2 : false,
		theme_advanced_buttons3 : false
	});

	jQuery('.help_editor').tinymce({
		theme : 'advanced',
		theme_advanced_toolbar_location : 'top',
		theme_advanced_toolbar_align : 'left',
		theme_advanced_buttons1 : "bold,italic,bullist,link,unlink,code",
		theme_advanced_buttons2 : false,
		theme_advanced_buttons3 : false
	});
	maxHeight('table.index_table tbody .text, table.index_table tbody .description, table.index_table tbody .content','180')
	

	// posts_tags_select
	jQuery('#edit_post select#posts_tags_select, #new_post select#posts_tags_select').selectList({
		onRemove: function (select, value, text) {
			var options = []
			jQuery(select).find('option').each( function(){ 
				options.push( jQuery('.selectlist-select').find('option[value='+ jQuery(this).val() +']').text() )
			})
			jQuery('#post_tag_list').val(options.join(','))
		}, 
		onAdd: function (select, value, text) {
			var options = []
			jQuery('.selectlist-select').find('option:selected, option:disabled').each( function(){ options.push(jQuery(this).text()) })
			jQuery('#post_tag_list').val(options.join(','))
		}
	})
	
});

function maxHeight(selector, size) {
	// if ($.browser.msie) {
		$(selector).each(function() {
			var wraper = $('<div></div>').css({
				margin : 0,
				padding : 0
			});
			$(this).wrapInner(wraper);
			var realhight = $(this).children('div').innerHeight();
			if (realhight > size) {
				$(this).children('div').height(size);
				$(this).children('div').css('overflow-y','scroll')
				
			}
			//wraper.remove();
		})
	//}
};

