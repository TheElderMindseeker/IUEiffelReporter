<!DOCTYPE html>
<html>
	<head>
		<title>Report Creation - IU Eiffel Reporter</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" charset="UTF-8">
		<script type="text/javascript" src="../resources/jquery-3.2.0.min.js"></script>
		<script type="text/javascript" src="../resources/bootstrap.min.js"></script>
		<script type="text/javascript" src="../resources/datepicker.min.js"></script>
		<script type="text/javascript" src="../resources/i18n/datepicker.en.js"></script>
		<script type="text/javascript" src="../resources/jquery.serializejson.js"></script>
		<script type="text/javascript" src="../resources/js.cookie.js"></script>
		<script type="text/javascript" src="../resources/reporterlibrary.js"></script>
		<link rel="stylesheet" type="text/css" href="../resources/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="../resources/bootstrap-theme.css">
		<link type="text/css" rel="stylesheet" href="../resources/datepicker.min.css">
		<link type="text/css" rel="stylesheet" href="../resources/reporterlibrary.css">
	</head>
	<body onload="formInitialization();">
		<div class="wrapper container">
			<div class="logo-text">
				<label class="logo-text">Report Creation</label>
			</div>
			<div class="form">
				<form class="form-horizontal" name="mainForm" id="mainForm" action="/form">
					<ul id="form-tabs" class="nav nav-tabs" role="tablist">
						<li class="active"><a href="#general-info" aria-controls="general-info" role="tab" data-toggle="tab">General information</a></li>
						<li><a href="#teaching" aria-controls="teaching" role="tab" data-toggle="tab">Teaching</a></li>
						<li><a href="#researches" aria-controls="researches" role="tab" data-toggle="tab">Researches</a></li>
						<li><a href="#technology-transfer" aria-controls="technology-transfer" role="tab" data-toggle="tab">Technology Transfer</a></li>
						<li><a href="#distinctions" aria-controls="distinctions" role="tab" data-toggle="tab">Distinctions</a></li>
						<li><a href="#outside-activities" aria-controls="outside-activities" role="tab" data-toggle="tab">Outside Activities</a></li>
						<li><a href="#other-information" aria-controls="other-information" role="tab" data-toggle="tab">Other Information</a></li>
					</ul>
					<div class="tab-content">
						<div role="tabpanel" class="tab-pane fade in active" id="general-info">
							<div class="form-group row">
								<div class="col-sm-6 col-md-6 " style="margin-bottom: 75px; margin-top: 30px;">
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
										<input type="text" class="form-control input-text datepicker-here" id="rep_start" name="rep_start" value="{$rep_start/}"/>
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 col-md-6">
										<label for="rep_end" class="control-label">End of reporting period</label>
									</div>
									<div class="col-sm-6 col-md-6">
										<input type="text" class="form-control input-text datepicker-here" id="rep_end" name="rep_end" value="{$rep_end/}" />
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-4 col-md-4">
									</div>
									<div class="col-sm-4 col-md-4">
									</div>
									<div class="col-sm-4 col-md-4">
										<button type="button" class="button-yellow btn" onclick="$('#form-tabs li:eq(1) a').tab('show');" style="font-size: 24pt; width:260px; height:70px; display:block; margin:7% auto 7% auto;">Go Next!</button>
									</div>
								</div>
							</div>
							<div role="tabpanel" class="tab-pane fade" id="teaching">
								<div class="form-group row">
									<div class="col-sm-6 col-md-6 " style="margin-bottom: 75px; margin-top: 30px;">
										<label class="control-label" style="font-size: 24pt;">Section 2: Teaching</label>
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 col-md-6">
										<label for="courses" class="control-label">Courses taught</label>
									</div>
									<div class="col-sm-6 col-md-6">
										<label for="publications" class="help-label"><label style="color:red;">*</label>Required</label>
									</div>
								</div>
								<div class="form-group row">
									<table class="table required-table" id="courses">
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
												<tr class="required-row row-in-table">
													<td><input type="text" class="form-control input-in-table" onblur="removeRow(this);" name="courses[][course_name]" placeholder="Required" value="{$course.course_name/}" required/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="courses[][semester]" placeholder="Required" value="{$course.semester/}" required/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="courses[][edu_level]" placeholder="Required" value="{$course.edu_level/}" required/></td>
													<td><input type="text" class="form-control input-in-table digit-only" onBlur="removeRow(this);" name="courses[][num_students]" placeholder="Required" value="{$course.num_students/}" required/></td>
												</tr>
												{/foreach}
											<tr name="adder">
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="Click to add new field" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
											</tr>
											<tr name="new-line-for-adder" style="display: none;">
												<td><input type="text" class="form-control input-in-table" name="courses[][course_name]" placeholder="Required"/></td>
												<td><input type="text" class="form-control input-in-table" name="courses[][semester]" placeholder="Required"/></td>
												<td><input type="text" class="form-control input-in-table" name="courses[][edu_level]" placeholder="Required"/></td>
												<td><input type="text" class="form-control input-in-table digit-only" name="courses[][num_students]" placeholder="Required"/></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 col-md-6">
										<label for="examinations" class="control-label">Examinations</label>
									</div>
									<div class="col-sm-6 col-md-6">
										<label for="publications" class="help-label"><label style="color:red;">*</label>Required</label>
									</div>
								</div>
								<div class="form-group row">
									<table class="table required-table" id="examinations">
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
												<tr class="required-row row-in-table">
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="examinations[][course_name]" placeholder="Required" value="{$exam.course_name/}" required/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="examinations[][semester]" placeholder="Required" value="{$exam.semester/}" required/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="examinations[][exam_kind]" placeholder="Required" value="{$exam.exam_kind/}" required/></td>
													<td><input type="text" class="form-control input-in-table digit-only" onBlur="removeRow(this);" name="examinations[][num_students]" placeholder="Required" value="{$exam.num_students/}" required/></td>
												</tr>
											{/foreach}
											<tr name="adder">
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="Click to add new field" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
											</tr>
											<tr name="new-line-for-adder" style="display: none;">
												<td><input type="text" class="form-control input-in-table" name="examinations[][course_name]" placeholder="Required"/></td>
												<td><input type="text" class="form-control input-in-table" name="examinations[][semester]" placeholder="Required"/></td>
												<td><input type="text" class="form-control input-in-table" name="examinations[][exam_kind]" placeholder="Required"/></td>
												<td><input type="text" class="form-control input-in-table digit-only" name="examinations[][num_students]" placeholder="Required"/></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 col-md-6">
										<label for="student-supervised" class="control-label">Students supervised</label>
									</div>
									<div class="col-sm-6 col-md-6">
										<label for="publications" class="help-label"><label style="color:red;">*</label>Required</label>
									</div>
								</div>
								<div class="form-group row">
									<table class="table required-table" id="supervised_students">
										<thead>
											<tr>
												<th style="text-align: center;">Name of Student</th>
												<th style="text-align: center;">Nature of Work</th>
											</tr>
										</thead>
										<tbody>
											{foreach from="$supervised_students" item="student"}
												<tr class="required-row row-in-table">
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="supervised_students[][student_name]" placeholder="Required" value="{$student.student_name/}" required/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="supervised_students[][nature_of_work]" placeholder="Required" value="{$student.nature_of_work/}" required/></td>
												</tr>
											{/foreach}
											<tr name="adder">
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="Click to add new field" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
											</tr>
											<tr name="new-line-for-adder" style="display: none;">
												<td><input type="text" class="form-control input-in-table" name="supervised_students[][student_name]" placeholder="Required"/></td>
												<td><input type="text" class="form-control input-in-table" name="supervised_students[][nature_of_work]" placeholder="Required"/></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 col-md-6">
										<label for="student_reports" class="control-label">Completed student reports</label>
									</div>
									<div class="col-sm-6 col-md-6">
										<label for="publications" class="help-label"><label style="color:red;">*</label>Required</label>
									</div>
								</div>
								<div class="form-group row">
									<table class="table required-table" id="student_reports">
										<thead>
											<tr>
												<th style="text-align: center;">Name of Student</th>
												<th style="text-align: center;">Title of Report</th>
												<th style="text-align: center;">Publication Plans</th>
											</tr>
										</thead>
										<tbody>
											{foreach from="$student_reports" item="report"}
												<tr class="required-row row-in-table">
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="student_reports[][student_name]" placeholder="Required" value="{$report.student_name/}" required/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="student_reports[][title]" placeholder="Required" value="{$report.title/}" required/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="student_reports[][publication_plans]" value="{$report.publication_plans/}"/></td>
												</tr>
											{/foreach}
											<tr name="adder">
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="Click to add new field" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
											</tr>
											<tr name="new-line-for-adder" style="display: none;">
												<td><input type="text" class="form-control input-in-table" name="student_reports[][student_name]" placeholder="Required"/></td>
												<td><input type="text" class="form-control input-in-table" name="student_reports[][title]" placeholder="Required" /></td>
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
												<tr class="row-in-table">
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="completed_phd[][student_name]" value="{$phd.student_name/}" placeholder="Write here"/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="completed_phd[][degree]" value="{$phd.degree/}"/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="completed_phd[][supervisor_name]" value="{$phd.supervisor_name/}"/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="completed_phd[][other_committee_members]" value="{$phd.other_committee_members/}"/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="completed_phd[][degree_granting_installation]" value="{$phd.degree_granting_installation/}"/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="completed_phd[][dissertation_title]" value="{$phd.dissertation_title/}"/></td>
												</tr>
											{/foreach}
											<tr name="adder">
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="Click to add" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
											</tr>
											<tr name="new-line-for-adder" style="display: none;">
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
									<div class="col-sm-4 col-md-4">
										<button type="button" class="button-yellow btn" onclick="$('#form-tabs li:eq(0) a').tab('show');" style="font-size: 24pt; width:260px; height:70px; display:block; margin:7% auto 7% auto;">Go Back!</button>
									</div>
									<div class="col-sm-4 col-md-4">
									</div>
									<div class="col-sm-4 col-md-4">
										<button type="button" class="button-yellow btn" onclick="$('#form-tabs li:eq(2) a').tab('show');" style="font-size: 24pt; width:260px; height:70px; display:block; margin:7% auto 7% auto;">Go Next!</button>
									</div>
								</div>
							</div>
							<div role="tabpanel" class="tab-pane fade" id="researches">
								<div class="form-group row">
									<div class="col-sm-6 col-md-6 " style="margin-bottom: 75px; margin-top: 30px;">
										<label class="control-label" style="font-size: 24pt;">Section 3: Researches</label>
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 col-md-6">
										<label for="grants" class="control-label">Grants</label>
									</div>
									<div class="col-sm-6 col-md-6">
										<label for="publications" class="help-label"><label style="color:red;">*</label>Required</label>
									</div>
								</div>
								<div class="form-group row">
									<table class="table required-table" id="grants">
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
												<tr class="required-row row-in-table">
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="grants[][project_title]" placeholder="Required" value="{$grant.project_title/}" required/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="grants[][granting_agency]" placeholder="Required" value="{$grant.granting_agency/}" required/></td>
													<td><input type="text" class="form-control input-in-table datepicker-here" onBlur="removeRow(this);" name="grants[][start_date]" placeholder="Required" value="{$grant.start_date/}" required/></td>
													<td><input type="text" class="form-control input-in-table datepicker-here" onBlur="removeRow(this);" name="grants[][end_date]" placeholder="Required" value="{$grant.end_date/}" required/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="grants[][is_continuation]" placeholder="Required" value="{$grant.is_continuation/}" required/></td>
													<td><input type="text" class="form-control input-in-table digit-only" onBlur="removeRow(this);" name="grants[][amount]" placeholder="Required" value="{$grant.amount/}" required/></td>
												</tr>
											{/foreach}
											<tr name="adder">
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="Click to add" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
											</tr>
											<tr name="new-line-for-adder" style="display: none;">
												<td><input type="text" class="form-control input-in-table" name="grants[][project_title]" placeholder="Required" /></td>
												<td><input type="text" class="form-control input-in-table" name="grants[][granting_agency]" placeholder="Required" /></td>
												<td><input type="text" class="form-control input-in-table datepicker-here" name="grants[][start_date]" placeholder="Required" /></td>
												<td><input type="text" class="form-control input-in-table datepicker-here" name="grants[][end_date]" placeholder="Required" /></td>
												<td><input type="text" class="form-control input-in-table" name="grants[][is_continuation]" placeholder="Required" /></td>
												<td><input type="text" class="form-control input-in-table digit-only" name="grants[][amount]" placeholder="Required" /></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 col-md-6">
										<label for="research_projects" class="control-label">Research projects</label>
									</div>
									<div class="col-sm-6 col-md-6">
										<label for="publications" class="help-label"><label style="color:red;">*</label>Required</label>
									</div>
								</div>
								<div class="form-group row">
									<table class="table required-table" id="research_projects">
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
												<tr class="required-row row-in-table">
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="research_projects[][project_title]" placeholder="Required" value="{$project.project_title/}" required/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="research_projects[][iu_personnel_involved]" placeholder="Required" value="{$project.iu_personnel_involved/}" required/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="research_projects[][external_personnel_involved]" value="{$project.external_personnel_involved/}"/></td>
													<td><input type="text" class="form-control input-in-table datepicker-here" onBlur="removeRow(this);" name="research_projects[][start_date]" placeholder="Required" value="{$project.start_date/}" required/></td>
													<td><input type="text" class="form-control input-in-table datepicker-here" onBlur="removeRow(this);" name="research_projects[][expected_end_date]" placeholder="Required" value="{$project.expected_end_date/}" required/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="research_projects[][financial_sources]" placeholder="Required" value="{$project.financial_sources/}" required/></td>
												</tr>
												{/foreach}
												<tr name="adder">
													<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="Click to add" /></td>
													<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
													<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
													<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
													<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
													<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
												</tr>
												<tr name="new-line-for-adder" style="display: none;">
													<td><input type="text" class="form-control input-in-table" name="research_projects[][project_title]" placeholder="Required"/></td>
													<td><input type="text" class="form-control input-in-table" name="research_projects[][iu_personnel_involved]" placeholder="Required"/></td>
													<td><input type="text" class="form-control input-in-table" name="research_projects[][external_personnel_involved]" /></td>
													<td><input type="text" class="form-control input-in-table datepicker-here" name="research_projects[][start_date]" placeholder="Required"/></td>
													<td><input type="text" class="form-control input-in-table datepicker-here" name="research_projects[][expected_end_date]" placeholder="Required"/></td>
													<td><input type="text" class="form-control input-in-table" name="research_projects[][financial_sources]" placeholder="Required"/></td>
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
													<tr class="row-in-table">
														<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="research_collaborations[][installation_country]" value="{$collaboration.installation_country/}" placeholder="Write here"/></td>
														<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="research_collaborations[][installation_name]" value="{$collaboration.installation_name/}"/></td>
														<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="research_collaborations[][installation_department]" value="{$collaboration.installation_department/}"/></td>
														<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="research_collaborations[][contacts]" value="{$collaboration.contacts/}"/></td>
														<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="research_collaborations[][nature_of_collaboration]" value="{$collaboration.nature_of_collaboration/}"/></td>
													</tr>
												{/foreach}
												<tr name="adder">
													<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="Click to add new field" /></td>
													<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
													<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
													<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
													<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
												</tr>
												<tr name="new-line-for-adder" style="display: none;">
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
													<tr class="row-in-table">
														<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="publications[][publication_name]" placeholder="Write here" value="{$publication.publication_name/}"/></td>
													</tr>
												{/foreach}
												<tr name="adder">
													<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="Click to add new field" /></td>
												</tr>
												<tr name="new-line-for-adder" style="display: none;">
													<td><input type="text" class="form-control input-in-table" name="publications[][publication_name]" placeholder="Write here" /></td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="form-group row">
										<div class="col-sm-4 col-md-4">
											<button type="button" class="button-yellow btn" onclick="$('#form-tabs li:eq(1) a').tab('show');" style="font-size: 24pt; width:260px; height:70px; display:block; margin:7% auto 7% auto;">Go Back!</button>
										</div>
										<div class="col-sm-4 col-md-4">
										</div>
										<div class="col-sm-4 col-md-4">
											<button type="button" class="button-yellow btn" onclick="$('#form-tabs li:eq(3) a').tab('show');" style="font-size: 24pt; width:260px; height:70px; display:block; margin:7% auto 7% auto;">Go Next!</button>
										</div>
									</div>
								</div>
								<div role="tabpanel" class="tab-pane fade" id="technology-transfer">
								<div class="form-group row">
									<div class="col-sm-6 col-md-6 " style="margin-bottom: 75px; margin-top: 30px;">
										<label class="control-label" style="font-size: 24pt;">Section 4: Technology Transfer</label>
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 col-md-6">
										<label for="patents" class="control-label">Patents</label>
									</div>
									<div class="col-sm-6 col-md-6">
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
													<td><input type="text" class="form-control input-in-table" onblur="removeRow(this);" name="patents[][patent_title]" value="{$patent.patent_title/}"/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="patents[][patent_office_country]" value="{$patent.patent_office_country/}"/></td>
												</tr>
												{/foreach}
											<tr name="adder">
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="Click to add new field" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
											</tr>
											<tr name="new-line-for-adder" style="display: none;">
												<td><input type="text" class="form-control input-in-table" name="patents[][patent_title]"/></td>
												<td><input type="text" class="form-control input-in-table" name="patents[][patent_office_country]"/></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 col-md-6">
										<label for="licenses" class="control-label">IP Licenses</label>
									</div>
									<div class="col-sm-6 col-md-6">
									</div>
								</div>
								<div class="form-group row">
									<table class="table" id="licenses">
										<thead>
											<tr>
												<th style="text-align: center;">License Info</th>
											</tr>
										</thead>
										<tbody>
											{foreach from="$licenses" item="license"}
												<tr class="row-in-table">
													<td><input type="text" class="form-control input-in-table" onblur="removeRow(this);" name="licenses[][patent_title]" value="{$license.patent_title/}"/></td>
												</tr>
												{/foreach}
											<tr name="adder">
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="Click to add new field" /></td>
											</tr>
											<tr name="new-line-for-adder" style="display: none;">
												<td><input type="text" class="form-control input-in-table" name="licenses[][patent_title]"/></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="form-group row">
									<div class="col-sm-4 col-md-4">
										<button type="button" class="button-yellow btn" onclick="$('#form-tabs li:eq(2) a').tab('show');" style="font-size: 24pt; width:260px; height:70px; display:block; margin:7% auto 7% auto;">Go Back!</button>
									</div>
									<div class="col-sm-4 col-md-4">
									</div>
									<div class="col-sm-4 col-md-4">
										<button type="button" class="button-yellow btn" onclick="$('#form-tabs li:eq(4) a').tab('show');" style="font-size: 24pt; width:260px; height:70px; display:block; margin:7% auto 7% auto;">Go Next!</button>
									</div>
								</div>
							</div>
							<div role="tabpanel" class="tab-pane fade" id="distinctions">
								<div class="form-group row">
									<div class="col-sm-6 col-md-6 " style="margin-bottom: 75px; margin-top: 30px;">
										<label class="control-label" style="font-size: 24pt;">Section 5: Distinctions</label>
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 col-md-6">
										<label for="papers" class="control-label">Best paper awards</label>
									</div>
									<div class="col-sm-6 col-md-6">
									</div>
								</div>
								<div class="form-group row">
									<table class="table" id="papers">
										<thead>
											<tr>
												<th style="text-align: center;">Authors</th>
												<th style="text-align: center;">Title of Paper</th>
												<th style="text-align: center;">Awarding Conference or Journal</th>
												<th style="text-align: center;">Exact Wording of Award</th>
												<th style="text-align: center;">Date</th>
											</tr>
										</thead>
										<tbody>
											{foreach from="$best_paper_awards" item="paper"}
												<tr class="row-in-table">
													<td><input type="text" class="form-control input-in-table" onblur="removeRow(this);" name="best_paper_awards[][authors]" value="{$paper.authors/}"/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="best_paper_awards[][title]" value="{$paper.title/}"/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="best_paper_awards[][awarding_installation]" value="{$paper.awarding_installation/}"/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="best_paper_awards[][award_exact_wording]" value="{$paper.award_exact_wording/}"/></td>
													<td><input type="text" class="form-control input-in-table datepicker-here" onBlur="removeRow(this);" name="best_paper_awards[][awarding_date]" value="{$paper.awarding_date/}"/></td>
												</tr>
												{/foreach}
											<tr name="adder">
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="Click to add new field" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
											</tr>
											<tr name="new-line-for-adder" style="display: none;">
												<td><input type="text" class="form-control input-in-table" name="best_paper_awards[][authors]"/></td>
												<td><input type="text" class="form-control input-in-table" name="best_paper_awards[][title]"/></td>
												<td><input type="text" class="form-control input-in-table" name="best_paper_awards[][awarding_installation]"/></td>
												<td><input type="text" class="form-control input-in-table" name="best_paper_awards[][award_exact_wording]"/></td>
												<td><input type="text" class="form-control input-in-table datepicker-here" name="best_paper_awards[][awarding_date]"/></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 col-md-6">
										<label for="memberships" class="control-label">Memberships</label>
									</div>
									<div class="col-sm-6 col-md-6">
									</div>
								</div>
								<div class="form-group row">
									<table class="table" id="memberships">
										<thead>
											<tr>
												<th style="text-align: center;">Name of Member</th>
												<th style="text-align: center;">Date of Membership</th>
											</tr>
										</thead>
										<tbody>
											{foreach from="$memberships" item="membership"}
												<tr class="row-in-table">
													<td><input type="text" class="form-control input-in-table" onblur="removeRow(this);" name="memberships[][member_name]" value="{$membership.member_name/}"/></td>
													<td><input type="text" class="form-control input-in-table datepicker-here" onBlur="removeRow(this);" name="memberships[][membership_date]" value="{$membership.membership_date/}"/></td>
												{/foreach}
											<tr name="adder">
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="Click to add new field" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
											</tr>
											<tr name="new-line-for-adder" style="display: none;">
												<td><input type="text" class="form-control input-in-table" name="memberships[][member_name]"/></td>
												<td><input type="text" class="form-control input-in-table datepicker-here" name="memberships[][membership_date]"/></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 col-md-6">
										<label for="prizes" class="control-label">Prizes</label>
									</div>
									<div class="col-sm-6 col-md-6">
									</div>
								</div>
								<div class="form-group row">
									<table class="table" id="prizes">
										<thead>
											<tr>
												<th style="text-align: center;">Name of Recipient</th>
												<th style="text-align: center;">Name of Prize</th>
												<th style="text-align: center;">Grantig Institution</th>
												<th style="text-align: center;">Date</th>
											</tr>
										</thead>
										<tbody>
											{foreach from="$prizes" item="prize"}
												<tr class="row-in-table">
													<td><input type="text" class="form-control input-in-table" onblur="removeRow(this);" name="prizes[][recipient_name]" value="{$prize.recipient_name/}"/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="prizes[][prize_name]" value="{$prize.prize_name/}"/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="prizes[][granting_installation]" value="{$prize.granting_installation/}"/></td>
													<td><input type="text" class="form-control input-in-table digit-only" onBlur="removeRow(this);" name="prizes[][prizing_date]" value="{$prize.prizing_date/}"/></td>
												</tr>
												{/foreach}
											<tr name="adder">
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="Click to add new field" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
											</tr>
											<tr name="new-line-for-adder" style="display: none;">
												<td><input type="text" class="form-control input-in-table" name="prizes[][recipient_name]"/></td>
												<td><input type="text" class="form-control input-in-table" name="prizes[][prize_name]"/></td>
												<td><input type="text" class="form-control input-in-table" namenum_s="prizes[][granting_installation]"/></td>
												<td><input type="text" class="form-control input-in-table datepicker-here" name="prizes[][prizing_date]"/></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="form-group row">
									<div class="col-sm-4 col-md-4">
										<button type="button" class="button-yellow btn" onclick="$('#form-tabs li:eq(3) a').tab('show');" style="font-size: 24pt; width:260px; height:70px; display:block; margin:7% auto 7% auto;">Go Back!</button>
									</div>
									<div class="col-sm-4 col-md-4">
									</div>
									<div class="col-sm-4 col-md-4">
										<button type="button" class="button-yellow btn" onclick="$('#form-tabs li:eq(5) a').tab('show');" style="font-size: 24pt; width:260px; height:70px; display:block; margin:7% auto 7% auto;">Go Next!</button>
									</div>
								</div>
							</div>
							<div role="tabpanel" class="tab-pane fade" id="outside-activities">
								<div class="form-group row">
									<div class="col-sm-6 col-md-6 " style="margin-bottom: 75px; margin-top: 30px;">
										<label class="control-label" style="font-size: 24pt;">Section 6: Outside Activities</label>
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 col-md-6">
										<label for="industry_collaborations" class="control-label">Industry collaborations</label>
									</div>
									<div class="col-sm-6 col-md-6">
									</div>
								</div>
								<div class="form-group row">
									<table class="table" id="industry_collaborations">
										<thead>
											<tr>
												<th style="text-align: center;">Company</th>
												<th style="text-align: center;">Nature of Collaboration</th>
											</tr>
										</thead>
										<tbody>
											{foreach from="$industry_collaborations" item="industry_collaboration"}
												<tr class="row-in-table">
													<td><input type="text" class="form-control input-in-table" onblur="removeRow(this);" name="industry_collaborations[][company]" value="{$industry_collaboration.company/}"/></td>
													<td><input type="text" class="form-control input-in-table" onBlur="removeRow(this);" name="industry_collaborations[][nature_of_collaboration]" value="{$industry_collaboration.nature_of_collaboration/}"/></td>
												</tr>
												{/foreach}
											<tr name="adder">
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="Click to add new field" /></td>
												<td><input type="text" class="form-control input-in-table" onFocus="addInput(this);" placeholder="" /></td>
											</tr>
											<tr name="new-line-for-adder" style="display: none;">
												<td><input type="text" class="form-control input-in-table" name="industry_collaborations[][company]"/></td>
												<td><input type="text" class="form-control input-in-table" name="industry_collaborations[][nature_of_collaboration]"/></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="form-group row">
									<div class="col-sm-4 col-md-4">
										<button type="button" class="button-yellow btn" onclick="$('#form-tabs li:eq(4) a').tab('show');" style="font-size: 24pt; width:260px; height:70px; display:block; margin:7% auto 7% auto;">Go Back!</button>
									</div>
									<div class="col-sm-4 col-md-4">
									</div>
									<div class="col-sm-4 col-md-4">
										<button type="button" class="button-yellow btn" onclick="$('#form-tabs li:eq(6) a').tab('show');" style="font-size: 24pt; width:260px; height:70px; display:block; margin:7% auto 7% auto;">Go Next!</button>
									</div>
								</div>
							</div>
							<div role="tabpanel" class="tab-pane fade" id="other-information">
								<div class="form-group row">
									<div class="col-sm-6 col-md-6 " style="margin-bottom: 75px; margin-top: 30px;">
										<label class="control-label" style="font-size: 24pt;">Section 7: Other Information</label>
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
										<textarea class="form-control input-text" id="relevant_info" name="relevant_info" rows="4" style="width: 100%; margin-top: 20px;" value="{$relevant_info/}"></textarea>
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-4 col-md-4">
										<button type="button" class="button-yellow btn" onclick="$('#form-tabs li:eq(5) a').tab('show');" style="font-size: 24pt; width:260px; height:70px; display:block; margin:7% auto 7% auto;">Go Back!</button>
									</div>
									<div class="col-sm-4 col-md-4">
										<button type="button" class="btn button-yellow" id="submit" name="submit" style="font-size: 30pt; display:block; margin:10px auto; width:320px; height:80px;">Submit</button>
									</div>
									<div class="col-sm-4 col-md-4">
									</div>
								</div>
							</div>
							<input type="hidden" value="{$id/}" name="id"/>
					</div>
				</form>
			</div>
		</div>
		<input id="is-data-submitted" type="hidden" value="" />
		<div class="footer">
    	Developed by <label class="team-logo">DANDy</label> team
  	</div>
		<div id="warningModal" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Warning!</h4>
					</div>
					<div class="modal-body"></div>
					<div class="modal-footer"><button class="btn btn-danger" type="button" data-dismiss="modal">Close (ESC)</button></div>
				</div>
			</div>
		 </div>
		 <div id="submissionSuccessModal" class="modal fade">
 			<div class="modal-dialog">
 				<div class="modal-content">
 					<div class="modal-header">
 						<h4 class="modal-title">Submission succeed!</h4>
 					</div>
 					<div class="modal-body">Your report was submitted successfully.</div>
 					<div class="modal-footer"><a href="/" class="btn btn-success">Ok</a></div>
 				</div>
 			</div>
 		 </div>
	</body>
</html>
