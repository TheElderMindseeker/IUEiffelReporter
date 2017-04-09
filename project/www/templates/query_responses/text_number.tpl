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
        <th style="text-align: center;">{$number_column/}</th>
      </tr>
    </thead>
    <tbody>
      {foreach from="$elements" item="element"}
      <tr>
        <td>{$element.text/}</td>
        <td>{$element.number/}</td>
      </tr>
      {/foreach}
    </tbody>
  </table>
</div>
