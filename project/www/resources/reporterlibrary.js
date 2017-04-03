function addInput() {
  /* default-id — скрытый элемент формы, из которого берется id для первого создаваемого элемента */
  var id = document.getElementById("default-id").value;
  id++;
  /* в форму с именем testform добавляем новый элемент */
  $("div[id=somearea]").append('<div id="div-' + id + '" style="display: none;"><input class="form-control" name="input-' + id + '" id="input-' + id + '" value="" onblur="removeIfEmpty(' + id + ')"><a href="javascript:{}" onclick="removeInput(\'' + id + '\')">Удалить</a></div>');
  $("#div-" + id).show('slow');
  /* увеличиваем счетчик элементов */
  document.getElementById("default-id").value = id;
  document.getElementsByName('input-' + id)[0].focus();
}

function printStringFromServer(str) {
  $("div[id=somearea]").append(str);
}

function getTextFromServer() {
  $.get('/request', {}, printStringFromServer(), 'text' );
}

function removeInput(id) {
  $("#div-" + id).remove();
}

function removeIfEmpty(id) {
  if (document.getElementById("input-" + id).value == ''){
    $("#div-" + id).hide(3000);
    setTimeout(function () {
      $("#div-" + id).remove();
    }, 1000);;
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
