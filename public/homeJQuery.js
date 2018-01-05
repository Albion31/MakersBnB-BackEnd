$(document).ready(function() {

  $('#host').click(function() {
    console.log('click')
    $("#info").load("host.html");
  })

  $('#book').click(function() {
    $("#info").load("book.html");
  })

  $('#signup_button').click(function() {
    var username = $('#username').val();
    var email = $('#email').val();
    var password = $('#password').val();
    var password_confirm = $('#password-confirmation').val();
    var newEntry = {username: username, email: email, password: password, password_confirm: password_confirm};
    sendToServer(newEntry);

  })
})

function sendToServer(newEntry) {
  var entry = JSON.stringify(newEntry);
  $.ajax({
      type: 'POST',
      url: 'http://localhost:9292/users',
      data: entry,
      dataType: 'json'
});
}
