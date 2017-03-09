// FLASH MESSAGE STYLES FOR PAGES OTHER THAN INDEX COURT
var styles = {
  position: "absolute",
  width: "100%",
  top: "70px",
  background: "transparent"
}

// SHOW MAP ON COURT SHOW PAGE
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

// ADJUST HEIGHT OF THE MAP
function changeHeight() {
  $('#mapDiv').height($('#showImg').height());
}

// RUN MAP FUNCTION ON THE COURT SHOW PAGE
if ($.contains(document, $('#mapDiv')[0])){
  displayMap();
}

// ENABLE AUTOCOMPLETE WITH GEOLOCATION ON ADD/EDIT COURT PAGE
function displayAutoComplete(){
  var autocomplete;
  function initializeMap(){
      var input = document.getElementById('court_location');
      autocomplete = new google.maps.places.Autocomplete(input);

      google.maps.event.addListener(autocomplete, 'place_changed',function(){
      });
  };
  google.maps.event.addDomListener(window, 'pageshow', initializeMap);

  function geolocate() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        var geolocation = {
          lat: position.coords.latitude,
          lng: position.coords.longitude
        };
        var circle = new google.maps.Circle({
          center: geolocation,
          radius: position.coords.accuracy
        });
        autocomplete.setBounds(circle.getBounds());
      });
    }
  }
  google.maps.event.addDomListener(window, 'pageshow', geolocate);
}

// IGNORE 'ENTER' KEY TWICE ON AUTOCOMPLETE (.one() still submits form)
$('#court_location').on('keypress', function(e){
  var eventsLeft = 1;
  if (e.keyCode == 13 || e.which == 13){
    e.preventDefault();
    if(!(--eventsLeft)){
      $('#court_location').off();
    }
  }
})


// RUN MAP AUTOCOMPLETE FUNCTION ON THE ADD/EDIT COURT PAGE
if ($.contains(document, $('#court_location')[0])){
  displayAutoComplete();
}

// FLEX TEXTAREA
$(function() {
    $("textarea").flexible();
});


// ADJUST HEIGHT OF DIVS IN COURT INDEX PAGE
$(function() {
    $('.thumbnail').matchHeight();
});

// ADD AUTOFOCUS TO MODALS
$('.modal').on('shown.bs.modal', function() {
  $(this).find('[autofocus]').focus();
});

// VALIDATE PICTURE SIZE
$('#court_picture').on('change', function(){
  var size_in_megabytes = this.files[0].size/1024/1024;
  if (size_in_megabytes > 5){
    alert('Maximum file size is 5MB. Please resize that file or choose another.');
  }
});

// SET LOCATION OF THE 'X' CLOSING BUTTON FOR ADD COMMENT DIV
function chngClsBtnPos(){

  // IF ADD COMMENT DIV IS NOT ON THE PAGE/HIDDEN
  if (!($('.addComment').height())) {
    return;
  };

  var leftPos = $('.addComment').position().left;
  var widCom = $('.addComment').width();

  $('.closeComment').css({
    top: -32,
    left: leftPos + widCom/0.998
  });
}

// SHOW ADD COMMENT DIV
$("#addCommentButton").on('click', function(event){
  
  event.preventDefault();

  // $('.addComment').show({
  //   done: setTimeout(function(){
  //     chngClsBtnPos()
  //     $('.closeComment').show()
  //   },1200)
  // })

  $('.addComment').show();
  chngClsBtnPos();
  $('.closeComment').show();
  $('#addCommentButton').hide()
  $('.edtComment').hide();
  $('.well').show() 

  // $('#addCommentButton').addClass('fadeOutLeft')
  // setTimeout(function(){
  //   $('#addCommentButton').hide({
  //     done: function(){
  //       $(this).removeClass('fadeOutLeft');
  //       $(this).addClass('fadeInLeft');
  //     }
  //   })
  // },1)
})


// CLOSE ADD COMMENT DIV
$(".closeComment").on('click', function(){
  // $('#addCommentButton').show({
  //   done: function(){
  //     setTimeout(function(){
  //       $('#addCommentButton').removeClass('fadeInLeft')
  //     },750)
  //   }
  // })

  $('#addCommentButton').show()
  
  $('.addComment').hide()
  $('.closeComment').hide()
  // $('.addComment').addClass('fadeOutLeft');

  // setTimeout(function(){
  //   $('.addComment').hide({
  //     done: function(){
  //       $(this).removeClass('fadeOutLeft')
  //       $(this).addClass('fadeInLeft')
  //     }
  //   });
  // },1)
})

