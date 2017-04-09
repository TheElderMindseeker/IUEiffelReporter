<div class="form-group row">
  <div class="col-sm-6 col-md-6">
    <label class="control-label">Courses taught by {$labname/}</label>
  </div>
</div>
<div class="form-group row">
  <table class="table" id="courses">
    <thead>
      <tr>
        <th style="text-align: center;">Course Name</th>
        <th style="text-align: center;">Semester</th>
        <th style="text-align: center;">Level</th>
        <th style="text-align: center;">Number of Students</th>
      </tr>
    </thead>
    <tbody>
      {foreach from="$courses" item="course"}
      <tr>
        <td>{$course.course_name/}</td>
        <td>{$course.semester/}</td>
        <td>{$course.edu_level/}</td>
        <td>{$course.num_students/}</td>
      </tr>
      {/foreach}
    </tbody>
  </table>
</div>
