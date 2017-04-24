<!DOCTYPE html>
<html>
	<head>
		<title>{$unit_name/} - Detailed View - IU Eiffel Reporter</title>
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
	<body>
		<div class="wrapper container">
			<div class="logo-text">
				<label class="logo-text">Detailed view of Report - {$unit_name/}</label>
			</div>
			<div class="form">
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
							<div class="form-group row" style="margin-bottom: 25px;">
								<div class="col-sm-6 col-md-6" >
									<table style="right: 10px; position: absolute;">
										<tr>
											<td><a href="/edit/{$id/}" class="btn btn-primary" role="button" style="margin-right: 4px;">Edit</a></td>
											<td ><button onclick="requestDeletion('{$id/}', '{$unit_name/}');"type="button" class="btn btn-danger">Delete</button></td>
										</tr>
									</table>
								</div>
								<div class="col-sm-6 col-md-6">
									<a href="/export_json/{$id/}" class="btn btn-success" role="button">Export to JSON</a>
									<a href="/export_xml/{$id/}" class="btn btn-success" role="button">Export to XML</a>

								</div>
							</div>
							<div align="center">
								<div class="form-group row" style="margin-top: 10px;">
									<div class="col-sm-6 col-md-6" >
										<label class="control-label" style="padding-top: 10px;">Name of unit</label>
									</div>
									<div class="col-sm-6 col-md-6" align="left">
										<label class="bordered-lable">{$unit_name/}</label>
									</div>
								</div>
									<div class="form-group row" style="margin-top: 10px;">
										<div class="col-sm-6 col-md-6" >
											<label class="control-label" style="padding-top: 10px;">Report ID</label>
										</div>
										<div class="col-sm-6 col-md-6" align="left">
											<label class="bordered-lable">{$id/}</label>
										</div>
									</div>
								<div class="form-group row" style="margin-bottom: 10px;">
									<div class="col-sm-6 col-md-6">
										<label class="control-label" style="padding-top: 10px;">Name of head of unit</label>
									</div>
									<div class="col-sm-6 col-md-6" align="left">
										<label class="bordered-lable">{$head_name/}</label>
									</div>
								</div>
								<div class="form-group row" style="margin-bottom: 10px;">
									<div class="col-sm-6 col-md-6">
										<label class="control-label" style="padding-top: 10px;">Start of Reporting Period</label>
									</div>
									<div class="col-sm-6 col-md-6" align="left">
										<label class="bordered-lable">{$rep_start/}</label>
									</div>
								</div>
								<div class="form-group row" style="margin-bottom: 10px;">
									<div class="col-sm-6 col-md-6">
										<label class="control-label" style="padding-top: 10px;">End of Reporting Period</label>
									</div>
									<div class="col-sm-6 col-md-6" align="left">
										<label class="bordered-lable">{$rep_end/}</label>
									</div>
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
												<tr class="row-in-table">
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
												<tr class="row-in-table">
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
												<tr class="row-in-table">
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
												<tr class="row-in-table">
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
												<tr class="row-in-table">
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
												<tr class="row-in-table">
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
												<tr class="row-in-table">
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
													<tr class="row-in-table">
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
											<label for="publications" class="control-label">Conference And Journal Publications</label>
										</div>
									</div>
									<div class="form-group row">
										<table class="table" id="publications">
											<thead>
											</thead>
											<tbody>
												{foreach from="$publications" item="publication"}
													<tr class="row-in-table">
														<td>{$publication.publication_name/}</td>
													</tr>
												{/foreach}
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
													<td>{$patent.patent_title/}</td>
													<td>{$patent.patent_office_country/}</td>
												</tr>
												{/foreach}
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
													<td>{$license.patent_title/}</td>
												</tr>
												{/foreach}
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
													<td>{$paper.authors/}</td>
													<td>{$paper.title/}</td>
													<td>{$paper.awarding_installation/}</td>
													<td>{$paper.award_exact_wording/}</td>
													<td>{$paper.awarding_date/}</td>
												</tr>
												{/foreach}
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
													<td>{$membership.member_name/}</td>
													<td>{$membership.membership_date/}</td>
												{/foreach}
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
													<td>{$prize.recipient_name/}</td>
													<td>{$prize.prize_name/}</td>
													<td>{$prize.granting_installation/}</td>
													<td>{$prize.prizing_date/}</td>
												</tr>
												{/foreach}
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
													<td>{$industry_collaboration.company/}</td>
													<td>{$industry_collaboration.nature_of_collaboration/}</td>
												</tr>
												{/foreach}
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
									<div class="col-sm-6 col-md-6" align="right">
										<label style="font-weight: normal; font-size: 14pt; padding-top: 10px; padding-bottom: 10px;">Other relevant information</label>
									</div>
									<div class="col-sm-6 col-md-6">
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-12 col-md-12" align="center">
										<label class="bordered-lable" style="text-align: left;">{$relevant_info/}</label>
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-4 col-md-4">
										<button type="button" class="button-yellow btn" onclick="$('#form-tabs li:eq(5) a').tab('show');" style="font-size: 24pt; width:260px; height:70px; display:block; margin:7% auto 7% auto;">Go Back!</button>
									</div>
									<div class="col-sm-4 col-md-4">
									</div>
									<div class="col-sm-4 col-md-4">
									</div>
								</div>
							</div>
							<input type="hidden" value="{$id/}" name="id"/>
					</div>
			</div>
		</div>
		<input id="is-data-submitted" type="hidden" value="" />
		<div class="footer">
    	Developed by <label class="team-logo">DANDy</label> team
  	</div>
		<div id="deletionModal" class="modal fade">
		 <div class="modal-dialog">
			 <div class="modal-content">
				 <div class="modal-header">
					 <h4 class="modal-title"></h4>
				 </div>
				 <div class="modal-body">
					 <div class="row message" style="margin: auto auto 30px auto;"></div>
					 <div class="row active-bar" style="margin: auto;">
						 <div class="progress progress-striped active">
							<div class="progress-bar" style="width: 100%;">
								<span class="sr-only">Deletion in progress</span>
							</div>
						</div>
					 </div>
				 </div>
				 <div class="modal-footer"><a href="/admin" class="btn btn-danger disabled" role="button">Close</a></div>
			 </div>
		 </div>
		</div>
	</body>
</html>
