function addInput(tableId) {
	//Get value of id counter and increase it
	var id = document.getElementById('id-counter').value;
	id++;
	document.getElementById('id-counter').setAttribute('value', id);
	//Get reference on table with given ID
	var mainTable = document.getElementById(tableId);
	//Get reference on body of table
	var tbody = mainTable.children[1];
	//Clone last row of table`s body
	var newNode = mainTable.rows[mainTable.rows.length - 1].cloneNode(true);
	//Change attribute onBlur for all the inputs in new node
	var array = newNode.getElementsByTagName('input');
	for (i=0; i<array.length; i++) {
		array[i].setAttribute('onBlur', 'removeRow("' + tableId + '-' + id + '");');
		if (array[i].getAttribute("placeholder") == "Required") {
			array[i].required = true;
		}
	}
	//Insert new node before the row with creators
	tbody.insertBefore(newNode, mainTable.rows[mainTable.rows.length - 2]);
	//Show the new node
	$("#to-show-" + tableId).show('slow');
	//Change some attributes in new node
	newNode.setAttribute('id', 'el-' + tableId + '-' + id);
	newNode.setAttribute('name', '');
	newNode.setAttribute('class', 'required-row');
	reinitializeDatepickers(dateParams, newNode);
	array[0].focus();
	/*mainTable.getElementsByName('courses-taught[][name]').focus();*/
}

function removeRow(tableId) {
	var elem = document.getElementById("el-" + tableId);
	var array = elem.getElementsByTagName('input');
	var statement = true;
	for (i=0; i<array.length; i++) {
		statement = statement && array[i].value == '';
	}
	if (statement) {
		$("#el-" + tableId).hide(500, function(){
			$(this).remove();
		});
	}
}

function sendForm(e){
	var form = document.getElementById('mainForm');
	if (checkRequiredLists(form) && checkRequiredFields(form)) {
			cleanForm();
			var formData = JSON.stringify($('#mainForm').serializeJSON());
	  	$.ajax({
	    	url:'/form',
	    	type:'POST',
		    data: formData,
	    	success: function(res) {
					$('#submissionSuccessModal').modal({backdrop: "static", keyboard: false, show: true});
	    	}
	  	});
	}
}

function isEmpty(str)
 {
  // Проверка на пустую строку.
  for (var intLoop = 0; intLoop < str.length; intLoop++)
    if (" " != str.charAt(intLoop)) return false;
  return true;
 }

function checkRequiredFields(f)
{
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
