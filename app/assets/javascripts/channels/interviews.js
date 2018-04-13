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
