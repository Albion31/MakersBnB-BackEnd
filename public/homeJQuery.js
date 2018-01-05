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


})


function getUsername(){
  $.get('http://localhost:9292/users', function(user){
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
