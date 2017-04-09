<!DOCTYPE html>
<html>
	<head>
		<title>{$unit_name/} - Detailed View - IU Eiffel Reporter</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" charset="UTF-8">
		<script type="text/javascript" src="resources/jquery-3.2.0.min.js"></script>
		<script type="text/javascript" src="../resources/bootstrap.min.js"></script>
		<link type="text/css" rel="stylesheet" href="../resources/bootstrap.css">
		<link type="text/css" rel="stylesheet" href="../resources/bootstrap-theme.css" >
		<link type="text/css" rel="stylesheet" href="../resources/reporterlibrary.css">
	</head>
	<body>
		<div class="wrapper container">
		<div class="logo-text">
			<label class="logo-text">Detailed view of Report</label>
		</div>
		<div class="form">
			<div class="form-group row">
				<div class="col-sm-6 col-md-6" style="margin-bottom: 75px;">
					<label class="control-label section-label">Section 1: General information</label>
				</div>
			</div>
			<div class="form-group row" style="margin-bottom: 25px;">
				<div class="col-sm-6 col-md-6" >
					<label class="control-label">Name of unit</label>
				</div>
				<div class="col-sm-6 col-md-6">
					<label class="view-label">{$unit_name/}</label>
				</div>
			</div>
			<div class="form-group row" style="margin-bottom: 25px;">
				<div class="col-sm-6 col-md-6">
					<label class="control-label">Name of head of unit</label>
				</div>
				<div class="col-sm-6 col-md-6">
					<label class="view-label">{$head_name/}</label>
				</div>
			</div>
			<div class="form-group row" style="margin-bottom: 25px;">
				<div class="col-sm-6 col-md-6">
					<label class="control-label">Start of Reporting Period</label>
				</div>
				<div class="col-sm-6 col-md-6">
					<label class="view-label">{$rep_start/}</label>
				</div>
			</div>
			<div class="form-group row" style="margin-bottom: 25px;">
				<div class="col-sm-6 col-md-6">
					<label class="control-label">End of Reporting Period</label>
				</div>
				<div class="col-sm-6 col-md-6">
					<label class="view-label">{$rep_end/}</label>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6 " style="margin-bottom: 75px; margin-top: 75px;">
					<label class="control-label section-label">Section 2: Teaching</label>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label class="control-label">Courses taught</label>
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
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label class="control-label">Examinations</label>
				</div>
			</div>
			<div class="form-group row">
				<table class="table" id="examinations">
					<thead>
						<tr>
							<th style="text-align: center;">Course Name</th>
							<th style="text-align: center;">Semester</th>
							<th style="text-align: center;">Kind of Exam</th>
							<th style="text-align: center;">Number of Students</th>
						</tr>
					</thead>
					<tbody>
						{foreach from="$examinations" item="exam"}
						<tr>
							<td>{$exam.course_name/}</td>
							<td>{$exam.semester/}</td>
							<td>{$exam.exam_kind/}</td>
							<td>{$exam.num_students/}</td>
						</tr>
						{/foreach}
					</tbody>
				</table>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="supervised_students" class="control-label">Students supervised</label>
				</div>
			</div>
			<div class="form-group row">
				<table class="table" id="supervised_students">
					<thead>
						<tr>
							<th style="text-align: center;">Name of Student</th>
							<th style="text-align: center;">Nature of Work</th>
						</tr>
					</thead>
					<tbody>
						{foreach from="$supervised_students" item="student"}
						<tr>
							<td>{$student.student_name/}</td>
							<td>{$student.nature_of_work/}</td>
						</tr>
						{/foreach}
					</tbody>
				</table>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="student_reports" class="control-label">Completed student reports</label>
				</div>
			</div>
			<div class="form-group row">
				<table class="table" id="student_reports">
					<thead>
						<tr>
							<th style="text-align: center;">Name of Student</th>
							<th style="text-align: center;">Title of Report</th>
							<th style="text-align: center;">Publication Plans</th>
						</tr>
					</thead>
					<tbody>
						{foreach from="$student_reports" item="report"}
						<tr>
							<td>{$report.student_name/}</td>
							<td>{$report.title/}</td>
							<td>{$report.publication_plans/}</td>
						</tr>
						{/foreach}
					</tbody>
				</table>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="completed_phd" class="control-label">Completed PhD theses</label>
				</div>
			</div>
			<div class="form-group row">
				<table class="table" id="completed_phd">
					<thead>
						<tr>
							<th style="text-align: center;">Student Name</th>
							<th style="text-align: center;">Degree</th>
							<th style="text-align: center;">Name of Supervisor</th>
							<th style="text-align: center;">Names of Commettee members</th>
							<th style="text-align: center;">Name of Degree-Granting Institution</th>
							<th style="text-align: center;">Title of Dissertation</th>
						</tr>
					</thead>
					<tbody>
						{foreach from="$completed_phd" item="phd"}
						<tr>
							<td>{$phd.student_name/}</td>
							<td>{$phd.degree/}</td>
							<td>{$phd.supervisor_name/}</td>
							<td>{$phd.other_committee_members/}</td>
							<td>{$phd.degree_granting_installation/}</td>
							<td>{$phd.dissertation_title/}</td>
						</tr>
						{/foreach}
					</tbody>
				</table>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6 " style="margin-bottom: 75px; margin-top: 75px;">
					<label class="control-label section-label">Section 3: Researches</label>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="grants" class="control-label">Grants</label>
				</div>
			</div>
			<div class="form-group row">
				<table class="table" id="grants">
					<thead>
						<tr>
							<th style="text-align: center;">Title of Project</th>
							<th style="text-align: center;">Granting Agency</th>
							<th style="text-align: center;">Start Date of the Period Covered by Grant</th>
							<th style="text-align: center;">End Date</th>
							<th style="text-align: center;">Whether Continuation of Other Grant</th>
							<th style="text-align: center;">Amount</th>
						</tr>
					</thead>
					<tbody>
						{foreach from="$grants" item="grant"}
						<tr>
							<td>{$grant.project_title/}</td>
							<td>{$grant.granting_agency/}</td>
							<td>{$grant.start_date/}</td>
							<td>{$grant.end_date/}</td>
							<td>{$grant.is_continuation/}</td>
							<td>{$grant.amount/}</td>
						</tr>
						{/foreach}
					</tbody>
				</table>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="research_projects" class="control-label">Research projects</label>
				</div>
			</div>
			<div class="form-group row">
				<table class="table" id="rresearch_projects">
					<thead>
						<tr>
							<th style="text-align: center;">Title of Project</th>
							<th style="text-align: center;">IU Personnel Involved</th>
							<th style="text-align: center;">External Personnel Involved</th>
							<th style="text-align: center;">Start Date</th>
							<th style="text-align: center;">Expected End Date</th>
							<th style="text-align: center;">Source of Financing</th>
						</tr>
					</thead>
					<tbody>
						{foreach from="$research_projects" item="project"}
						<tr>
							<td>{$project.project_title/}</td>
							<td>{$project.iu_personnel_involved/}</td>
							<td>{$project.external_personnel_involved/}</td>
							<td>{$project.start_date/}</td>
		  				<td>{$project.expected_end_date/}</td>
			  			<td>{$project.financial_sources/}</td>
						</tr>
						{/foreach}
					</tbody>
				</table>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="research_collaborations" class="control-label">Research collaborations</label>
				</div>
			</div>
			<div class="form-group row">
				<table class="table" id="research_collaborations">
					<thead>
						<tr>
							<th style="text-align: center;">Country of Institution</th>
							<th style="text-align: center;">Name of Institution</th>
							<th style="text-align: center;">Department</th>
							<th style="text-align: center;">Names of Important Contacts</th>
							<th style="text-align: center;">Nature of Collaboration</th>
						</tr>
					</thead>
					<tbody>
						{foreach from="$research_collaborations" item="collaboration"}
						<tr>
							<td>{$collaboration.installation_country/}</td>
							<td>{$collaboration.installation_name/}</td>
							<td>{$collaboration.installation_department/}</td>
							<td>{$collaboration.contacts/}</td>
							<td>{$collaboration.nature_of_collaboration/}</td>
						</tr>
						{/foreach}
					</tbody>
				</table>
			</div>
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
		</div>
		<div class="footer">
    Developed by <label class="team-logo">DANDy</label> team
  </div>
	</body>
</html>
