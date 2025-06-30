$(function(){
$('.autocompletcity1').livequery(function(){
	initializeGoogleMapsApi();
})
  
  
})



var placeSearch, autocomplete, autocomplet1, autocomplet2;

var directionsService = new google.maps.DirectionsService();

var componentForm = {
  street_number: 'short_name',
  route: 'long_name',
  locality: 'long_name',
  administrative_area_level_1: 'short_name',
  country: 'long_name',
  postal_code: 'short_name'
};

function initializeGoogleMapsApi() {

	if(($('.autocompletcity1').length == 0)&&($('.autocompletcity2').length > 0)){
		console.log("erreur : veulliez ajouter la class (autocompletcity1) au champ saisir ville 1");
	}else if(($('.autocompletcity1').length > 1)&&($('.autocompletcity2').length > 0)){
		console.log("erreur : vous avez ajouter la class (autocompletcity1) au plusieurs champs de saisir!");
	}
	
	if(($('.autocompletcity2').length == 0)&&($('.autocompletcity1').length > 0)){
		console.log("erreur : veulliez ajouter la class (autocompletcity2) au champ saisir ville 1");
	}else if(($('.autocompletcity2').length > 1)&&($('.autocompletcity1').length > 0)){
		console.log("erreur : vous avez ajouter la class (autocompletcity2) au plusieurs champs de saisir!");
	}
	console.log("aaaa2");

  // Create the autocomplete object, restricting the search
  // to geographical location types.
  autocomplete = new google.maps.places.Autocomplete(
      /** @type {HTMLInputElement} */($('.autocompletcity1')[0]),
      { types: ['(cities)'] });
  autocomplete1 = new google.maps.places.Autocomplete(
      /** @type {HTMLInputElement} */($('.autocompletcity1')[0]),
      { types: ['(cities)'] });
  autocomplete2 = new google.maps.places.Autocomplete(
      /** @type {HTMLInputElement} */($('.autocompletcity2')[0]),
      { types: ['(cities)'] });    
      
      
      /***************************************************/
      /****************limit by country*****************/
      var componentRestrictions = {country: 'fr'};
      autocomplete.setComponentRestrictions(componentRestrictions);
      autocomplete1.setComponentRestrictions(componentRestrictions);
      autocomplete2.setComponentRestrictions(componentRestrictions);
	/***************************************************/


  // When the user selects an address from the dropdown,
  // populate the address fields in the form.
  google.maps.event.addListener(autocomplete1, 'place_changed', function() {
    fillInAddress();
  });
  
  google.maps.event.addListener(autocomplete2, 'place_changed', function() {
    fillInAddress();
  });
  
  $('.autocompletcity1').blur(function() {
	  
	  calcRoute();
	});
	
	 $('.autocompletcity2').blur(function() {
	  
	  calcRoute();
	});
  
  
}
/***********************************************************************/
/*function calcDistance(p1, p2){
  return (google.maps.geometry.spherical.computeDistanceBetween(p1, p2) / 1000).toFixed(2);
}*/



function calcRoute() {
  var start = 	$('.autocompletcity1')[0].value;
  var end 	= 	$('.autocompletcity2')[0].value;
  
  if((start=="")||(end=="")){
  	if($('.resultdistanc').length > 0){
	  $('.resultdistanc')[0].value="..."
	 }
	  return;
  }
  
  var request = {
    origin:start,
    destination:end,
    travelMode: google.maps.DirectionsTravelMode.DRIVING
  };
  
  directionsService.route(request, function(response, status) {
  
    if (status == google.maps.DirectionsStatus.OK) {
      //directionsDisplay.setDirections(response);
      
      if($('.resultdistanc').length > 0){
	       $('.resultdistanc')[0].value=response.routes[0].legs[0].distance.value/1000;
	       $('.resultdistanc')[0].focus();
	       $('.resultdistanc')[0].blur();
      }
      
     
    }else{
     if($('.resultdistanc').length > 0){
	    $('.resultdistanc')[0].value="..."
    }
    }
  });
}


/*$('.autocompletcity2')[0].blur(function() {
  calcRoute();
});*/


/***********************************************************************/

// The START and END in square brackets define a snippet for our documentation:
// [START region_fillform]
function fillInAddress() {

calcRoute();

  // Get the place details from the autocomplete object.
//  var place1 = autocomplete1.getPlace();
  //var place2 = autocomplete2.getPlace();
  
  
/*console.log(" Get the place details from the autocomplete object");
console.log(place1);
console.log(place1.geometry.location.d);
console.log(place1.geometry.location.e);
console.log(" Get the place details from the autocomplete object");
console.log(place2);
console.log(place2.geometry.location.d);
console.log(place2.geometry.location.e);

var p1 = new google.maps.LatLng(place1.geometry.location.d, place1.geometry.location.e);
var p2 = new google.maps.LatLng(place2.geometry.location.d, place2.geometry.location.e);
//alert(calcDistance(p1, p2));

*/
  /*for (var component in componentForm) {
    document.getElementById(component).value = '';
    document.getElementById(component).disabled = false;
  }*/

  // Get each component of the address from the place details
  // and fill the corresponding field on the form.
  /*for (var i = 0; i < place1.address_components.length; i++) {
    var addressType = place1.address_components[i].types[0];
    if (componentForm[addressType]) {
      var val = place1.address_components[i][componentForm[addressType]];
      document.getElementById(addressType).value = val;
    }
  }*/
}
// [END region_fillform]

// [START region_geolocation]
// Bias the autocomplete object to the user's geographical location,
// as supplied by the browser's 'navigator.geolocation' object.
function geolocate() {
console.log("aaaa3");
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = new google.maps.LatLng(
          position.coords.latitude, position.coords.longitude);
      autocomplete.setBounds(new google.maps.LatLngBounds(geolocation,
          geolocation));
    });
  }
}
