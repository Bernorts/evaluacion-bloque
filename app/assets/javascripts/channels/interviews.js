App.interviews = App.cable.subscriptions.create('InterviewsChannel', {
  console.log("YES")
  received: function(data) {
    $("#interviews").removeClass('hidden')
    return $('#interviews').append(this.renderMessage(data));
  },

  renderMessage: function(data) {
    console.log(data)
    return "<p> <b>" + data + ": </b>" + data + "</p>";
  }
});
