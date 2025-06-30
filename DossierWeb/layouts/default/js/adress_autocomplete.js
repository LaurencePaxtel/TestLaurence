var placeSearch, autocomplete;
var componentForm = {
  street_number: 'short_name',
  route: 'long_name',
  locality: 'long_name',
  administrative_area_level_1: 'short_name',
  country: 'long_name',
  postal_code: 'short_name'
};

function initAutocomplete() {
  autocomplete = new google.maps.places.Autocomplete(
      /** @type {!HTMLInputElement} */(document.getElementById('autocomplete')),
      {types: ['geocode']});
  autocomplete.addListener('place_changed', fillInAddress);
}


function fillInAddress() {


  var place = autocomplete.getPlace();

  for (var component in componentForm) {
    document.getElementById(component).value = '';
    document.getElementById(component).disabled = false;
  }


  for (var i = 0; i < place.address_components.length; i++) {
    var addressType = place.address_components[i].types[0];
    if (componentForm[addressType]) {
      var val = place.address_components[i][componentForm[addressType]];
      document.getElementById(addressType).value = val;
    }
  }
  
   document.getElementById('adr_postal_code').value=document.getElementById('postal_code').value;
   document.getElementById('adr_city').value=document.getElementById('locality').value;
   document.getElementById('adr_state').value=document.getElementById('administrative_area_level_1').value;
   document.getElementById('adr_country').value=document.getElementById('country').value;
   document.getElementById('adr_line_1').value=document.getElementById('street_number').value;
   document.getElementById('adr_line_2').value=document.getElementById('route').value;
   
     document.getElementById("adr_postal_code").setAttribute('value',document.getElementById('postal_code').value);
	 document.getElementById("adr_city").setAttribute('value',document.getElementById('locality').value);
	 document.getElementById("adr_state").setAttribute('value',document.getElementById('administrative_area_level_1').value);
	 document.getElementById("adr_country").setAttribute('value',document.getElementById('country').value);
	 document.getElementById("adr_line_1").setAttribute('value',document.getElementById('street_number').value);
	 document.getElementById("adr_line_2").setAttribute('value',document.getElementById('route').value);
  
}

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