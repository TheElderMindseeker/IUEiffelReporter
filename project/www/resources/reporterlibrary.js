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
	}
	//Insert new node before the row with creators
	tbody.insertBefore(newNode, mainTable.rows[mainTable.rows.length - 2]);
	//Show the new node
	$("#to-show-" + tableId).show('slow');
	//Change some attributes in new node
	newNode.setAttribute('id', 'el-' + tableId + '-' + id);
	newNode.setAttribute('name', '');
	newNode.setAttribute('class', 'required-row');
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
	clearForm();
	if (checkRequired(document.getElementById('mainForm'))) {
		var formData = JSON.stringify($('#mainForm').serializeJSON());
	  $.ajax({
	    url:'http://localhost/',
	    type:'POST',
	    data: formData,
	    success: function(res) {
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

function checkRequired(f)
{
	var requiredTables = f.getElementsByClassName("required-table");
	for (var i = 0; i < requiredTables.length; i++) {
		var temp = requiredTables[i].getElementsByClassName("required-row");
		if (temp.length == 0) {
			requiredTables[i].getElementsByTagName("input")[0].focus();
			alert("You should create at least one row in each of required tables!");
			return false;
		}
	}
	for (var intLoop = 0; intLoop < f.elements.length; intLoop++) {
		if (null!=f.elements[intLoop].getAttribute("required")) {
			if (isEmpty(f.elements[intLoop].value)) {
				f.elements[intLoop].focus();
				alert("You should fill all the required fields!");
				return false;
			}
		}
	}
	  return true;
}

function clearForm() {
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
