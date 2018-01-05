$(document).ready(function() {
$('#signup_button').click(function() {
  var username = $('#username').val();
  var email = $('#email').val();
  var password = $('#password').val();
  var password_confirmation = $('#password_confirmation').val();
  var newEntry = {username: username, email: email, password: password, password_confirmation: password_confirmation};
  sendToServer(newEntry);
  console.log('clicked')
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
