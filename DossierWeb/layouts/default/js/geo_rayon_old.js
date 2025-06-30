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
 
// Boutton nouvelle requette voir autour
$('#voirautour').live('click',function(){
	var uidsoc = $("#uidsoc").val();
	var tkm = $("#rayon").val();
	var url = "/GEO?uidsoc="+uidsoc+"&km="+tkm
	window.location = url;
});
 
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

	for (i = 1; i < locs.length; i++) { 	
		 /*orange-dot
		 purple-dot.png
		 pink-dot.png
		 ltblue-dot.png*/
		var icn = ""; 
		if (locations[i][4] == "") {
			icn = 'http://maps.google.com/mapfiles/ms/icons/red-dot.png'; 
		}	
		else {
			icn = locations[i][4]; 
		}
		// Add markers to the map.
		console.log(locations[i][4]);
		marker = new google.maps.Marker({
			position: new google.maps.LatLng(locs[i][1], locs[i][2]),
			icon: icn,
			map: map
		});

		// Add listener to the marker to show infowindow.
		google.maps.event.addListener(marker, 'click', (function(marker, i) {
			return function() {
				socUid = locations[i][3];	
				var html = '<div id="info_content">Nom : ' + locs[i][0] + '<br/><button onclick="getSocietyDetails()">Afficher</button></div>';				
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
		icon : 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png',
		map: map
	});
   
	// Initialize windowinfos to show the informations of the point.   
	var infowindow = new google.maps.InfoWindow();  
   
	// Add listener on click to the marker to show infowindow.       
	google.maps.event.addListener(centralMarker, 'click', function() {
		socUid = locations[0][3];	
		var html = '<div id="info_content">Nom : ' + des + '<br/><button onclick="getSocietyDetails()">Afficher</button></div>';
		infowindow.setContent(html);
		infowindow.open(map, centralMarker);
	});

	// Add a circle overlay to the map.
	var circle = new google.maps.Circle({
		map: map,
		radius: dis
	});

	// Binding the circle's center to the marker's position.
	circle.bindTo('center', centralMarker, 'position');
   
}


// Method executed when the event load of the window is fired.
  function initialize() {
   
	var valueG = $("#donnesgps").val(); 
	var valueKM = $("#rayon").val(); 
	var valueM = parseFloat(valueKM) * 1000 + 1000;
	console.log(valueKM);	
	var tmp = "";
    for (var i = 0; i < valueG.length; i++) {
		tmp = tmp + valueG.charAt(i);

		if (valueG.charAt(i) == "'") {
			tmp = tmp.replace("'","\"");
		}
	}
	console.log(valueG);
	console.log(tmp);
	var arrayOfObjects = eval(tmp);
	console.log(arrayOfObjects[0].Nom);
	
	locations = new Array();
	statuts = new Array();
	colors = new Array();
	//{"UIDSoc":"SDLSUTSERD20081009H140334A00000128","Latitude":"48.854892","Longitude":"2.3565098","Nom":"MEMORIAL DE LA SHOAH","Adresse":"17, Rue Geoffroy l Asnier","ConsigneProspection":"","Color":""},
	
	for (var i = 0; i < arrayOfObjects.length; i++) {
		locations[i] = new Array();
		locations[i][0] = arrayOfObjects[i].Nom;
		locations[i][1] = arrayOfObjects[i].Latitude;
		locations[i][2] = arrayOfObjects[i].Longitude;
		locations[i][3] = arrayOfObjects[i].UIDSoc;
		locations[i][4] = arrayOfObjects[i].Color;
		statuts[i] = arrayOfObjects[i].ConsigneProspection;
		colors[i] = arrayOfObjects[i].Color;
	}

	/*if (index !== -1) {
		statuts[index] = "Autre";
	}*/
	/*for (var i = 0; i < statuts.length; i++) {
		document.write(statuts[i] + "<br >");
	}*/
	//alert(statuts.join('\n'));
	
	
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
	
	var index = uniqueNames.indexOf("");
	for (var i = 0; i < uniqueNames.length; i++) {
		if (index !== -1) {
			uniqueNames[index] = "Autre";
		}
	}
	
	var index2 = uniqueColors.indexOf("");
	for (var i = 0; i < uniqueColors.length; i++) {
		if (index2 !== -1) {
			uniqueColors[index2] = "http://maps.google.com/mapfiles/ms/icons/red-dot.png";
		}
	}
	
	uniqueColors.splice(0,1);
	//delete uniqueNames[0];
	//uniqueNames.remove('undefined');


	/*for (var i = 0; i < uniqueNames.length; i++) {
		if (uniqueNames[i] == "undefined") {
			document.write(uniqueNames[i] + "<br >");
			uniqueNames.splice(i,1);
		}
	}*/
	 
	/*for (var i = 0; i < uniqueNames.length; i++) {
		document.write(uniqueNames[i] + "<br >");
	}*/	
	var lineNumber = 0;
	var mod = uniqueNames.length / 3;
	
	/*if (mod > 0) {
		lineNumber = uniqueNames.length / 3 + 1;
	}*/
	
	/*<img src="http://maps.google.com/mapfiles/ms/icons/blue-dot.png" class="floatleft">
	<label class="label-dot"></label>*/
	
	var j = 0;
	
	//for (var i = 0; i < lineNumber; i++) {
	var tdValue = '';
	while (j < uniqueNames.length && j < 9) {
		tdValue = tdValue + '<td>' + '<img src="' + uniqueColors[j] + '" class="floatleft">';
		tdValue = tdValue + '<label class="label-dot">' + uniqueNames[j] + '</label></td>';
		j++;
	}
	tdValue = '<tr>' + tdValue + '</tr>';
	$('.legend-table').append(tdValue);
	//}
	
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
	console.log("zoom : " + zoom);
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