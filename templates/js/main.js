$(document).ready(function(){
	$('[data-lang="'+LANGUAGE+'"]').parent().addClass('active');
	LANGUAGE_TEXT = $('[data-lang="'+LANGUAGE+'"]').text();
	$('.lang_text').text(LANGUAGE_TEXT);

	$('.dropdown_lang a').click(function(){
		var lang = $(this).data('lang');
		$.post(BASE_URL+'/ajax-language/action:set/lang:'+lang, function(data) {
		  location.reload();
		});
	});
        
        
});