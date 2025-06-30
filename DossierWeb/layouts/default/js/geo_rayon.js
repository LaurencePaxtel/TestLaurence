  /**
   * Called on the intiial page load.
   */
 
// Intialize global variables.
var socUid;
var map;
var latLng;
var options;
var centralMarker;
var locations;
var statuts;
var colors;
var markers;
var realLocations;
var tmpLocations;
var markersToAdd;
var markersToRemove;

// Send new request.
$('#voirautour').live('click',function(){
	var uidsoc = $("#uidsoc").val();
	var tkm = $("#rayon").val();
	var url = "/GEO?uidsoc="+uidsoc+"&km="+tkm
	window.location = url;
});

$(':checkbox').live('click',function(){
	markersToRemove = new Array();
	markersToAdd = new Array;
    var cObj = $(this);
    var cVal = cObj.val();
	console.log("cVal : " + cVal);
    if (cObj.attr("checked")) {
		arrete : for (var i = 0; i < realLocations.length; i++) {
			if (realLocations[i][4] == cVal) {
				for (var j = 0; j < tmpLocations.length; j++) {
					if (tmpLocations[j][3] != realLocations[i][3]) {
						tmpLocations.push(realLocations[i]);
						continue arrete;
					}
				}
			}
		}
		reloadMarkers(tmpLocations);
    } 
	else {
		for (var i = 0; i < tmpLocations.length; i++) {
			if (tmpLocations[i][4] == cVal) {
				tmpLocations.splice(i,1);
				i--;
			}
		}
		removeMarkers(tmpLocations);
    }
});

function removeMarkers (tmp) {
	for (var i = 0; i < markers.length; i++ ) {
		markers[i].setMap(null);
	}
	addMarkersToMap(tmp);
}

function reloadMarkers (tmp) { 
	// Add markers to the map.
	// First parameter : array of latitudes and longitudes.
	
	for (var i = 0; i < markers.length; i++ ) {
		markers[i].setMap(null);
	}
	addMarkersToMap(tmp);
}

// Initialize map.
function initializeMap (lat, lng, zo) { 

	// Initialize map with central point.
	latLng = new google.maps.LatLng(lat, lng);
	options = {
		'zoom': zo,
		'center': latLng,
		'mapTypeId': google.maps.MapTypeId.ROADMAP
	};
   
	// Get the div element map to add the map.
	map = new google.maps.Map(document.getElementById('map'),options);
   
}

// Get society details.
function getSocietyDetails() {
	
	// Get current url and formulate the society details page.
	var url = document.URL;
	var addressTab = url.split("/"); 
	var address = addressTab[0];
	address = address + 'SOC?action=edit&uid=' + socUid;
	window.open(address,'_blank');
	
}

// Add other points (markes).
function addMarkersToMap (locs) {

	// Initialize windowinfos to show the informations of the point.   
	var infowindow = new google.maps.InfoWindow();
	var marker, i;
	markers = new Array();
	for (i = 1; i < locs.length; i++) { 	
		var icn = ""; 
		//if (locs[i][4] == "") {
		//	icn = 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|6dd0f7'; 
		//}	
		//else {
			icn = locs[i][4]; 
		//}
		// Add markers to the map.
		//console.log(locs[i][4]);
		marker = new google.maps.Marker({
			position: new google.maps.LatLng(locs[i][1], locs[i][2]),
			icon: icn,
			map: map
		});
		//markers = new Array();
		markers.push(marker);

		// Add listener to the marker to show infowindow.
		google.maps.event.addListener(marker, 'mouseover', (function(marker, i) {
			return function() {
				socUid = locs[i][3];	
				var html = '<div id="info_content">Nom : ' + locs[i][0] + '<br/>Statut client : ' + locs[i][5] + '<br/><button onclick="getSocietyDetails()">Afficher</button></div>';				
				infowindow.setContent(html);
				infowindow.open(map, marker);
			}
		})(marker, i));        
	}
 
}


