$( document ).on('ready turbolinks:load',function() {
	var competence_id;
	var professor_id;
	var role;
	var level_id;
	var retro;
	var final_level;
	var responsible_id;
  var interview_id;
  var ev_id;
  old_eval_user = '';
  old_com = '';
  


    if(!window.location.hash && window.location.href.indexOf("entrevista") > -1) {
      window.location = window.location + '#loaded';
      window.location.reload();
    }

  	App.interviews = App.cable.subscriptions.create('InterviewsChannel', {
	  		received: function(data) {
		  		console.log('Cable en received');
		  		console.log(data.method);
		  		switch(data.method){
            case 'show':
              if(data.evaluation_user != old_eval_user && data.evaluation_competence_id != old_com){
                old_eval_user = data.evaluation_user;
                old_com = data.evaluation_competence_id;
                return $("#participants-" + data.evaluation_competence_id).append(this.addParticipant(data));
              }
              break;
		  			case 'update_responsible':
              return this.updateRole(data);
		  			case 'update_level':
		  				return this.updateLevel(data);
		  			case 'update_retro':
		  				return this.updateRetro(data);
          }
      },
        connected: function(data){
          console.log("Connected");
          $('select[data-evaluator!=' + current_user + ']').prop( "disabled", true );
          $('textarea[data-evaluator!=' + current_user + ']').prop( "disabled", true );
        },

		addParticipant: function(data) {
      /*
      var disabled = !(current_user == data.evaluation_user_id);
			var all_levels = JSON.parse(data.all_levels);
			row = "<tr>" +
			    	"<td>" + data.evaluation_user + "</td>" +
			    	"<td>" +
			    		"<select class='form-control' disabled='" + disabled + "'>" +
							"<option value='true'>Responsable</option>" +
							"<option value='false' selected>Evaluador</option>" +
					  	"</select>" +
				  	"</td>";

			row += "<td>" + "<select class='form-control' disabled='" + disabled + "'>";

			for(var key in all_levels){
				row += "<option value=" + key + ">" + all_levels[key] + "</option>";
			}

      row += "</select>" + "</td>" + "</tr>";

      
      return row;
      */

      interview_id = $("#current_int").text();
      if((window.location.href.indexOf("entrevista") > -1) && (interview_id == data.interview_id)) {
        console.log("Text de current int", interview_id);
        window.location.reload();
      }

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
      $(`#retro-${data.evaluation}-${data.evaluator}`).val(data.retro);
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
		      console.log("Buen cambio nivel", data);
		    }
		});

	});

	$('.inter-retro').focusout(function() {
    	retro = this.value;
    	competence_id = $(this).data("comp");
      evaluation_id = $(this).data("evaluation");
      evaluator_id = $(this).data("evaluator")

    	console.log('Retro: ', retro);
   		console.log('Competence_id: ', competence_id);

    	$.ajax({
        url: "/entrevista_retro/"+ evaluation_id + "/retro",
        method: "PUT",
        data: {
          competence_id: competence_id,
          retro: retro,
          evaluation: evaluation_id,
          evaluator: evaluator_id,
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

    retro = '';

    $(`textarea[data-evaluation="${ev_id}"]`).each(function() {
      if($(this).val() != ''){
        retro += $(this).val() + "\n";
      }
    });

    console.log("Retro", retro);

			$.ajax({
			url: "/entrevista_final/"+ ev_id+ "/evaluation",
			method: "PUT",
			data: {
        evaluation: ev_id,
        retro: retro
			},
			success: function(data) {
        $(`#current-level-${ev_id}`).text(data.levelName);
				if (data.success){
					swal({
	          title: "Registro de nivel exitoso",
	          type: 'success',
	          confirmButtonText: 'OK',
	          timer: 3000,
	        })
				} else{
					swal({
	          title: 'Error!',
	          text: "Debe haber un responsable",
	          type: 'error',
	          confirmButtonText: 'OK'
	        });
				}

			}
			});
	});

	$('.inter-role-select').on('change', function(){
		let evaluation = $(this).data("evaluation");
		let evaluator = $(this).data("evaluator");
		let role = $(this).val();

		if(role == 'true' && current_user == evaluator){
			console.log('Role true', role);
			$(`button[data-evaluation="${evaluation}"]`).removeAttr('disabled');
		} else{
			console.log('Role false', role);
			$(`button[data-evaluation="${evaluation}"]`).attr('disabled','disabled');
		}
	});


});
