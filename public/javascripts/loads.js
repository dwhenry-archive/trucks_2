/**
 * @author Dave
 */
function selectLoadRow(el,authenticityToken) {
	if(el.className == 'data_input_table_selected')
		return;
		
	// set all classes to 
	rows = $('data_table').childNodes;
	for(i=0;i<rows.length;i++) {
		rows[i].className = "data_input_table_row";
	}
	
	el.className = 'data_input_table_selected';
	setpoints(el.id + '_start',el.id + '_end');

    // call AJAX function to update matches table..
    getLoadMatchesData($(el.id + '_start_lat').value, $(el.id + '_start_lng').value,
            $(el.id + '_end_lat').value,$(el.id + '_end_lng').value,$(el.id + '_load_type').value,
            authenticityToken)
}

function disableSubmitButton() {
    $('load_submit').disabled = true;
}

function enableSubmitButton() {
    if($('load_start_lat').value != '' && $('load_end_lat').value != '') {
        $('load_submit').disabled = false;
    }
}