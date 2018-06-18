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
  	var interview_id;
  	var ev_id;

  	App.interviews = App.cable.subscriptions.create('InterviewsChannel', {
	  		received: function(data) {
		  		console.log('Cable en received');
		  		console.log(data.method);
		  		switch(data.method){
		  			case 'show':
		  				return $("#participants-" + data.evaluation_competence_id).append(this.addParticipant(data));
		  				break;
		  			case 'update_responsible':
		  				return this.updateRole(data);
		  				break;
		  			case 'update_level':
		  				return this.updateLevel(data);
		  				break;
		  			case 'update_retro':
		  				return this.updateRetro(data);
		  				break;
		  		}
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
		},

		updateRole: function(data){
			let role = data.evaluation_role;
			$(`select[data-evaluation="${data.evaluation}"][data-evaluator="${data.professor.user_id}"][data-select="role"]`).val(role);
		},

		updateLevel: function(data){
			let level = data.evaluation_level.id;
			$(`select[data-evaluation="${data.evaluation}"][data-evaluator="${data.professor.user_id}"][data-select="level"]`).val(level);
		},
		updateRetro: function(data){
			$(`#retro-${data.evaluation}`).val(data.retro);
		}
	});

	$('.inter-role-select').on('change', function() {
   		role = this.value;
   		competence_id = $(this).data("comp");
   		professor_id = $(this).data("evaluator");
      	interview_id = $(this).data("interview");
      	ev_id = $(this).data("evaluation");
   		if(role == 'true'){
   			$(this).attr('data-responsible', 'true');
   		} else{
   			$(this).removeAttr('data-responsible');
   		}

   		console.log('Role: ', role);
   		console.log('Competence_id: ', competence_id);
   		console.log('Professor_id: ', professor_id);
      	console.log('interview_id: ', interview_id);
      	console.log('ev_id: ', ev_id);

   		$.ajax({
			url: '/entrevista_evaluacion/'+ interview_id +'/' + professor_id +'/rol',
			method: "PUT",
			data: {
				role: role,
				competence_id: competence_id,
				professor_id: professor_id,
		        interview: interview_id,
		        evaluation: ev_id
			},
		    success: function(data) {
		      console.log("Buen cambio rol");
		    }
		});
   	});

	$('.inter-level-select').on('change', function() {
   		level_id = this.value;
      role = this.value;
   		competence_id = $(this).data("comp");
   		professor_id = $(this).data("evaluator");
      interview_id = $(this).data("interview");
      ev_id = $(this).data("evaluation");

   		console.log('Level: ', level_id);
   		console.log('Competence_id: ', competence_id);
   		console.log('Professor_id: ', professor_id);

   		$.ajax({
			url: "/entrevista_evaluacion/" + interview_id + "/"+ professor_id + "/" + competence_id + "/level",
			method: "PUT",
			data: {
				level_id: level_id,
				competence_id: competence_id,
				professor_id: professor_id,
        		evaluation: ev_id
			},
		    success: function(data) {
		      console.log("Buen cambio nivel");
		    }
		});

	});

	$('.inter-retro').focusout(function() {
    	retro = this.value;
    	competence_id = $(this).data("comp");
      	evaluation_id = $(this).data("evaluation")

    	console.log('Retro: ', retro);
   		console.log('Competence_id: ', competence_id);


    	$.ajax({
		url: "/entrevista_retro/"+ evaluation_id + "/retro",
		method: "PUT",
		data: {
			competence_id: competence_id,
			retro: retro,
  			evaluation: evaluation_id
		},
	    success: function(data) {
	      console.log("Buen cambio retro");
		    }
		});

	    if(this.value.length){
	    	//$("#yourBtnID").show();
	    }
	});

	$('.btn-save-inter').on('click', function() {
		competence_id = $(this).data("comp");
		ev_id = $(this).data("evaluation");
		responsible_id = $('.inter-role-select[data-comp="' + competence_id +'"][data-responsible="true"]').data("evaluator");
		final_level = $('.inter-level-select[data-comp="' + competence_id +'"][data-evaluator="' + responsible_id + '"]').val();

		if(responsible_id != undefined){
			$.ajax({
			url: "/entrevista_final/"+ responsible_id+"/" + ev_id+ "/evaluation",
			method: "PUT",
			data: {
				competence_id: competence_id,
				final_level: final_level,
				evaluation: ev_id
			},
			success: function(data) {
			  console.log("Registro de nivel de evaluación");
			},
			error: function(data){
			console.log("cannot be inserted");
			}
			});
		} else{
			console.log("EMPTY responsible")
		}
	});
});
