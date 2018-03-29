App.interviews = App.cable.subscriptions.create('InterviewsChannel', {
  received: function(data) {
    $(".participants").append(this.addParticipant(data));
  },

  addParticipant: function(data) {
    console.log(data)
    row = "<tr>" + 
	    	"<td>" + data.evaluation_user + "</td>" + 
	    	"<td>" + 
	    		"<select class='form-control'>" + 
					"<option value='responsible'>Responsable</option>" +
					"<option value='evaluator' selected>Evaluador</option>" +
			  	"</select>" + 
		  	"</td>";

	levels_select = "<td>" + "<select class='form-control'>";
	
	for(var key in data.all_levels){
		levels_select += "<option value=" + key + ">" + data.all_levels[key] + "</option>" +
	}

	levels_select += "</select>" + "</td>";
  	
  	row += levels_select + "</tr>";

    return row;
  }
});
