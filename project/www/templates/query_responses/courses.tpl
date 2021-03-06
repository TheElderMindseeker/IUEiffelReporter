<div style="margin-top: 50px;">
  <div class="form-group row">
    <div class="col-sm-12 col-md-12" style="text-align: center;">
      <label style="font-size: 18pt; font-weight: normal;">Courses taught by {$labname/}</label>
    </div>
  </div>
  <div align="center">
    <div class="card-view">
      <table class="table tablesorter" id="courses">
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
  </div>
</div>
