App.messages = App.cable.subscriptions.create('EvaluationsChannel', {
  received: function(data) {
    $("#messages").removeClass('hidden')
    return $('#messages').append(this.renderMessage(data));
  },

  renderMessage: function(data) {
    return "<p> <b>" + data + ": </b>" + data + "</p>";
  }
});
