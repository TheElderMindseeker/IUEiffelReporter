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
	setTimeout(function() { _addInput(elem); }, 100);
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
	onlyDigitsInitialization(newNode);
	deleteTechnicalSymbols(newNode)
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

function formInitialization() {
	var submitButton = document.mainForm.submit;
	submitButton.addEventListener("click", sendForm);
	window.onbeforeunload = function () {
		return ((!isDataSubmitted()) ? "The data is not submitted. Do you really want to leave the page?" : null);
	}
	setTimeout(function() { reinitializeDatepickers(dateParams, document); }, 500);
	document.getElementById("is-data-submitted").setAttribute("value", "false");
	onlyDigitsInitialization(document);
	deleteTechnicalSymbols(document);
}

function deleteTechnicalSymbols(elem) {
	var digitInputs = elem.getElementsByClassName("form-control");
	var counter = digitInputs.length;
	for (var i = 0; i < counter; i++) {
		$(digitInputs[i]).bind("change keyup input click", function() {
			if (this.value.match(/[`'"\\]/g)) {
				this.value = this.value.replace(/[`'"\\]/g, '');
			}
		});
	}
}

function onlyDigitsInitialization(elem) {
	var digitInputs = elem.getElementsByClassName("digit-only");
	var counter = digitInputs.length;
	for (var i = 0; i < counter; i++) {
		$(digitInputs[i]).bind("change keyup input click", function() {
			if (this.value.match(/[^0-9]/g)) {
				this.value = this.value.replace(/[^0-9]/g, '');
			}
		});
	}
}

function adminPageInitialization() {
		var submitButton = document.request.submit;
		submitButton.addEventListener("click", sendQuery);
		setTimeout(function() {  $("#list-of-reports").tablesorter(); reinitializeDatepickers(dateParams, document); }, 500);
}

function isDataSubmitted() {
	return (document.getElementById("is-data-submitted").getAttribute("value") == "true");
}

function sendForm(e) {
	var form = document.getElementById('mainForm');
	if (checkRequiredLists(document) && checkRequiredFields(form)) {
			var modal = document.getElementById("submissionMobdal");
			$(modal.getElementsByClassName("modal-title")[0]).text("Submission in progress");
			$(modal.getElementsByClassName("message")[0]).text("Submission in progress. Please, wait!");
			$('#submissionMobdal').modal({backdrop: "static", keyboard: false, show: true});
			cleanForm();
			var formData = JSON.stringify($('#mainForm').serializeJSON());
	  	$.ajax({
	    	url:'/form',
	    	type:'POST',
		    data: formData,
	    	success: function(res) {
					$(modal.getElementsByClassName("modal-title")[0]).empty();
					$(modal.getElementsByClassName("modal-title")[0]).text("Submission succeed!");
					$(modal.getElementsByClassName("message")[0]).empty();
					$(modal.getElementsByClassName("message")[0]).text("Your report was submitted successfully.");
					modal.getElementsByClassName("active")[0].setAttribute("class", "progress progress-striped");
					modal.getElementsByClassName("disabled")[0].setAttribute("class", "btn btn-success");
					Cookies.set('idOfLastAddedReport', res, { expires: ((new Date).getTime() + (24 * 60 * 60 * 1000)) });
					document.getElementById("is-data-submitted").setAttribute("value", "true");
	    	},
				error: function() {
					$(modal.getElementsByClassName("modal-title")[0]).empty();
					$(modal.getElementsByClassName("modal-title")[0]).text("Submission failed!");
					$(modal.getElementsByClassName("message")[0]).empty();
					$(modal.getElementsByClassName("message")[0]).text("Something has gone wrong. Please, try again later.");
					modal.getElementsByClassName("active")[0].setAttribute("class", "progress progress-striped");
					modal.getElementsByClassName("disabled")[0].setAttribute("class", "btn btn-danger");
				}
	  	});
	}
}

function sendQuery(e) {
	var form = document.getElementById('request');
	if (checkRequiredFields(form)) {
			var formData = JSON.stringify($('#request').serializeJSON());
	  	$.ajax({
	    	url:'/admin',
	    	type:'POST',
		    data: formData,
	    	success: function(res) {
					$('#query-result').empty();
					$('#query-result').append(res);
					$(".tablesorter").tablesorter();
					$('#admin-tabs a:last').tab('show');
	    	}
	  	});
	}
}

function requestDeletion(id, name) {
	var modal = document.getElementById("deletionModal");
	$(modal.getElementsByClassName("modal-title")[0]).empty();
	$(modal.getElementsByClassName("message")[0]).empty();
	$(modal.getElementsByClassName("modal-title")[0]).text("Deletion of " + name);
	$(modal.getElementsByClassName("message")[0]).text("Deletion of " + name + " in progress. Please, wait!");
	$('#deletionModal').modal({backdrop: "static", keyboard: false, show: true});
	$.ajax({
		url:'/delete/' + id,
	  type:'GET',
	  data: '',
		timeout: 10000,
  	success: function() {
			$(modal.getElementsByClassName("message")[0]).empty();
			$(modal.getElementsByClassName("message")[0]).text("Deletion complete!");
			modal.getElementsByClassName("active")[0].setAttribute("class", "progress progress-striped");
			modal.getElementsByClassName("disabled")[0].setAttribute("class", "btn btn-danger");
    },
		error: function() {
			$(modal.getElementsByClassName("message")[0]).empty();
			$(modal.getElementsByClassName("message")[0]).text("Something has gone wrong. Please, try again later.");
			modal.getElementsByClassName("active")[0].setAttribute("class", "progress progress-striped");
			modal.getElementsByClassName("disabled")[0].setAttribute("class", "btn btn-danger");
		}
	});
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
			var tab = $(requiredTables[i]).parents(".tab-pane")[0];
			var id = tab.getAttribute("id");
			$('#form-tabs a[href="#' + id + '"]').tab('show');
			setTimeout(function() { requiredTables[i].getElementsByTagName('input')[0].focus(); }, 250);
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

function isNumber(elem) {
	var str = elem.value;
  var re = /^[-]?\d*\.?\d*$/;
  str = str.toString();
  if (!str.match(re)) {
		elem.setAttribute("value", "");
	  elem.focus();
	  elem.select();
    return false;
  }
  return true;
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
