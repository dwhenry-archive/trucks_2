var cal_obj2 = null;

var format = '%j %M %Y';

var current_field ;
var comp_field = '';

// show calendar
//function show_cal(el, fname, language, comp_f){
//	show_cal(el, language, comp_f);
//}

function show_cal(el, language, comp_f) {
	current_field = el;
	comp_field = comp_f;
	if (cal_obj2) return;

var text_field = current_field;

	cal_obj2 = new RichCalendar();
	cal_obj2.start_week_day = 0;
	cal_obj2.show_time = false;
	cal_obj2.language = language;
	cal_obj2.user_onchange_handler = cal2_on_change;
	cal_obj2.user_onclose_handler = cal2_on_close;
	cal_obj2.user_onautoclose_handler = cal2_on_autoclose;
	
	cal_obj2.parse_date(text_field.value, format);
	//cal_obj2.show_at_element(text_field, "adj_right-top");
	cal_obj2.show_at_element(text_field, "adj_left-bottom");
	//cal_obj2.change_skin('alt');

}

// user defined onchange handler
function cal2_on_change(cal, object_code) {
	if (object_code == 'day') {

		// check if date is in the future..
		var today = new Date();
		
		var month = today.getMonth() + 1;
		var day = today.getDate();
		var year = today.getFullYear();
		
		var str = month + "/" + day + "/" + year;
		//alert(str);
		
		var today_date = new Date(str);

		var selected = new Date(cal.get_formatted_date(format));
		
		difference = selected - today_date;
		
		// use > -1 instead of >= 0 to resolve issue with time value within today component
		if ((difference > -1 && comp_field == 'after') || (difference < 1 && comp_field == 'before') || (comp_field == 'none')) { 
			current_field.value = cal.get_formatted_date(format);			
			cal.hide();
			cal_obj2 = null;
		} else {
			alert('Selected Date does not meet criteria.. '); // + today_date + '" "' + selected + '" "' + difference +'"' 
		}

	}
}

// user defined onclose handler (used in pop-up mode - when auto_close is true)
function cal2_on_close(cal) {
	//if (window.confirm('Are you sure to close the calendar?')) {
		cal.hide();
		cal_obj2 = null;
	//}
}

// user defined onautoclose handler
function cal2_on_autoclose(cal) {
	cal_obj2 = null;
}