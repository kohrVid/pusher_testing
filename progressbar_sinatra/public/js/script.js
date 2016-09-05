$(document).ready(function () {
  var uID = Math.floor((Math.random()*100)+1);

  var pusher = new Pusher('9a7cef47c1d9237e5ac5', {
    encrypted: true
  });

  var channel = pusher.subscribe('signup_process_'+uID);
  var name = "Jess";

  $("#uid").val(uID);
  $("#name").val(name);

  channel.bind('update', function (data) {
    var messageBox = $("#create-account-form-with-realtime").children(".message");
    $(".progress-striped").removeClass("hide")
    var progressBar = $("#realtime-progress-bar");
    progressBar.css("width", data.progress + "%");
    messageBox.html(data.message);

    if (data.progress == 100) {
      messageBox.html("Was it better with this process?");
    }
  });

});
