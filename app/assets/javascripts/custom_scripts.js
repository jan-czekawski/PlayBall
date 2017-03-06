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