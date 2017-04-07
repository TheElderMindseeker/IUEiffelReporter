<!DOCTYPE html5>
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
					<label for="name-unit" class="control-label">Name of unit</label>
				</div>
				<div class="col-sm-6 col-md-6">
					<input type="text" class="form-control input-text" id="name-unit" name="name-unit" placeholder="Required" required/>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="name-head-unit" class="control-label">Name of head of unit</label>
				</div>
				<div class="col-sm-6 col-md-6">
					<input type="text" class="form-control input-text" id="name-head-unit" name="name-head-unit" placeholder="Required" required/>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="start-report" class="control-label">Start of reporting period if other than 1.1.2016</label>
				</div>
				<div class="col-sm-6 col-md-6">
					<input type="text" class="form-control input-text datepicker-here" id="start-report" name="start-report"/>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="end-report" class="control-label">End of reporting period (if other than 31.12.2016)</label>
				</div>
				<div class="col-sm-6 col-md-6">
					<input type="text" class="form-control input-text datepicker-here" id="end-report" name="end-report" />
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6 " style="margin-bottom: 75px; margin-top: 75px;">
					<label class="control-label" style="font-size: 24pt;">Section 2: Teaching</label>
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="courses-taught" class="control-label">Courses taught</label>
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
						<tr>
							<td><input type="text" class="form-control input-in-table" name="courses-taught[][name]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="courses-taught[][semester]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="courses-taught[][level]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="courses-taught[][numofst]" placeholder="Required" required/></td>
						</tr>
						<tr name="adder">
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('courses'), 500);" placeholder="Click to add new field" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('courses'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('courses'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('courses'), 500);" placeholder="" /></td>
						</tr>
						<tr id="to-show-courses" name="new-line-for-adder" style="display: none;">
							<td><input type="text" class="form-control input-in-table" name="courses-taught[][name]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="courses-taught[][semester]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="courses-taught[][level]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="courses-taught[][numofst]" placeholder="Required" required/></td>
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
						<tr>
							<td><input type="text" class="form-control input-in-table" name="examinations[][name]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="examinations[][semester]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="examinations[][kindexam]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="examinations[][numofst]" placeholder="Required" required/></td>
						</tr>
						<tr name="adder">
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('examinations'), 500);" placeholder="Click to add new field" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('examinations'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('examinations'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('examinations'), 500);" placeholder="" /></td>
						</tr>
						<tr id="to-show-examinations" name="new-line-for-adder" style="display: none;">
							<td><input type="text" class="form-control input-in-table" name="examinations[][name]" placeholder="Required"  required/></td>
							<td><input type="text" class="form-control input-in-table" name="examinations[][semester]" placeholder="Required"  required/></td>
							<td><input type="text" class="form-control input-in-table" name="examinations[][kindexam]" placeholder="Required"  required/></td>
							<td><input type="text" class="form-control input-in-table" name="examinations[][numofst]" placeholder="Required"  required/></td>
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
				<table class="table" id="students-supervised">
					<thead>
						<tr>
							<th style="text-align: center;">Name of Student</th>
							<th style="text-align: center;">Nature of Work</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control input-in-table" name="students-supervised[][name]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="students-supervised[][worknature]" placeholder="Required" required/></td>
						</tr>
						<tr name="adder">
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('students-supervised'), 500);" placeholder="Click to add new field" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('students-supervised'), 500);" placeholder="" /></td>
						</tr>
						<tr id="to-show-students-supervised" name="new-line-for-adder" style="display: none;">
							<td><input type="text" class="form-control input-in-table" name="students-supervised[][name]" placeholder="Required"  required/></td>
							<td><input type="text" class="form-control input-in-table" name="students-supervised[][worknature]" placeholder="Required"  required/></td>
						</tr>
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
						<tr>
							<td><input type="text" class="form-control input-in-table" name="comp-stur-rep[][name]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="comp-stur-rep[][title]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="comp-stur-rep[][publish]"/></td>
						</tr>
						<tr name="adder">
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('comp-stur-rep'), 500);" placeholder="Click to add new field" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('comp-stur-rep'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('comp-stur-rep'), 500);" placeholder="" /></td>
						</tr>
						<tr id="to-show-comp-stur-rep" name="new-line-for-adder" style="display: none;">
							<td><input type="text" class="form-control input-in-table" name="comp-stur-rep[][name]" placeholder="Required"  required/></td>
							<td><input type="text" class="form-control input-in-table" name="comp-stur-rep[][title]" placeholder="Required"  required/></td>
							<td><input type="text" class="form-control input-in-table" name="comp-stur-rep[][publish]" /></td>
						</tr>
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
						<tr>
							<td><input type="text" class="form-control input-in-table" name="comp-phd[][studentname]" placeholder="Write here"/></td>
							<td><input type="text" class="form-control input-in-table" name="comp-phd[][degree]"/></td>
							<td><input type="text" class="form-control input-in-table" name="comp-phd[][supervisorname]"/></td>
							<td><input type="text" class="form-control input-in-table" name="comp-phd[][commettee]"/></td>
							<td><input type="text" class="form-control input-in-table" name="comp-phd[][institution]"/></td>
							<td><input type="text" class="form-control input-in-table" name="comp-phd[][title]"/></td>
						</tr>
						<tr name="adder">
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('comp-phd'), 500);" placeholder="Click to add" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('comp-phd'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('comp-phd'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('comp-phd'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('comp-phd'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('comp-phd'), 500);" placeholder="" /></td>
						</tr>
						<tr id="to-show-comp-phd" name="new-line-for-adder" style="display: none;">
							<td><input type="text" class="form-control input-in-table" name="comp-phd[][studentname]"/></td>
							<td><input type="text" class="form-control input-in-table" name="comp-phd[][degree]"/></td>
							<td><input type="text" class="form-control input-in-table" name="comp-phd[][supervisorname]"/></td>
							<td><input type="text" class="form-control input-in-table" name="comp-phd[][commettee]" /></td>
							<td><input type="text" class="form-control input-in-table" name="comp-phd[][institution]"/></td>
							<td><input type="text" class="form-control input-in-table" name="comp-phd[][title]"/></td>
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
							<th style="text-align: center;">Period Covered by Grant</th>
							<th style="text-align: center;">Whether Continuation of Other Grant</th>
							<th style="text-align: center;">Amount</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control input-in-table" name="grants[][title]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="grants[][agency]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="grants[][period]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="grants[][continuation]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="grants[][amount]" placeholder="Required" required/></td>
						</tr>
						<tr name="adder">
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('grants'), 500);" placeholder="Click to add" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('grants'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('grants'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('grants'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('grants'), 500);" placeholder="" /></td>
						</tr>
						<tr id="to-show-grants" name="new-line-for-adder" style="display: none;">
							<td><input type="text" class="form-control input-in-table" name="grants[][title]" placeholder="Required" required /></td>
							<td><input type="text" class="form-control input-in-table" name="grants[][agency]" placeholder="Required" required /></td>
							<td><input type="text" class="form-control input-in-table" name="grants[][period]" placeholder="Required" required /></td>
							<td><input type="text" class="form-control input-in-table" name="grants[][continuation]" placeholder="Required" required /></td>
							<td><input type="text" class="form-control input-in-table" name="grants[][amount]" placeholder="Required" required /></td>
						</tr>
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
						<tr>
							<td><input type="text" class="form-control input-in-table" name="research-proj[][title]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="research-proj[][iuperson]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="research-proj[][extperson]"/></td>
							<td><input type="text" class="form-control input-in-table" name="research-proj[][start]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="research-proj[][end]" placeholder="Required" required/></td>
							<td><input type="text" class="form-control input-in-table" name="research-proj[][finance]" placeholder="Required" required/></td>
						</tr>
						<tr name="adder">
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('research-proj'), 500);" placeholder="Click to add" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('research-proj'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('research-proj'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('research-proj'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('research-proj'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('research-proj'), 500);" placeholder="" /></td>
						</tr>
						<tr id="to-show-research-proj" name="new-line-for-adder" style="display: none;">
							<td><input type="text" class="form-control input-in-table" name="research-proj[][title]" placeholder="Required"  required/></td>
							<td><input type="text" class="form-control input-in-table" name="research-proj[][iuperson]" placeholder="Required"  required/></td>
							<td><input type="text" class="form-control input-in-table" name="research-proj[][extperson]" /></td>
							<td><input type="text" class="form-control input-in-table" name="research-proj[][start]" placeholder="Required"  required/></td>
							<td><input type="text" class="form-control input-in-table" name="research-proj[][end]" placeholder="Required"  required/></td>
							<td><input type="text" class="form-control input-in-table" name="research-proj[][finance]" placeholder="Required"  required/></td>
						</tr>
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
						<tr>
							<td><input type="text" class="form-control input-in-table" name="research-collabs[][country]" placeholder="Write here"/></td>
							<td><input type="text" class="form-control input-in-table" name="research-collabs[][institution]"/></td>
							<td><input type="text" class="form-control input-in-table" name="research-collabs[][contacts]"/></td>
							<td><input type="text" class="form-control input-in-table" name="research-collabs[][nature]"/></td>
						</tr>
						<tr name="adder">
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('research-collabs'), 500);" placeholder="Click to add new field" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('research-collabs'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('research-collabs'), 500);" placeholder="" /></td>
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('research-collabs'), 500);" placeholder="" /></td>
						</tr>
						<tr id="to-show-research-collabs" name="new-line-for-adder" style="display: none;">
							<td><input type="text" class="form-control input-in-table" name="research-collabs[][country]" placeholder="Write here" /></td>
							<td><input type="text" class="form-control input-in-table" name="research-collabs[][institution]" /></td>
							<td><input type="text" class="form-control input-in-table" name="research-collabs[][contacts]" /></td>
							<td><input type="text" class="form-control input-in-table" name="research-collabs[][nature]" /></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="conf-pubs" class="control-label">Conference publications</label>
				</div>
				<div class="col-sm-6 col-md-6">
						<label for="conf-pubs" class="help-label">Use standard style for scientific bibliography entries.</label>
				</div>
			</div>
			<div class="form-group row">
				<table class="table" id="conf-pubs">
					<thead>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control input-in-table" name="conf-pubs[][name]" placeholder="Write here"/></td>
						</tr>
						<tr name="adder">
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('conf-pubs'), 500);" placeholder="Click to add new field" /></td>
						</tr>
						<tr id="to-show-conf-pubs" name="new-line-for-adder" style="display: none;">
							<td><input type="text" class="form-control input-in-table" name="conf-pubs[][name]" placeholder="Write here" /></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="form-group row">
				<div class="col-sm-6 col-md-6">
					<label for="journal-pubs" class="control-label">Journal publications</label>
				</div>
				<div class="col-sm-6 col-md-6">
						<label for="conf-pubs" class="help-label">Use standard style for scientific bibliography entries.</label>
				</div>
			</div>
			<div class="form-group row">
				<table class="table" id="journal-pubs">
					<thead>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control input-in-table" name="journal-pubs[][name]" placeholder="Write here"/></td>
						</tr>
						<tr name="adder">
							<td><input type="text" class="form-control input-in-table" onClick="setTimeout(addInput('journal-pubs'), 500);" placeholder="Click to add new field" /></td>
						</tr>
						<tr id="to-show-journal-pubs" name="new-line-for-adder" style="display: none;">
							<td><input type="text" class="form-control input-in-table" name="journal-pubs[][name]" placeholder="Write here" /></td>
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
