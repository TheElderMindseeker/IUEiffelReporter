<div style="margin-top: 50px;">
  <div class="form-group row">
    <div class="col-sm-12 col-md-12" style="text-align: center;">
      <label style="font-size: 18pt; font-weight: normal;">Submitted patents</label>
    </div>
  </div>
  <div align="center">
    <div class="card-view">
      <table class="table tablesorter" id="patents">
        <thead>
          <tr>
            <th style="text-align: center;">Title of Patent</th>
            <th style="text-align: center;">Country of Patent Office</th>
          </tr>
        </thead>
        <tbody>
          {foreach from="$patents" item="patent"}
            <tr class="row-in-table">
              <td>{$patent.patent_title/}</td>
              <td>{$patent.patent_office_country/}</td>
            </tr>
          {/foreach}
        </tbody>
      </table>
    </div>
  </div>
</div>
