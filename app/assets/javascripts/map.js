  function initMap(latSelected = 52.402585, lngSelected = 16.929517 ) {
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

$(document).ready(function(){
  var long = parseFloat($("#inputLongitude").val());
  var lat = parseFloat($("#inputLatitude").val());
  setTimeout(function(){
    initMap(lat, long);
  }, 50)
})