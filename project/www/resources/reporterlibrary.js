/*!
 * IU Eiffel Reporter Library v0.1
 *
 * This is necessary part of the IU Eiffel Reporter
 * This library implements dynamic lists, part of
 * client-server interaction, etc.
 *
 * Written by Andrey Pavlenko, DANDy team
 */

function addInput(elem) {
	setTimeout(function() { _addInput(elem); }, 250);
}

function _addInput(elem) {
	//Get reference on table with given ID
	var mainTable = $(elem).parents(".table")[0];
	//Get reference on body of table
	var tbody = mainTable.children[1];
	//Clone last row of table`s body
	var newNode = mainTable.rows[mainTable.rows.length - 1].cloneNode(true);
	//Change attribute onBlur for all the inputs in new node
	var array = newNode.getElementsByTagName('input');
	var flag = false;
	for (i=0; i<array.length; i++) {
		array[i].setAttribute('onBlur', "removeRow(this);");
		if (array[i].getAttribute("placeholder") == "Required") {
			array[i].required = true;
			flag = true;
		}
	}
	if (flag) {
		newNode.setAttribute('class', 'required-row row-in-table');
	} else {
		newNode.setAttribute('class', 'row-in-table');
	}
	//Change some attributes in new node
	newNode.setAttribute('name', '');
	//Insert new node before the row with creators
	tbody.insertBefore(newNode, mainTable.rows[mainTable.rows.length - 2]);
	//Show the new node
	$(newNode).show('slow');
	reinitializeDatepickers(dateParams, newNode);
	array[0].focus();
}

function removeRow(elem) {
	setTimeout(function() { _removeRow(elem); }, 500);
}

function _removeRow(elem) {
	var parent = $(elem).parents(".row-in-table")[0];
	var array = parent.getElementsByTagName('input');
	var statement = true;
	for (i=0; i<array.length; i++) {
		statement = statement && array[i].value == '' &&  !($(array[i]).is( ":focus" ));
	}
	if (statement) {
		$(parent).hide(500, function(){
			$(this).remove();
		});
	}
}

function sendForm(e) {
	var form = document.getElementById('mainForm');
	if (checkRequiredLists(form) && checkRequiredFields(form)) {
			cleanForm();
			var formData = JSON.stringify($('#mainForm').serializeJSON());
	  	$.ajax({
	    	url:'/form',
	    	type:'POST',
		    data: formData,
	    	success: function(res) {
					Cookies.set('idOfLastAddedReport', res, { expires: ((new Date).getTime() + (24 * 60 * 60 * 1000)) });
					is_data_changed = true;
					$('#submissionSuccessModal').modal({backdrop: "static", keyboard: false, show: true});
	    	}
	  	});
	}
}

function sendQuery(e) {
	var form = document.getElementById('request');
	if (checkRequiredFields(form)) {
			var formData = JSON.stringify($('#request').serializeJSON());
			alert(formData);
	  	$.ajax({
	    	url:'/admin',
	    	type:'POST',
		    data: formData,
	    	success: function(res) {
					$('#query-result').empty();
					$('#query-result').append(res);
					$('#admin-tabs a:last').tab('show');
					alert(res);
	    	}
	  	});
	}
}

function checkCookie() {
	var id = Cookies.get('idOfLastAddedReport');
	var button = document.getElementById("edit-button");
	if (id != undefined && id != null && id != "null") {
		button.setAttribute("href", "/edit/" + id);
		button.setAttribute("class", "btn button-yellow")
	}
}

function isEmpty(str) {
  // Проверка на пустую строку.
  for (var intLoop = 0; intLoop < str.length; intLoop++)
    if (" " != str.charAt(intLoop)) return false;
  return true;
}

function checkRequiredFields(f) {
	for (var intLoop = 0; intLoop < f.elements.length; intLoop++) {
		if (null!=f.elements[intLoop].getAttribute("required")) {
			if (isEmpty(f.elements[intLoop].value)) {
				$(document.getElementById("warningModal").getElementsByClassName("modal-body")).text("You should fill all the required fields!");
				$('#warningModal').modal({backdrop: "true", show: true});
				f.elements[intLoop].focus()
				return false;
			}
		}
	}
	  return true;
}

function checkRequiredLists(f) {
	var requiredTables = f.getElementsByClassName("required-table");
	for (var i = 0; i < requiredTables.length; i++) {
		var temp = requiredTables[i].getElementsByClassName("required-row");
		if (temp.length == 0) {
			$(document.getElementById("warningModal").getElementsByClassName("modal-body")).text("You should create at least one row in each of required tables!");
			$('#warningModal').modal({backdrop: "true", show: true});
			requiredTables[i].getElementsByTagName('input')[0].focus();
			return false;
		}
	}
	return true;
}

function cleanForm() {
	var adders = document.getElementsByName("adder");
	var numberOfEntries = adders.length;
	for (i = 0; i < numberOfEntries; i++) {
		adders[0].remove();
	}
	var lines = document.getElementsByName("new-line-for-adder");
	var numberOfEntries = lines.length;
	for (i = 0; i < numberOfEntries; i++) {
		lines[0].remove();
	}
}

function reinitializeDatepickers(param, element) {
	var datepickers = element.getElementsByClassName("datepicker-here");
	var counter = datepickers.length;
	for (var i = 0; i < counter; i++) {
			var temp = datepickers[i].value;
			if (temp == "") temp = datepickers[i].getAttribute("value");
			$(datepickers[i]).datepicker().data('datepicker').destroy();
			$(datepickers[i]).datepicker(param);
			datepickers[i].setAttribute("onkeypress", "return false;");
			datepickers[i].setAttribute("oncontextmenu", "return false;");
			$(datepickers[i]).val(temp);
	}
}

var dateParams = {
	maxDate: new Date(9999, 11, 31),
	language: "en",
	dateFormat: "dd.mm.yyyy",
	autoClose: true
};
