function getLoadMatchesData(start_lat, start_lng, end_lat, end_lng, load_type,authenticityToken) {
    new Effect.BlindUp('match_data', {
        duration: 0.5,
        delay: 0.0
    });

	var date = new Date();
	var curDate = null;

    new Ajax.Request('/loads/match_data', {
        parameters: $H({
            authenticity_token: authenticityToken,
            start_lat: start_lat,
            start_lng: start_lng,
            end_lat: end_lat,
            end_lng: end_lng,
            load_type: load_type
        }).toQueryString(),
        method: 'get',
        onSuccess: function(request) {
            $('match_data').innerHTML = request.responseText; 
        },
        onComplete:
            function(){

            while(curDate-date < 500)
            { curDate = new Date(); }

            new Effect.BlindDown('match_data', {
                duration: 0.5,
                delay: 0.0
            })

            //new Element.hide('spinner');
        }
    });
}
function showLoginScript(url) {
    new Ajax.Request(url, {
        method: 'get',
		onSuccess: function(request) {
			$('user_bar').innerHTML = request.responseText;
		}
    });
}

function processAddress(el,authenticityToken) {
    disableSubmitButton();
	valid = true;
	if(el.value == '')
		valid = false;
	else {
	    new Ajax.Request('/dashboard/geolookup', {
			parameters: $H({
				authenticity_token: authenticityToken,
				location: el.value
			}).toQueryString(),
	        method: 'get',
			onSuccess: function(request) {
				resp = eval( "(" + request.responseText + ")" );
				if(resp.status != 'success') 
					valid = false;
				else {
					el.value = resp.address;
					getElemByType(el,'lat').value = resp.lat;
					getElemByType(el,'lng').value = resp.lng;
				}
			},
			onComplete: function(request) {
				// update the google found status image	
				if(valid == false) {
					// set the appropriate error code
					getElemByType(el,"status").className = 'google_error';
					getElemByType(el,'lat') = '';
					getElemByType(el,'lng') = '';
				} else {
					// set the appropriate success code
					getElemByType(el,"status").className = 'google_found';
					if($('load_start_lng').value != '' && $('load_end_lng').value != '')
						setpoints('load_start','load_end');
				}
                enableSubmitButton();
			}
	    });
	}

}

function getElemByType(el, stype) {
	if(stype == 'status') {
		if(el.id == 'load_start_loc') return $('load_from');
		if(el.id == 'load_end_loc') return $('load_to');
	}
	if(stype == 'lng') {
		if(el.id == 'load_start_loc') return $('load_start_lng');
		if(el.id == 'load_end_loc') return $('load_end_lng');
	}
	if(stype == 'lat') {
		if(el.id == 'load_start_loc') return $('load_start_lat');
		if(el.id == 'load_end_loc') return $('load_end_lat');
	}

}
