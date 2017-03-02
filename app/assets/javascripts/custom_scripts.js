$('.modal').on('shown.bs.modal', function() {
  $(this).find('[autofocus]').focus();
});


$('#court_picture').on('change', function(){
  var size_in_megabytes = this.files[0].size/1024/1024;
  if (size_in_megabytes > 5){
    alert('Maximum file size is 5MB. Please resize that file or choose another.');
  }
});


$(function() {
    $('.thumbnail').matchHeight();
});

$("#addCommentButton").on('click', function(event){
  event.preventDefault();
  $(".addComment").show();
})

$("#submitFormButton").on('click', function(event){
  event.preventDefault();
  var prefixHttp = "https://maps.googleapis.com/maps/api/geocode/json?address="
  var key = "&key=AIzaSyCHvA_HeK-Kj5bULpf9VkGl5SFGgyp3Fu8"
  var location = $("#court_location").val()
  var together = prefixHttp + location + key
  $.ajax({
    method: "GET",
    url: together,
    dataType: "json",
    success: function(data){
      if(data["status"] == "OK"){
        $("#court_latitude").val(data["results"][0]["geometry"]["location"]["lat"]);
        $("#court_longitude").val(data["results"][0]["geometry"]["location"]["lng"]);
        $("#submitForm").submit();
      } else {
        $("#flash-messages").text("Address not found. Please provide correct location.").addClass("alert alert-danger");
      }
    },
    error: function (request, status, error){
      $("#flash-messages").text("Location can't be blank. Please provide correct address.").addClass("alert alert-danger");
    }
  })
})


$(".close").on('click', function(){
  $(".addComment").hide();
})

$(function() {
    $("textarea").flexible();
});

function changeHeight() {
  $('#mapDiv').height($('#showImg').height());
}

$(document).ready(function(){
  changeHeight();
})

$(window).resize(function(){
  changeHeight();
})

// function chooseModal(object, object_url){
//   $.ajax({
//     method: "GET",
//     url: "/courts",
//     data: {object: object, object_url: object_url}})
//     .done(function(msg){
//     })
//   }
