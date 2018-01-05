$(document).ready(function() {

  getUsername()

  $('#host').click(function() {
    console.log('click')
    $("#info").load("host.html");
  })

  $('#book').click(function() {
    $("#info").load("book.html");
  })

  $('#sign-up').click(function() {
    $("#info").load("signup.html");
  })

  $('#sign-out').click(function() {
    $.get('http://localhost:9292/users/sign-out')
    location.reload()
  })

  $('#sign-in').click(function() {
    username = $('#sign_in_username').val()
    password = $('#sign_in_password').val()
    signInData = {username: username, password: password}
    sendToServer(signInData)
    var timeDelay = 1000;
    setTimeout(getUsername, timeDelay)
  })


})

function sendToServer(newEntry) {
var entry = JSON.stringify(newEntry);
$.ajax({
    type: 'POST',
    url: 'http://localhost:9292/users/new',
    data: entry,
    dataType: 'json'
});
}


function getUsername(){
  $.get('http://localhost:9292/users/current-user', function(user){
    if(user) {
      $("#user").text("Signed in as: " + user.username)
    }
  })
}


function getListings() {
  $.get('http://localhost:9292/listings', function(listings) {
    if($('#list_of_listings').children().length == 0) {
      populateList(listings)
    } else {
      updateList(listings)
    }
  })
}