// SET LOCATION OF THE 'X' CLOSING BUTTON FOR EDIT COMMENT DIV
function chngEdClsBtnPos(){

  // IF EDIT COMMENT DIV IS NOT ON THE PAGE/HIDDEN
  if (!($('.edtComment').height())) {
    return;
  };

  var widCom = $('.edtComment').width();
  $('.closeEdtComment').css({
    top: -32,
    left: widCom/0.998
  });
}

// SHOW EDIT COMMENT FIELD, HIDE CLICKED COMMENT AND CLOSE (IF OPEN) OTHER EDIT COMMENT FIELD OR ADD COMMENT FIELD
$('.editComBtn').on('click', function(event){
  event.preventDefault();
  $('.well').not($('.addComment')).show()
  $(this).parent().hide();
  $('.edtComment').hide();
  $('.addComment').hide()
  $('#addCommentButton').show()
  var theComment = $(this).parent().next().children()
  theComment.show()
  chngEdClsBtnPos();
  theComment.children('.closeEdtComment').show()
})

// CLOSE EDIT COMMENT FIELD AND SHOW ALL COMMENTS
$('.closeEdtComment').on('click', function(){
  $(this).parent().hide();
  $('.well').not($('.addComment')).show()
})

// HANDLE COURTS LOCATION SUBMITION
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
    },
    error: function(error, status){
      $("#flash-messages > .col-xs-10").html("<div class='alert alert-danger'><a class=\'close\' data-dismiss=\'alert\' href=\'#\'>&times;</a>Location can't be blank.</div>")      
    }
  })
})

// FORMS VALIDATION
function validateForms(){
  $.validator.setDefaults({
      rules: {
        'user[password_confirmation]': {
          equalTo: "#user_password",
          minlength: 6
        },
        'user[password]': {
          required: true,
          minlength: 6
        },
        'user[username]': {
          required: true
        },
        'user[email]': {
          required: true,
          email: true
        },
        'session[email]': {
          required: true,
          email: true
        },
        'session[password]': {
          required: true,
          minlength: 6
        },
        'court[name]': "required",
        'court[description]': "required",
        'court[location]': "required",
        'court[picture]': "required"
      },
      errorElement: "em",
      errorPlacement: function (error, element) {
        error.addClass("help-block");
        element.parents('.val-col').addClass("has-feedback");
        error.insertAfter(element);
        if (!($(element)).next("span")[0]){
          $("<span class= 'fa fa-times-circle-o fa-2x form-control-feedback'></span>").insertAfter(element);
        }
      },
      success: function (label, element){
        if (!($(element)).next("span")[0]){
          $("<span class= 'fa fa-check-circle-o fa-2x form-control-feedback'></span>").insertAfter(element);
        }
      },
      highlight: function(element, errorClass, validClass) {
        $(element).parents('.val-col').addClass("has-error").removeClass("has-success")
        $(element).next("span").addClass("fa-times-circle-o").removeClass("fa-check-circle-o")
      },
      unhighlight: function(element, errorClass, validClass) {
        $(element).parents('.val-col').addClass("has-success").removeClass("has-error")
        $(element).next("span").addClass("fa-check-circle-o").removeClass("fa-times-circle-o")
      }
  })

  $('form').each(function(index){
    if (this.id == 'userForm'){
      $(this).validate({
        rules: {
          'user[password]': {
            required: false
          },
          'user[password_confirmation]': {
            required: false,
            equalTo: "#userForm #user_password",
            minlength: 6
          }
        }        
      });
    } else if (this.id == 'commentForm') {
      $(this).validate({
        messages: {
          'comment[content]': "Comment can't be empty."
        },
        errorPlacement: function(error,element){
          var parent = element.parents('.row')
          error.insertAfter(element)
        },
        success: false,
        highlight: false,
        unhighlight: false
      })
    } else {
      $(this).validate();
    }
  })
}

// CHANGE LANDING PAGE STYLING
if ($.contains(document, $('#landingJumbotron')[0])) {
  $('#mainNav').hide();
  $('body').css("padding-top", 0);
}

// HANDLE SWITCHING BETWEEN LOGIN/SIGNUP MODALS
$("#closeLoginModal").click(function(e){
    $("#loginModal").modal('hide');
    setTimeout(function(){
        $("#signupModal").modal("show");
    },500)
});

$("#closeSignupModal").click(function(e){
    $("#signupModal").modal('hide');
    setTimeout(function(){
        $("#loginModal").modal("show");
    },500)
});

$(document).ready(function(){
  $( "#courtsMainJumbo" ).prev().css(styles);
  changeHeight();
  validateForms();
})

$(window).resize(function(){
  changeHeight();
  chngClsBtnPos();
  chngEdClsBtnPos();
})