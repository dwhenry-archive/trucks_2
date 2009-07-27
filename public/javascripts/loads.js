/**
 * @author Dave
 */
function selectLoadRow(el) {
	if(el.className == 'data_input_table_selected')
		return;
		
	// set all classes to 
	rows = $('data_table').childNodes;
	for(i=0;i<rows.length;i++) {
		rows[i].className = "data_input_table_row";
	}
	
	el.className = 'data_input_table_selected';
	setpoints(el.id + '_start',el.id + '_end');
}
