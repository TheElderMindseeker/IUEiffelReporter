<!DOCTYPE html>
<html>
	<head>
		<title>IU Reporter</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" charset="UTF-8">
		<link rel="stylesheet" type="text/css" href="../resources/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="../resources/bootstrap-theme.css" >
		<script type="text/javascript" src="../resources/bootstrap.min.js"></script>

		<!-- For calendar -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
		<link href="../resources/datepicker.min.css" rel="stylesheet" type="text/css">
		<script src="../resources/datepicker.min.js"></script>
		<script src="../resources/i18n/datepicker.en.js"></script>

		<!-- For serialization -->
		<script type="text/javascript" src="../resources/jquery.serializejson.js"></script>

		<script type="text/javascript" src="../resources/reporterlibrary.js"></script>
		<link href="../resources/reporterlibrary.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<div class="wrapper container">
		<div class="logo-text">
			<label class="logo-text">Report Creation</label>
		</div>
		<div class="form">
		<form class="form-horizontal" name="mainForm" id="mainForm" method="POST" action="http://localhost/">
			<div class="form-group row">
				<div class="col-sm-6 col-md-6 " style="margin-bottom: 75px;">
					<label class="control-label" style="font-size: 24pt;">Section 1: General information</label>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="unit_name" class="control-label">Name of unit</label>
				</div>
				<div class="col-sm-6 col-md-6">
					<input type="text" class="form-control input-text" id="unit_name" name="unit_name" placeholder="Required" value="{$unit_name/}" required/>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="head_name" class="control-label">Name of head of unit</label>
				</div>
				<div class="col-sm-6 col-md-6">
					<input type="text" class="form-control input-text" id="head_name" name="head_name" placeholder="Required" value="{$head_name/}" required/>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="rep_start" class="control-label">Start of reporting period</label>
				</div>
				<div class="col-sm-6 col-md-6">
					<input type="text" class="form-control input-text datepicker-here" onkeypress="return false;" oncontextmenu="return false;" id="rep_start" name="rep_start" value="{$rep_start/}"/>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="rep_end" class="control-label">End of reporting period</label>
				</div>
				<div class="col-sm-6 col-md-6">
					<input type="text" class="form-control input-text datepicker-here" onkeypress="return false;" oncontextmenu="return false;" id="rep_end" name="rep_end" value="{$rep_end/}" />
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6 " style="margin-bottom: 75px; margin-top: 75px;">
					<label class="control-label" style="font-size: 24pt;">Section 2: Teaching</label>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="courses" class="control-label">Courses taught</label>
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
						<tr id="el-courses-{$course.id/}">
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("courses-{$course.id/}");' name="courses[][course_name]" placeholder="Required" value="{$course.course_name/}" required/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("courses-{$course.id/}");' name="courses[][semester]" placeholder="Required" value="{$course.semester/}" required/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("courses-{$course.id/}");' name="courses[][edu_level]" placeholder="Required" value="{$course.edu_level/}" required/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("courses-{$course.id/}");' name="courses[][num_students]" placeholder="Required" value="{$course.num_students/}" required/></td>
						</tr>
						{/foreach}
						<tr name="adder">
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('courses'), 500);" placeholder="Click to add new field" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('courses'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('courses'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('courses'), 500);" placeholder="" /></td>
						</tr>
						<tr id="to-show-courses" name="new-line-for-adder" style="display: none;">
							<td><input type="text" class="form-control input-in-table" name="courses[][course_name]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="courses[][semester]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="courses[][edu_level]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="courses[][num_students]" placeholder="Required" required/></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="examinations" class="control-label">Examinations</label>
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
						<tr  id="el-examinations-{$exam.id/}">
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("examinations-{$exam.id/}");' name="examinations[][course_name]" placeholder="Required" value="{$exam.course_name/}" required/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("examinations-{$exam.id/}");' name="examinations[][semester]" placeholder="Required" value="{$exam.semester/}" required/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("examinations-{$exam.id/}");' name="examinations[][exam_kind]" placeholder="Required" value="{$exam.exam_kind/}" required/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("examinations-{$exam.id/}");' name="examinations[][num_students]" placeholder="Required" value="{$exam.num_students/}" required/></td>
						</tr>
						{/foreach}
						<tr name="adder">
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('examinations'), 500);" placeholder="Click to add new field" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('examinations'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('examinations'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('examinations'), 500);" placeholder="" /></td>
						</tr>
						<tr id="to-show-examinations" name="new-line-for-adder" style="display: none;">
							<td><input type="text" class="form-control input-in-table" name="examinations[][course_name]" placeholder="Required"  required/></td>
							<td><input type="text" class="form-control input-in-table" name="examinations[][semester]" placeholder="Required"  required/></td>
							<td><input type="text" class="form-control input-in-table" name="examinations[][exam_kind]" placeholder="Required"  required/></td>
							<td><input type="text" class="form-control input-in-table" name="examinations[][num_students]" placeholder="Required"  required/></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="student-supervised" class="control-label">Students supervised</label>
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
						<tr id="el-supervised_students-{$student.id/}">
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("supervised_students-{$student.id/}");' name="supervised_students[][student_name]" placeholder="Required" value="{$student.student_name/}" required/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("supervised_students-{$student.id/}");' name="supervised_students[][nature_of_work]" placeholder="Required" value="{$student.nature_of_work/}" required/></td>
						</tr>
						{/foreach}
						<tr name="adder">
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('supervised_students'), 500);" placeholder="Click to add new field" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('supervised_students'), 500);" placeholder="" /></td>
						</tr>
						<tr id="to-show-supervised_students" name="new-line-for-adder" style="display: none;">
							<td><input type="text" class="form-control input-in-table" name="supervised_students[][student_name]" placeholder="Required"  required/></td>
							<td><input type="text" class="form-control input-in-table" name="supervised_students[][nature_of_work]" placeholder="Required"  required/></td>
						</tr>
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
						<tr id="el-student_reports-{$report.id/}">
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("student_reports-{$report.id/}");' name="student_reports[][student_name]" placeholder="Required" value="{$report.student_name/}" required/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("student_reports-{$report.id/}");' name="student_reports[][title]" placeholder="Required" value="{$report.title/}" required/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("student_reports-{$report.id/}");' name="student_reports[][publication_plans]" value="{$report.publication_plans/}"/></td>
						</tr>
						{/foreach}
						<tr name="adder">
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('student_reports'), 500);" placeholder="Click to add new field" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('student_reports'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('student_reports'), 500);" placeholder="" /></td>
						</tr>
						<tr id="to-show-student_reports" name="new-line-for-adder" style="display: none;">
							<td><input type="text" class="form-control input-in-table" name="student_reports[][student_name]" placeholder="Required"  required/></td>
							<td><input type="text" class="form-control input-in-table" name="student_reports[][title]" placeholder="Required"  required/></td>
							<td><input type="text" class="form-control input-in-table" name="student_reports[][publication_plans]" /></td>
						</tr>
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
						<tr id="el-completed_phd-{$phd.id/}">
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("completed_phd-{$phd.id/}");' name="completed_phd[][student_name]" value="{$phd.student_name/}" placeholder="Write here"/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("completed_phd-{$phd.id/}");' name="completed_phd[][degree]" value="{$phd.degree/}"/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("completed_phd-{$phd.id/}");' name="completed_phd[][supervisor_name]" value="{$phd.supervisor_name/}"/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("completed_phd-{$phd.id/}");' name="completed_phd[][other_committee_members]" value="{$phd.other_committee_members/}"/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("completed_phd-{$phd.id/}");' name="completed_phd[][degree_granting_installation]" value="{$phd.degree_granting_installation/}"/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("completed_phd-{$phd.id/}");' name="completed_phd[][dissertation_title]" value="{$phd.dissertation_title/}"/></td>
						</tr>
						{/foreach}
						<tr name="adder">
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('completed_phd'), 500);" placeholder="Click to add" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('completed_phd'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('completed_phd'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('completed_phd'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('completed_phd'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('completed_phd'), 500);" placeholder="" /></td>
						</tr>
						<tr id="to-show-completed_phd" name="new-line-for-adder" style="display: none;">
							<td><input type="text" class="form-control input-in-table" name="completed_phd[][student_name]"/></td>
							<td><input type="text" class="form-control input-in-table" name="completed_phd[][degree]"/></td>
							<td><input type="text" class="form-control input-in-table" name="completed_phd[][supervisor_name]"/></td>
							<td><input type="text" class="form-control input-in-table" name="completed_phd[][other_committee_members]" /></td>
							<td><input type="text" class="form-control input-in-table" name="completed_phd[][degree_granting_installation]"/></td>
							<td><input type="text" class="form-control input-in-table" name="completed_phd[][dissertation_title]"/></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6 " style="margin-bottom: 75px; margin-top: 75px;">
					<label class="control-label" style="font-size: 24pt;">Section 3: Researches</label>
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
						<tr id="el-grants-{$grant.id/}">
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("grants-{$grant.id/}");' name="grants[][project_title]" placeholder="Required" value="{$grant.project_title/}" required/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("grants-{$grant.id/}");' name="grants[][granting_agency]" placeholder="Required" value="{$grant.granting_agency/}" required/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("grants-{$grant.id/}");' name="grants[][start_date]" placeholder="Required" value="{$grant.start_date/}" required/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("grants-{$grant.id/}");' name="grants[][end_date]" placeholder="Required" value="{$grant.end_date/}" required/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("grants-{$grant.id/}");' name="grants[][is_continuation]" placeholder="Required" value="{$grant.is_continuation/}" required/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("grants-{$grant.id/}");' name="grants[][amount]" placeholder="Required" value="{$grant.amount/}" required/></td>
						</tr>
						{/foreach}
						<tr name="adder">
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('grants'), 500);" placeholder="Click to add" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('grants'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('grants'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('grants'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('grants'), 500);" placeholder="" /></td>
						</tr>
						<tr id="to-show-grants" name="new-line-for-adder" style="display: none;">
							<td><input type="text" class="form-control input-in-table" name="grants[][project_title]" placeholder="Required" required /></td>
							<td><input type="text" class="form-control input-in-table" name="grants[][agency]" placeholder="Required" required /></td>
							<td><input type="text" class="form-control input-in-table" name="grants[][start_date]" placeholder="Required" required /></td>
							<td><input type="text" class="form-control input-in-table" name="grants[][end_date]" placeholder="Required" required /></td>
							<td><input type="text" class="form-control input-in-table" name="grants[][is_continuation]" placeholder="Required" required /></td>
							<td><input type="text" class="form-control input-in-table" name="grants[][amount]" placeholder="Required" required /></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="research_projects" class="control-label">Research projects</label>
				</div>
			</div>
			<div class="form-group row">
				<table class="table" id="research_projects">
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
						<tr id="el-research_projects-{$project.id/}">
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("research_projects-{$project.id/}");' name="research_projects[][project_title]" placeholder="Required" value="{$project.project_title/}" required/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("research_projects-{$project.id/}");' name="research_projects[][iu_personnel_involved]" placeholder="Required" value="{$project.iu_personnel_involved/}" required/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("research_projects-{$project.id/}");' name="research_projects[][external_personnel_involved]" value="{$project.external_personnel_involved/}"/></td>
							<td><input type="text" class="form-control input-in-table datepicker-here" onblur='removeRow("research_projects-{$project.id/}");' onkeypress="return false;" oncontextmenu="return false;" name="research_projects[][start_date]" placeholder="Required" value="{$project.start_date/}" required/></td>
							<td><input type="text" class="form-control input-in-table datepicker-here" onblur='removeRow("research_projects-{$project.id/}");' onkeypress="return false;" oncontextmenu="return false;" name="research_projects[][expected_end_date]" placeholder="Required" value="{$project.expected_end_date/}" required/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("research_projects-{$project.id/}");' name="research_projects[][financial_sources]" placeholder="Required" value="{$project.financial_sources/}" required/></td>
						</tr>
						{/foreach}
						<tr name="adder">
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('research_projects'), 500);" placeholder="Click to add" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('research_projects'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('research_projects'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('research_projects'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('research_projects'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('research_projects'), 500);" placeholder="" /></td>
						</tr>
						<tr id="to-show-research_projects" name="new-line-for-adder" style="display: none;">
							<td><input type="text" class="form-control input-in-table" name="research_projects[][project_title]" placeholder="Required"  required/></td>
							<td><input type="text" class="form-control input-in-table" name="research_projects[][iu_personnel_involved]" placeholder="Required"  required/></td>
							<td><input type="text" class="form-control input-in-table" name="research_projects[][external_personnel_involved]" /></td>
							<td><input type="text" class="form-control input-in-table" name="research_projects[][start_date]" placeholder="Required" onkeypress="return false;" oncontextmenu="return false;" onFocus="$(this).datepicker();" required/></td>
							<td><input type="text" class="form-control input-in-table" name="research_projects[][expected_end_date]" placeholder="Required" onkeypress="return false;" oncontextmenu="return false;" onFocus="$(this).datepicker();" required/></td>
							<td><input type="text" class="form-control input-in-table" name="research_projects[][financial_sources]" placeholder="Required"  required/></td>
						</tr>
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
						<tr id="el-research_collaborations-{$collaboration.id/}">
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("research_collaborations-{$collaboration.id/}");' name="research_collaborations[][installation_country]" value="{$collaboration.installation_country/}" placeholder="Write here"/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("research_collaborations-{$collaboration.id/}");' name="research_collaborations[][installation_name]" value="{$collaboration.installation_name/}"/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("research_collaborations-{$collaboration.id/}");' name="research_collaborations[][installation_department]" value="{$collaboration.installation_department/}"/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("research_collaborations-{$collaboration.id/}");' name="research_collaborations[][contacts]" value="{$collaboration.contacts/}"/></td>
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("research_collaborations-{$collaboration.id/}");' name="research_collaborations[][nature_of_collaboration]" value="{$collaboration.nature_of_collaboration/}"/></td>
						</tr>
						{/foreach}
						<tr name="adder">
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('research_collaborations'), 500);" placeholder="Click to add new field" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('research_collaborations'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('research_collaborations'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('research_collaborations'), 500);" placeholder="" /></td>
						</tr>
						<tr id="to-show-research_collaborations" name="new-line-for-adder" style="display: none;">
							<td><input type="text" class="form-control input-in-table" name="research_collaborations[][installation_country]" placeholder="Write here" /></td>
							<td><input type="text" class="form-control input-in-table" name="research_collaborations[][installation_name]" /></td>
							<td><input type="text" class="form-control input-in-table" name="research_collaborations[][installation_department]" /></td>
							<td><input type="text" class="form-control input-in-table" name="research_collaborations[][contacts]" /></td>
							<td><input type="text" class="form-control input-in-table" name="research_collaborations[][nature_of_collaboration]" /></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="publications" class="control-label">Conference And Journal Publications</label>
				</div>
				<div class="col-sm-6 col-md-6">
						<label for="publications" class="help-label">Use standard style for scientific bibliography entries.</label>
				</div>
			</div>
			<div class="form-group row">
				<table class="table" id="publications">
					<thead>
					</thead>
					<tbody>
						{foreach from="$publications" item="publication"}
						<tr id="el-publications-{$publication.id/}">
							<td><input type="text" class="form-control input-in-table" onblur='removeRow("publications-{$publication.id/}");' name="publications[][publication_name]" placeholder="Write here" value="{$publication.publication_name/}"/></td>
						</tr>
						{/foreach}
						<tr name="adder">
							<td><input type="text" class="form-control input-in-table" onFocus="setTimeout(addInput('publications'), 500);" placeholder="Click to add new field" /></td>
						</tr>
						<tr id="to-show-publications" name="new-line-for-adder" style="display: none;">
							<td><input type="text" class="form-control input-in-table" name="publications[][publication_name]" placeholder="Write here" /></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="form-group row">
				<div class="col-md-12">
					<button type="button" class="btn button-yellow" id="submit" name="submit" style="font-size: 30pt; display:block; margin:10px auto; width:320px; height:80px;">Submit</button>
				</div>
			</div>
			</form>
			</div>
		</div>
		<input id="id-counter" type="hidden" value="0" />
		<div class="footer">
    Developed by <label class="team-logo">DANDy</label> team
  </div>
  <script>
  var submitButton = document.mainForm.submit;
		submitButton.addEventListener("click", sendForm);
	</script>
	</body>
</html>
