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
        
        $('.social-links a.youtube').on('click', function(e){
            console.log(e);
            e.preventDefault();
            $('#youtube_modal .modal-body > div').html('<iframe width="560" height="315" src="' + $(this).attr('href') + '" frameborder="0" allowfullscreen></iframe>');
            $('#youtube_modal').modal();
        })
});