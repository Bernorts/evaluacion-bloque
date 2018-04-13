App.interviews = App.cable.subscriptions.create('InterviewsChannel', {
  received: function(data) {
  	console.log('Cable en received');
    return $("#participants-" + data.evaluation_competence_id).append(this.addParticipant(data));
  },

  addParticipant: function(data) {
    console.log(data)
    var all_levels = JSON.parse(data.all_levels);
    row = "<tr>" + 
	    	"<td>" + data.evaluation_user + "</td>" + 
	    	"<td>" + 
	    		"<select class='form-control'>" + 
					"<option value='true'>Responsable</option>" +
					"<option value='false' selected>Evaluador</option>" +
			  	"</select>" + 
		  	"</td>";

	row += "<td>" + "<select class='form-control'>";
	
	for(var key in all_levels){
		row += "<option value=" + key + ">" + all_levels[key] + "</option>";
	}

	row += "</select>" + "</td>" + "</tr>";

    return row;
  }
});

/*

$.ajax({
    url: $(this).attr("href"),
    success: function(data) {
      console.log("DATA", data);
        $(data).appendTo(".modal-lg");
        changeSubmitToAjax('#editEvidence', '.edit_evidence', "Edición exitosa!");
        $('#editEvidence').modal('show');
    }
});

*/


$( document ).ready(function() {
	var competence_id;
	var professor_id;
	var role;
	var level_id;
	var retro;
	var final_level;
	var responsible_id;

	$('.inter-role-select').on('change', function() {
   		role = this.value;
   		competence_id = $(this).data("comp");
   		professor_id = $(this).data("evaluator");

   		if(role == 'true'){
   			$(this).attr('data-responsible', 'true');
   		} else{
   			$(this).removeAttr('data-responsible');
   		}

   		console.log('Role: ', role);
   		console.log('Competence_id: ', competence_id);
   		console.log('Professor_id: ', professor_id);
   		/*
   		$.ajax({
			url: "/entrevista/:user_id/:ev_id/algo-rol",
			method: "PUT",
			data: {
				role: role,
				competence_id: competence_id,
				professor_id: professor_id
			},
		    success: function(data) {
		      console.log("Buen cambio rol");
		    }
		});
		*/
   	});

	$('.inter-level-select').on('change', function() {
   		level_id = this.value;
   		competence_id = $(this).data("comp");
   		professor_id = $(this).data("evaluator");

   		console.log('Level: ', level_id);
   		console.log('Competence_id: ', competence_id);
   		console.log('Professor_id: ', professor_id);
   		/*
   		$.ajax({
			url: "/entrevista/:user_id/:ev_id/algo-nivel",
			method: "PUT",
			data: {
				level_id: level_id,
				competence_id: competence_id,
				professor_id: professor_id
			},
		    success: function(data) {
		      console.log("Buen cambio nivel");
		    }
		});
		*/
	});

	$('.inter-retro').bind('input propertychange', function() {
    	retro = this.value;
    	competence_id = $(this).data("comp");

    	console.log('Retro: ', retro);
   		console.log('Competence_id: ', competence_id);

    	/*
    	$.ajax({
		url: "/entrevista/:user_id/:ev_id/algo-retro",
		method: "PUT",
		data: {
			competence_id: competence_id,
			retro: retro
		},
	    success: function(data) {
	      console.log("Buen cambio retro");
		    }
		});
		*/

	    if(this.value.length){
	    	//$("#yourBtnID").show();
	    }
	});

	$('.btn-save-inter').on('click', function() {
		competence_id = $(this).data("comp");
		responsible_id = $('.inter-role-select[data-comp="' + competence_id +'"][data-responsible="true"]').data("evaluator");
		final_level = $('.inter-level-select[data-comp="' + competence_id +'"][data-evaluator="' + 3 + '"]').val();

   		console.log('Final level: ', final_level);
   		console.log('Competence_id: ', competence_id);
   		console.log('Responsible: ', responsible_id);

		/*
		$.ajax({
		url: "/entrevista/:user_id/:ev_id/algo-evaluacion",
		method: "PUT",
		data: {
			competence_id: competence_id,
			final_level: final_level
		},
	    success: function(data) {
	      console.log("Buen cambio retro");
		    }
		});
		*/
	});

});