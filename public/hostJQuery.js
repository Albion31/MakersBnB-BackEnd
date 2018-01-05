$(document).ready(function() {

  $('#post').click(function() {
    var name = $('#name').val();
    var bio = $('#bio').val();
    var guests = $('#guests').val();
    var location = $('#location').val();
    var newEntry = {name: name, bio: bio, guests: guests, location: location};
    sendToServer(newEntry);
    clearFields();
    // var timeDelay = 1000;
    // setTimeout(getListings, timeDelay)
  })

  function sendToServer(newEntry) {
    var entry = JSON.stringify(newEntry);
    $.ajax({
        type: 'POST',
        url: 'http://localhost:9292/listings',
        data: entry,
        dataType: 'json'
    });
  }

  function clearFields() {
    $('#name').val('')
    $('#bio').val('')
    $('#guests').val('')
    $('#location').val('')
  }
})