// Add circle overlay to the map.
function addCircleOverlay (lat, lng, des, dis) {
   
	// Create a marker which will later on be binded to a circle overlay.
	centralMarker = new google.maps.Marker({
		position: new google.maps.LatLng(lat, lng),
		icon : 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|fc0232',
		map: map
	});
   
	// Initialize windowinfos to show the informations of the point.   
	var infowindow = new google.maps.InfoWindow();  
   
	// Add listener on click to the marker to show infowindow.       
	google.maps.event.addListener(centralMarker, 'click', function() {
		socUid = locations[0][3];
		var statutClient = locations[0][5];	
		var html = '<div id="info_content">Nom : ' + des + '<br/>Statut client : ' + statutClient + '<br/><button onclick="getSocietyDetails()">Afficher</button></div>';
		infowindow.setContent(html);
		infowindow.open(map, centralMarker);
	});

	// Add a circle overlay to the map.
	var circle = new google.maps.Circle({
		map: map,
		radius: dis,
		fillOpacity: 0,
	});

	// Binding the circle's center to the marker's position.
	circle.bindTo('center', centralMarker, 'position');
   
}


// Method executed when the event load of the window is fired.
function initialize() {
   
	var valueG = $("#donnesgps").val(); 
	var valueKM = $("#rayon").val(); 
	var valueM = parseFloat(valueKM) * 1000 + 1000;
	//console.log(valueKM);	
	var tmp = "";
    for (var i = 0; i < valueG.length; i++) {
		tmp = tmp + valueG.charAt(i);

		if (valueG.charAt(i) == "'") {
			tmp = tmp.replace("'","\"");
		}
	}
	//console.log(valueG);
	console.log(tmp);
	var arrayOfObjects = eval(tmp);
	//console.log(arrayOfObjects[0].Nom);
	
	locations = new Array();
	statuts = new Array();
	colors = new Array();
	markers = new Array();
	tmpLocations = new Array();
	realLocations = new Array();
	markersToRemove = new Array();
	markersToAdd = new Array();
	//{"UIDSoc":"SDLSUTSERD20081009H140334A00000128","Latitude":"48.854892","Longitude":"2.3565098","Nom":"MEMORIAL DE LA SHOAH","Adresse":"17, Rue Geoffroy l Asnier","ConsigneProspection":"","Color":""},
	
	for (var i = 0; i < arrayOfObjects.length; i++) {
		locations[i] = new Array();
		locations[i][0] = arrayOfObjects[i].Nom;
		locations[i][1] = arrayOfObjects[i].Latitude;
		locations[i][2] = arrayOfObjects[i].Longitude;
		locations[i][3] = arrayOfObjects[i].UIDSoc;
		//if (arrayOfObjects[i].Color == '') {
		//	locations[i][4] = 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|6dd0f7';
		//}
		//else {
		locations[i][4] = arrayOfObjects[i].Color;
		locations[i][5] = arrayOfObjects[i].StatutClient;
		//}
		//if (arrayOfObjects[i].ConsigneProspection == '') {
		//	statuts[i] = 'Société choisie';
		//}
		//else {
		statuts[i] = arrayOfObjects[i].ConsigneProspection;
		//}
		//statuts[i] = arrayOfObjects[i].ConsigneProspection;
		colors[i] = arrayOfObjects[i].Color;
	}
	
	for (var i = 0; i < arrayOfObjects.length; i++) {
		realLocations[i] = new Array();
		realLocations[i][0] = arrayOfObjects[i].Nom;
		realLocations[i][1] = arrayOfObjects[i].Latitude;
		realLocations[i][2] = arrayOfObjects[i].Longitude;
		realLocations[i][3] = arrayOfObjects[i].UIDSoc;
		//if (arrayOfObjects[i].Color == '') {
		//	realLocations[i][4] = 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|6dd0f7';
		//}
		//else {
		realLocations[i][4] = arrayOfObjects[i].Color;
		realLocations[i][5] = arrayOfObjects[i].StatutClient;
		//}
	}
	
	for (var i = 0; i < arrayOfObjects.length; i++) {
		tmpLocations[i] = new Array();
		tmpLocations[i][0] = arrayOfObjects[i].Nom;
		tmpLocations[i][1] = arrayOfObjects[i].Latitude;
		tmpLocations[i][2] = arrayOfObjects[i].Longitude;
		tmpLocations[i][3] = arrayOfObjects[i].UIDSoc;
		//if (arrayOfObjects[i].Color == '') {
		//	tmpLocations[i][4] = 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|6dd0f7';
		//}
		//else {
		tmpLocations[i][4] = arrayOfObjects[i].Color;
		tmpLocations[i][5] = arrayOfObjects[i].StatutClient;
		//}
		console.log(tmpLocations[i][4]);
	}
	
	//Error management.	
	if (locations[0][1] == "0" | locations[0][2] == "0") {
		alert("Cette société n'as pas de coordonées GPS.");
	}
	
	var uniqueNames = [];
	var uniqueColors = [];
	
	$.each(statuts, function(i, el){
		if($.inArray(el, uniqueNames) === -1)
			uniqueNames.push(el);	
	});
	
	$.each(colors, function(i, el2){
		if($.inArray(el2, uniqueColors) === -1)
			uniqueColors.push(el2);	
	});
	
	
	
	/*
	var index = uniqueNames.indexOf("");
	for (var i = 0; i < uniqueNames.length; i++) {
		if (index !== -1) {
			uniqueNames[index] = 'Autre';
		}
	}
	
	var index2 = uniqueColors.indexOf("");
	for (var i = 0; i < uniqueColors.length; i++) {
		if (index2 !== -1) {
			uniqueColors[index2] = 'http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|6dd0f7';
		}
	}*/
	
	/*console.log("uniqueNames.length 0 : " + uniqueNames[0]);
	console.log("uniqueColors.length 0 : " + uniqueColors[0]);
	console.log("uniqueNames.length 1 : " + uniqueNames[1]);
	console.log("uniqueColors.length 1 : " + uniqueColors[1]);*/
	
	for (var i = 0; i < uniqueColors.length; i++) {
		console.log("uniqueNames : " + uniqueNames[i]);
		console.log("uniqueColors : " + uniqueColors[i]);
	}
	//uniqueColors.splice(0,1);
	
	console.log("uniqueNames.length : " + uniqueNames.length);
	console.log("uniqueColors.length : " + uniqueColors.length);
	
	var lineNumber = 0;
	var mod = uniqueNames.length / 3;
	
	console.log("locations.length : " + locations.length);
	
	//uniqueNames.splice(0,1);
	
	var j = 1;

	var tdValue = '';
	
	tdValue = tdValue + '<td>' + '<img src="http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|fc0232" class="floatleft">';
	tdValue = tdValue + '<div id="image_div"><label class="label-dot">Société choisie</label></div>';
	tdValue = tdValue + '</td>'; 
	console.log("uniqueNames.length : " + uniqueNames.length);
	if (locations.length >= 2) {
		while (j < uniqueNames.length && j < 9) {
			tdValue = tdValue + '<td>' + '<img src="' + uniqueColors[j] + '" class="floatleft">';
			tdValue = tdValue + '<div id="image_div"><label class="label-dot">' + uniqueNames[j] + '</label></div>';
			tdValue = tdValue + '<div id="checkbox_div"><input class="myCheckBox" type="checkbox" name="option1" value="' + uniqueColors[j] + '" checked="checked"></div></td>'; 
			j++;
		}
	}
	tdValue = '<tr>' + tdValue + '</tr>';
	$('.legend-table').append(tdValue);
	
	var zoom;
	if (parseFloat(valueKM) <= 5) {
		zoom = 13;
	}
	else if (parseFloat(valueKM) > 5 & parseFloat(valueKM) <= 10) {
		zoom = 12;
	}
	else if (parseFloat(valueKM) > 10 & parseFloat(valueKM) <= 50) {
		zoom = 10;
	}
	else if (parseFloat(valueKM) > 50 & parseFloat(valueKM) <= 100) {
		zoom = 9;
	}
	else if (parseFloat(valueKM) > 100 & parseFloat(valueKM) <= 200) {
		zoom = 8;
	}
	else if (parseFloat(valueKM) > 200 & parseFloat(valueKM) <= 500) {
		zoom = 7;
	}
	else if (parseFloat(valueKM) > 500 & parseFloat(valueKM) <= 1000) {
		zoom = 6;
	}
	else if (parseFloat(valueKM) > 1000) {
		zoom = 5;
	}
	
	//console.log("zoom : " + zoom);
	
	// Intialize the map with options and the central point.
	// First parameter : latitude value
	// Second parameter : longitude value   
	initializeMap(locations[0][1], locations[0][2], zoom);
   
	// Add circle overlay to the map with central point and radius value.
	// First parameter : latitude value
	// Second parameter : longitude value
	// Third parameter : point description
	// Fourth parameter : radius value
	addCircleOverlay(locations[0][1], locations[0][2], locations[0][0], valueM);
	 
	// Add markers to the map.
	// First parameter : array of latitudes and longitudes.
	addMarkersToMap(locations);
   
  }
  

  // Register an event listener to fire when the page finishes loading.
  google.maps.event.addDomListener(window, 'load', initialize);