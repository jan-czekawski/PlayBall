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

$(".close").on('click', function(){
  $(".addComment").hide();
})

// function chooseModal(object, object_url){
//   $.ajax({
//     method: "GET",
//     url: "/courts",
//     data: {object: object, object_url: object_url}})
//     .done(function(msg){
//     })
//   }
