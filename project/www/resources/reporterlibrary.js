function addInput(tableId) {
	var id = document.getElementById('id-counter').value;
	id++;
	document.getElementById('id-counter').setAttribute('value', id);
	var mainTable = document.getElementById(tableId);
	var tbody = mainTable.children[1];
	var newNode = mainTable.rows[mainTable.rows.length - 1].cloneNode(true);
	var array = newNode.getElementsByTagName('input');
	for (i=0; i<array.length; i++) {
		array[i].setAttribute('id', tableId + '-' + id + '-' + i);
		array[i].setAttribute('onBlur', 'removeRow("' + tableId + '-' + id + '");');
	}
	tbody.insertBefore(newNode, mainTable.rows[mainTable.rows.length - 2]);
	$("#to-show-" + tableId).show('slow');
	newNode.setAttribute('id', 'el-' + tableId + '-' + id);
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
  var formData = JSON.stringify($('#mainForm').serializeJSON());
  $.ajax({
    url:'http://localhost/',
    type:'POST',
    data: formData,
    success: function(res) {
      alert(res);
    }
  });
}
