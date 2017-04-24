<div style="margin-top: 50px;">
  <div class="form-group row">
    <div class="col-sm-12 col-md-12" style="text-align: center;">
      <label style="font-size: 18pt; font-weight: normal;">{$pagename/}</label>
    </div>
  </div>
  <div align="center">
    <div class="card-view">
      <table class="table tablesorter" id="courses">
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
  </div>
</div>
