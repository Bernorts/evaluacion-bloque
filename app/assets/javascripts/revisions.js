var ready;
ready = function() {
	$('.level-select').change(function(){
		var card_num = $(this).data('level_select');
		if ($('#level_select-' + card_num).val() != '0'){
			$('#collapse-' + card_num).collapse('show');
		} else{
			$('#collapse-' + card_num).collapse('hide');
		}
	});
}

$(document).on('ready turbolinks:load', ready);
