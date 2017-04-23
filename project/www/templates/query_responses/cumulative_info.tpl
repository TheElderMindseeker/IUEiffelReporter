<div style="margin-top: 50px;">
  <div class="form-group row">
    <div class="col-sm-6 col-md-6">
      <label class="control-label">Other relevant info of {$labname/} by several years</label>
    </div>
  </div>
  <div class="form-group row">
    <table class="table" id="courses">
      {foreach from="$labinfos" item="labinfo"}
      <div class="form-group row" style="margin-bottom: 25px;">
        <div class="col-sm-6 col-md-6" >
          <label class="control-label">Name of unit</label>
        </div>
        <div class="col-sm-6 col-md-6">
          <label class="view-label">{$labinfo.unit_name/}</label>
        </div>
      </div>
      <div class="form-group row" style="margin-bottom: 25px;">
        <div class="col-sm-6 col-md-6">
          <label class="control-label">Name of head of unit</label>
        </div>
        <div class="col-sm-6 col-md-6">
          <label class="view-label">{$labinfo.head_name/}</label>
        </div>
      </div>
      <div class="form-group row" style="margin-bottom: 25px;">
        <div class="col-sm-6 col-md-6">
          <label class="control-label">Start of Reporting Period</label>
        </div>
        <div class="col-sm-6 col-md-6">
          <label class="view-label">{$labinfo.rep_start/}</label>
        </div>
      </div>
      <div class="form-group row" style="margin-bottom: 25px;">
        <div class="col-sm-6 col-md-6">
          <label class="control-label">End of Reporting Period</label>
        </div>
        <div class="col-sm-6 col-md-6">
          <label class="view-label">{$labinfo.rep_end/}</label>
        </div>
      </div>
      <div class="form-group row">
        <div class="col-sm-6 col-md-6">
          <label for="relevant_info" class="control-label">Other relevant information</label>
        </div>
        <div class="col-sm-6 col-md-6">
        </div>
      </div>
      <div class="form-group row">
        <div class="col-sm-12 col-md-12">
          {$labinfo.relevant_info/}
        </div>
      </div>
      {/foreach}
      </tbody>
    </table>
  </div>
</div>
