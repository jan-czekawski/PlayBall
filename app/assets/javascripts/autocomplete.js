  function initializeMap(){
        var input = document.getElementById('court_location');
        var autocomplete = new google.maps.places.Autocomplete(input);

        google.maps.event.addListener(autocomplete, 'place_changed',function(){
        });
    };
google.maps.event.addDomListener(window, 'pageshow', initializeMap);
