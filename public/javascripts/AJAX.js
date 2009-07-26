/**
 * @author Dave
 */
function showLoginScript(url) {
    new Ajax.Request(url, {
        method: 'get',
		onSuccess: function(request) {
			$('user_bar').innerHTML = request.responseText;
		}
    });
}

function processAddress(el) {
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
				$('user_bar').innerHTML = request.responseText;
			},
			onComplete: function(request) {
				// update the google found status image	
				if(valid == false) {
					// set the appropriate error code
					getElemByType(el,"status").classname = 'google_error';
				} else {
					// set the appropriate success code
					getElemByType(el,"status").classname = 'google_found';
				}
			}
	    });
	}

}

function getElemByType(el, stype) {
	if(stype == 'status') {
		if(el.id == 'load_start_loc') return 'load_from';
		if(el.id == 'load_end_loc') return 'load_to';
	}
}
