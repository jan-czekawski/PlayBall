function displayMap(){
  function initMapOn(latSelected, lngSelected) {
    var myLatLng = {lat: latSelected, lng: lngSelected};

    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 12,
      center: myLatLng
    });

    var marker = new google.maps.Marker({
      position: myLatLng,
      map: map,
      title: 'Hello World!'
    });
  }

  window.onload = function(){
    var long = parseFloat($("#inputLongitude").val());
    var lat = parseFloat($("#inputLatitude").val());
    setTimeout(function(){
      initMapOn(lat, long);
    }, 50)
  }
}

function displayAutoComplete(){
  function initializeMap(){
      var input = document.getElementById('court_location');
      var autocomplete = new google.maps.places.Autocomplete(input);

      google.maps.event.addListener(autocomplete, 'place_changed',function(){
      });
  };
  google.maps.event.addDomListener(window, 'pageshow', initializeMap);
}

function changeHeight() {
  $('#mapDiv').height($('#showImg').height());
}

$(function() {
    $("textarea").flexible();
});

$(function() {
    $('.thumbnail').matchHeight();
});

$('.modal').on('shown.bs.modal', function() {
  $(this).find('[autofocus]').focus();
});


$('#court_picture').on('change', function(){
  var size_in_megabytes = this.files[0].size/1024/1024;
  if (size_in_megabytes > 5){
    alert('Maximum file size is 5MB. Please resize that file or choose another.');
  }
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
        $("#flash-messages > .col-xs-10").html("<div class='alert alert-danger'><a class=\'close\' data-dismiss=\'alert\' href=\'#\'>&times;</a>Address not found. Please provide correct location.</div>")
      }
    }
  })
})


$(".close").on('click', function(){
  $(".addComment").hide();
})




$(document).ready(function(){
  var styles = {
    background: "#EEE",
    position: "static",
    width: "100%",
    marginLeft: "0",
    marginRight: "0"
  };
  $( ".showJumbo" ).prev().css(styles);
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

if ($.contains(document, $('#landingJumbotron')[0])) {
  $('#mainNav').hide();
  $('body').css("padding-top", 0);
}

if ($.contains(document, $('#mapDiv')[0])){
  displayMap();
}

if ($.contains(document, $('#court_location')[0])){
  displayAutoComplete();
}


$("#closeLoginModal").click(function(e){
    $("#loginModal").modal('hide');
    setTimeout(function(){
        $("#signupModal").modal("show");
    },400)
});

$("#closeSignupModal").click(function(e){
    $("#signupModal").modal('hide');
    setTimeout(function(){
        $("#loginModal").modal("show");
    },400)
});

$('.modal').on('shown.bs.modal', function(){
  $('body').css('padding-right', "0px")  
  $('body').removeClass("modal-open")
})

$('.modal').on('hidden.bs.modal', function(){
  $('body').css('padding-right', "0px")
  $('body').removeClass("modal-open")
})

// setInterval(function(){
//   console.log($('body').css("padding-right"))
// },100)

// var email = $("#signupEmail");


$( document ).ready(function(){

  $.validator.setDefaults({
      rules: {
        'user[password_confirmation]': {
          // equalTo: "#user_password",
          minlength: 6
        },
        'user[password]': {
          required: true,
          minlength: 6
        },
        'session[email]': {
          required: true,
          email: true
        },
        'session[password]': {
          required: true,
          minlength: 6
        }
      },
      messages: {
        'user[password_confirmation]': "Please enter the same password as above"
      },
      errorElement: "em",
      errorPlacement: function (error, element) {
        error.addClass("help-block");
        element.parents('.col-xs-7').addClass("has-feedback");
        error.insertAfter(element);
        if (!($(element)).next("span")[0]){
          $("<span class= 'fa fa-times-circle-o fa-2x form-control-feedback'></span>").insertAfter(element);
        }
      },
      success: function (label, element){
        if (!($(element)).next("span")[0]){
          $("<span class= 'fa fa-check-circle-o fa-2x form-control-feedback'></span>").insertAfter($(element));
        }
      },
      highlight: function(element, errorClass, validClass) {
        $(element).parents('.col-xs-7').addClass("has-error").removeClass("has-success")
        $(element).next("span").addClass("fa-times-circle-o").removeClass("fa-check-circle-o")
      },
      unhighlight: function(element, errorClass, validClass) {
        $(element).parents('.col-xs-7').addClass("has-success").removeClass("has-error")
        $(element).next("span").addClass("fa-check-circle-o").removeClass("fa-times-circle-o")
      }
  })

//   $('.val-frm').validate({
//     rules: {
//       'user[password_confirmation]': {
//         equalTo: "#user_password",
//         minlength: 6
//       },
//       'user[password]': {
//         required: true,
//         minlength: 6
//       }
//     },
//     messages: {
//       'user[password_confirmation]': "Please enter the same password as above"
//     }
//   });

// $('.val-frm2').validate({
//   rules: {
//     'session[email]': {
//       required: true,
//       email: true
//     },
//     'session[password]': {
//       required: true,
//       minlength: 6
//     }
//   }

//   })

  $('val-frm').validate();
  $('val-frm2').validate();


  // $( "form" ).each( function() {
  //   $( this ).validate({

  //   });
  // } );
})




// $( "input[type='text']" ).change(function() {
//   // Check input( $( this ).val() ) for validity here
// });

