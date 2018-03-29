App.interviews = App.cable.subscriptions.create('InterviewsChannel', {
  received: function(data) {
    $(".participants").append(this.addParticipant(data));
  },

  addParticipant: function(data) {
    console.log(data)
    return ( "<tr><td>" + data.evaluation_user + "</td><td>" + data.evaluation_responsible + "</td><td>" + data.evaluation_level + "</td></tr>");
  }
});
