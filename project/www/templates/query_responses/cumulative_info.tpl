<div style="margin-top: 50px;">
  <div class="form-group row">
    <div class="col-sm-12 col-md-12" style="text-align: center;">
      <label style="font-size: 18pt; font-weight: normal;">Other relevant info of {$labname/} by several years</label>
    </div>
  </div>
  <div align="center">
    {foreach from="$labinfos" item="labinfo"}
      <div class="card-view" style="margin-top: 30px;">
        <div class="form-group row" style="margin-top: 10px;">
          <div class="col-sm-6 col-md-6" >
            <label class="control-label" style="padding-top: 10px;">Name of unit</label>
          </div>
          <div class="col-sm-6 col-md-6" align="left">
            <label class="bordered-lable">{$labinfo.unit_name/}</label>
          </div>
        </div>
        <div class="form-group row" style="margin-bottom: 10px;">
          <div class="col-sm-6 col-md-6">
            <label class="control-label" style="padding-top: 10px;">Name of head of unit</label>
          </div>
          <div class="col-sm-6 col-md-6" align="left">
            <label class="bordered-lable">{$labinfo.head_name/}</label>
          </div>
        </div>
        <div class="form-group row" style="margin-bottom: 10px;">
          <div class="col-sm-6 col-md-6">
            <label class="control-label" style="padding-top: 10px;">Start of Reporting Period</label>
          </div>
          <div class="col-sm-6 col-md-6" align="left">
            <label class="bordered-lable">{$labinfo.rep_start/}</label>
          </div>
        </div>
        <div class="form-group row" style="margin-bottom: 10px;">
          <div class="col-sm-6 col-md-6">
            <label class="control-label" style="padding-top: 10px;">End of Reporting Period</label>
          </div>
          <div class="col-sm-6 col-md-6" align="left">
            <label class="bordered-lable">{$labinfo.rep_end/}</label>
          </div>
        </div>
        <div class="form-group row">
          <div class="col-sm-6 col-md-6" align="right">
            <label style="font-weight: normal; font-size: 14pt; padding-top: 10px; padding-bottom: 10px;">Other relevant information</label>
          </div>
          <div class="col-sm-6 col-md-6">
          </div>
        </div>
        <div class="form-group row">
          <div class="col-sm-12 col-md-12" align="center">
            <label class="bordered-lable" style="text-align: left;">{$labinfo.relevant_info/}</label>
          </div>
        </div>
      </div>
    {/foreach}
  </div>
</div>
