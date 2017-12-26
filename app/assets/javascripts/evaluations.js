var ready;
ready = function() {

	function showCollapse(){
		var id;
		$('select').each(function(){
			if ($(this).val() != '0'){
				id = $(this).data('level_select');
				$('#collapse-' + id).addClass('show');
			}
		});
	}

	showCollapse();


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
