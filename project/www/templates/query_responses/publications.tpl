<div style="margin-top: 50px;">
  <div class="form-group row">
    <div class="col-sm-6 col-md-6">
      <label for="publications" class="control-label">Conference and Journal Publications</label>
    </div>
  </div>
  <div class="form-group row">
    <table class="table" id="publications">
      <thead>
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
