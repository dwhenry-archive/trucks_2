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
