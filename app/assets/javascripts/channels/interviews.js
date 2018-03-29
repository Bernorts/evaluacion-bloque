$(document).on('turbolinks:load', function() {
  console.log("puto turbolinks")
  if (App.interviews) {
    return setTimeout(App.interviews.received(), 10000) 
  }
});

App.interviews = App.cable.subscriptions.create('InterviewsChannel', {
  received: function(data) {
    return $(".participants").append(this.addParticipant(data));
  },

  addParticipant: function(data) {
    console.log(data)
    return ( "<tr><td>" + data.evaluation_user + "</td><td>" + data.evaluation_responsible + "</td><td>" + data.evaluation_level + "</td></tr>");
  }
});
