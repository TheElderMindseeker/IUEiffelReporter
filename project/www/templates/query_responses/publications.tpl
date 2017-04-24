<div style="margin-top: 50px;">
  <div class="form-group row">
    <div class="col-sm-12 col-md-12" style="text-align: center;">
      <label style="font-size: 18pt; font-weight: normal;">Conference and Journal Publications</label>
    </div>
  </div>
  <div align="center">
    <div class="card-view">
      <table class="table tablesorter" id="publications">
        <thead>
          <th style="text-align: center;">Click here to sort</th>
        </thead>
        <tbody>
          {foreach from="$publications" item="publication"}
          <tr>
            <td>{$publication.publication_name/}</td>
          </tr>
          {/foreach}
        </tbody>
      </table>
    </div>
  </div>
</div>
