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
;
  function initializeMap(){
        var input = document.getElementById('court_location');
        var autocomplete = new google.maps.places.Autocomplete(input);

        google.maps.event.addListener(autocomplete, 'place_changed',function(){
        });
    };
google.maps.event.addDomListener(window, 'pageshow', initializeMap);


