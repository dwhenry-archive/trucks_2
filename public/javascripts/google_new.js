/**
 * @author Dave
 */
var map;
var loaded=false;
var bounds = new GLatLngBounds();

// helper function to create markers
function createMarker(point,description,icon) {
    var marker = new GMarker(point,icon);
		
    GEvent.addListener(marker, "click", function() {
     marker.openInfoWindowHtml(description);
     });
    return marker;
}

// this is called when the page loads. 
// it initializes the map, and creates each marker
function initialize_maps() {
	if(loaded)
		return;
    map = new GMap(document.getElementById("map"));
    map.addControl(new GSmallMapControl());
	if (homeLat != '' && false) 
	    map.centerAndZoom(new GPoint(homeLat, homeLng), 6);
	else 
	    map.centerAndZoom(new GPoint(133.53, -23.48), 13);
}    

function initialize_maps_with_trip(el_name) {
    map = new GMap(document.getElementById("map"));
    map.addControl(new GSmallMapControl());
	if($(el_name))
		$(el_name).className = 'data_input_table_selected';
	setpoints(el_name + '_start',el_name + '_end');
	loaded=true;
}

function setpoints(start, stop) {
	point1 = setpoint($(start + '_lng').value, 
			$(start + '_lat').value,
			'<div><b>From Point<b><br>' + $(start + '_loc').value + + '</div>',
			G_START_ICON);

	point2 = setpoint($(stop + '_lng').value, 
			$(stop + '_lat').value,
			'<div><b>To Point<b><br>' + $(stop + '_loc').value + '</div>',
			G_END_ICON);

	bounds = new GBounds([point1, point2]);

	sw = new GLatLng(bounds.maxY, bounds.minX);
	ne = new GLatLng(bounds.minY, bounds.maxX);

	latLngBounds = new GLatLngBounds(sw, ne);

	center = latLngBounds.getCenter();
	zoom = map.getBoundsZoomLevel(latLngBounds);
	map.setCenter(center, zoom);
}

function setpoint(lng, lat,desc,icon) {
    var point = new GPoint(lng,lat);
    var marker = createMarker(point,desc,icon)
    map.addOverlay(marker);
	return point;
}
/*
// Add this to the bottom of application.js
document.observe('dom:loaded', function(){
	initialize_maps();
});
*/