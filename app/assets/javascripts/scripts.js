jQuery(document).ready(function(){
	jQuery('.dismiss').on('click', function(e) {
		e.preventDefault;
		jQuery('.flash').fadeOut();
	});
});