// $("#loginButton").on("click", function(){
  
// });

// $("#signupButton").on("click", function(){
// });

$('.modal').on('shown.bs.modal', function() {
  $(this).find('[autofocus]').focus();
});

// $( window ).resize(function() {
//   changeSize();

// });

// $( document ).ready(function(){
//   changeSize();  
// });

$('#court_picture').on('change', function(){
  var size_in_megabytes = this.files[0].size/1024/1024;
  if (size_in_megabytes > 5){
    alert('Maximum file size is 5MB. Please resize that file or choose another.');
  }
});

// function changeSize(){
// //     var heights = $(".courtParagraph").map(function() {
// //         return $(this).height();
// //     }).get()

//     var widths = $(".courtParagraph").map(function() {
//       return $(this).width();
//     }).get()
//     console.log(widths);


// //     maxHeight = Math.max.apply(null, heights);
// //     maxWidth = Math.max.apply(null, widths);
// //     minWidth = Math.min.apply(null, widths);
// //     minHeight = Math.min.apply(null, heights);

// //     var selectSmaller = $(".courtParagraph").map(function(){
// //       if ($(this).height() < maxHeight){
// //         $(this).height(maxHeight);
// //       }

// //       if ($(this).width() < maxWidth){
// //         $(this).width(maxWidth);
// //       } 
// //     });

// }

// $('.grid').masonry({
//   // options...
//   itemSelector: '.grid-item',
//   columnWidth: 200
// });

$(function() {
    $('.thumbnail').matchHeight();
});
