<div class="form-group row">
  <div class="col-sm-6 col-md-6">
    <label class="control-label">Courses taught</label>
  </div>
</div>
<div class="form-group row">
  <table class="table" id="courses">
    <thead>
      <tr>
        <th style="text-align: center;">{$text_column/}</th>
        <th style="text-align: center;">{$string_column/}</th>
      </tr>
    </thead>
    <tbody>
      {foreach from="$elements" item="text_string"}
      <tr>
        <td>{$course.text/}</td>
        <td>{$course.number/}</td>
      </tr>
      {/foreach}
    </tbody>
  </table>
</div>
