<div style="margin-top: 50px;">
  <div class="form-group row">
    <div class="col-sm-6 col-md-6">
      <label class="control-label">Patents submitted by {$labname/}</label>
    </div>
  </div>
  <div class="form-group row">
    <table class="table" id="patents">
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
