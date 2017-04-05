<!DOCTYPE html5>
<html>
	<head>
		<title>IU Reporter</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" charset="UTF-8">
		<link rel="stylesheet" type="text/css" href="../resources/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="../resources/bootstrap-theme.css" >
		<script type="text/javascript" src="../resources/bootstrap.min.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
		<link href="../resources/reporterlibrary.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<div class="wrapper container">
		<div class="logo-text">
			<label class="logo-text">Detailed of Report</label>
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
					<label class="view-label">{$name_of_unit/}</label>
				</div>
			</div>
			<div class="form-group row" style="margin-bottom: 25px;">
				<div class="col-sm-6 col-md-6">
					<label class="control-label">Name of head of unit</label>
				</div>
				<div class="col-sm-6 col-md-6">
					<label class="view-label">{$name_of_head_of_unit/}</label>
				</div>
			</div>
			<div class="form-group row" style="margin-bottom: 25px;">
				<div class="col-sm-6 col-md-6">
					<label class="control-label">Start of Reporting Period</label>
				</div>
				<div class="col-sm-6 col-md-6">
					<label class="view-label">{$start_date/}</label>
				</div>
			</div>
			<div class="form-group row" style="margin-bottom: 25px;">
				<div class="col-sm-6 col-md-6">
					<label class="control-label">End of Reporting Period</label>
				</div>
				<div class="col-sm-6 col-md-6">
					<label class="view-label">{$end_date/}</label>
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
							<td>{$course.name/}</td>
							<td>{$course.semester/}</td>
							<td>{$course.level/}</td>
							<td>{$course.numofst/}</td>
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
							<td>{$exam.name/}</td>
							<td>{$exam.semester/}</td>
							<td>{$exam.kindexam/}</td>
							<td>{$exam.numofst/}</td>
						</tr>
						{/foreach}
					</tbody>
				</table>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="student-supervised" class="control-label">Students supervised</label>
				</div>
			</div>
			<div class="form-group row">
				<table class="table" id="students-supervised">
					<thead>
						<tr>
							<th style="text-align: center;">Name of Student</th>
							<th style="text-align: center;">Nature of Work</th>
						</tr>
					</thead>
					<tbody>
						{foreach from="$students-supervised" item="student"}
						<tr>
							<td>{$student.name/}</td>
							<td>{$student.worknature/}</td>
						</tr>
						{/foreach}
					</tbody>
				</table>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="complete-st-reps" class="control-label">Completed student reports</label>
				</div>
			</div>
			<div class="form-group row">
				<table class="table" id="comp-stur-rep">
					<thead>
						<tr>
							<th style="text-align: center;">Name of Student</th>
							<th style="text-align: center;">Title of Report</th>
							<th style="text-align: center;">Publication Plans</th>
						</tr>
					</thead>
					<tbody>
						{foreach from="$comp-stur-rep" item="report"}
						<tr>
							<td>{$report.name/}</td>
							<td>{$report.title/}</td>
							<td>{$report.publish/}</td>
						</tr>
						{/foreach}
					</tbody>
				</table>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="complete-phd" class="control-label">Completed PhD theses</label>
				</div>
			</div>
			<div class="form-group row">
				<table class="table" id="comp-phd">
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
						{foreach from="$comp-phd" item="phd"}
						<tr>
							<td>{$phd.studentname/}</td>
							<td>{$phd.degree/}</td>
							<td>{$phd.supervisorname/}</td>
							<td>{$phd.commettee/}</td>
							<td>{$phd.institution/}</td>
							<td>{$phd.title/}</td>
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
							<th style="text-align: center;">Period Covered by Grant</th>
							<th style="text-align: center;">Whether Continuation of Other Grant</th>
							<th style="text-align: center;">Amount</th>
						</tr>
					</thead>
					<tbody>
						{foreach from="$grants" item="grant"}
						<tr>
							<td>{$grant.title/}</td>
							<td>{$grant.agency/}</td>
							<td>{$grant.period/}</td>
							<td>{$grant.continuation/}</td>
							<td>{$grant.amount/}</td>
						</tr>
						{/foreach}
					</tbody>
				</table>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="research-proj" class="control-label">Research projects</label>
				</div>
			</div>
			<div class="form-group row">
				<table class="table" id="research-proj">
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
						{foreach from="$research-proj" item="project"}
						<tr>
							<td>{$project.title/}</td>
							<td>{$project.iuperson/}</td>
							<td>{$project.extperson/}</td>
							<td>{$project.start/}</td>
		  				<td>{$project.end/}</td>
			  			<td>{$project.finance/}</td>
						</tr>
						{/foreach}
					</tbody>
				</table>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="research-collabs" class="control-label">Research collaborations</label>
				</div>
			</div>
			<div class="form-group row">
				<table class="table" id="research-collabs">
					<thead>
						<tr>
							<th style="text-align: center;">Country of Institution</th>
							<th style="text-align: center;">Name of Institution</th>
							<th style="text-align: center;">Names of Important Contacts</th>
							<th style="text-align: center;">Nature of Collaboration</th>
						</tr>
					</thead>
					<tbody>
						{foreach from="$research-collabs" item="collab"}
						<tr>
							<td>{$collab.country/}</td>
							<td>{$collab.institution/}</td>
							<td>{$collab.contacts/}</td>
							<td>{$collab.nature/}</td>
						</tr>
						{/foreach}
					</tbody>
				</table>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="conf-pubs" class="control-label">Conference publications</label>
				</div>
			</div>
			<div class="form-group row">
				<table class="table" id="conf-pubs">
					<thead>
					</thead>
					<tbody>
						{foreach from="$conf-pubs" item="pub"}
						<tr>
							<td>{$pub.text/}</td>
						</tr>
						{/foreach}
					</tbody>
				</table>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="journal-pubs" class="control-label">Journal publications</label>
				</div>
			</div>
			<div class="form-group row">
				<table class="table" id="journal-pubs">
					<thead>
					</thead>
					<tbody>
						{foreach from="$journal-pubs" item="journal"}
						<tr>
							<td>{$journal.text/}</td>
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
