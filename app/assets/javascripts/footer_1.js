$("#loginButton").on("click", function(){
  
});

$("#signupButton").on("click", function(){
});

$('.modal').on('shown.bs.modal', function() {
  $(this).find('[autofocus]').focus();
});

// var customWidth = $('.thumbnail').width(); 

// // $(window).resize(function(){
// //   $('.thumbnail').width(customWidth+50);
// // })

// $(document).ready(function(){
//   $('.thumbnail').width(customWidth); 
// })


// $( document ).ready(function() {
//     var heights = $(".thumbnail").map(function() {
//         return $(this).height();
//     }).get()

//     var widths = $(".thumbnail").map(function() {
//       return $(this).width();
//     }).get()

//     maxHeight = Math.max.apply(null, heights);
//     maxWidth = Math.max.apply(null, widths);

//     $(".thumbnail").height(maxHeight);
//     $(".thumbnail").width(maxWidth);
// });

$( window ).resize(function() {
    // var heights = $(".thumbnail").map(function() {
    //     return $(this).height();
    // }).get()

    var widths = $(".thumbnail").map(function() {
      return $(this).width();
    }).get()

    // maxHeight = Math.max.apply(null, heights);
    maxWidth = Math.max.apply(null, widths);
    minWidth = Math.min.apply(null, widths);

    $(".thumbnail[width=" + minWidth + "]").width(maxWidth);

    // $(".thumbnail").height(maxHeight);
    // $(".thumbnail").width(maxWidth);
});

$( document ).ready(function(){
    // var heights = $(".thumbnail").map(function() {
    //     return $(this).height();
    // }).get()

    var widths = $(".thumbnail").map(function() {
      return $(this).width();
    }).get()

    // maxHeight = Math.max.apply(null, heights);
    maxWidth = Math.max.apply(null, widths);
    minWidth = Math.min.apply(null, widths);

    $('div[width="' + minWidth + 'px"]').width(maxWidth);

    // $(".thumbnail").height(maxHeight);
    // $(".thumbnail").width(maxWidth);
  });