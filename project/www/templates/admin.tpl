<!DOCTYPE html>
<html>
	<head>
		<title>Administrative Panel - IU Eiffel Reporter</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" charset="UTF-8">
		<script type="text/javascript" src="../resources/jquery-3.2.0.min.js"></script>
		<script type="text/javascript" src="../resources/bootstrap.min.js"></script>
		<script type="text/javascript" src="../resources/datepicker.min.js"></script>
		<script type="text/javascript" src="../resources/i18n/datepicker.en.js"></script>
		<script type="text/javascript" src="../resources/jquery.serializejson.js"></script>
		<script type="text/javascript" src="../resources/jquery.tablesorter.js"></script>
		<script type="text/javascript" src="../resources/reporterlibrary.js"></script>
		<link type="text/css" rel="stylesheet" href="../resources/bootstrap.css">
		<link type="text/css" rel="stylesheet" href="../resources/bootstrap-theme.css" >
		<link type="text/css" rel="stylesheet" href="../resources/datepicker.min.css">
		<link type="text/css" rel="stylesheet" href="../resources/reporterlibrary.css">
	</head>
	<body onload="adminPageInitialization();">
		<div class="wrapper container">
			<div class="logo-text">
				<label class="logo-text">Administrative Panel</label>
			</div>
			<div class="form">
				<ul id="admin-tabs" class="nav nav-tabs" role="tablist">
    			<li class="active"><a href="#list" aria-controls="list" role="tab" data-toggle="tab">List of Reports</a></li>
    			<li><a href="#query" aria-controls="query" role="tab" data-toggle="tab">Make query</a></li>
    			<li><a href="#query-result" aria-controls="query-result" role="tab" data-toggle="tab">Result of query</a></li>
  			</ul>
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane fade in active" id="list">
						<table class="table tablesorter" id="list-of-reports">
							<thead>
								<tr>
									<th style="text-align: center; border-bottom: 0px;">Name of Unit</th>
									<th style="text-align: center; border-bottom: 0px;">Name of Unit`s Head</th>
									<th style="text-align: center; border-bottom: 0px;">Starting Date</th>
									<th style="text-align: center; border-bottom: 0px;">End Date</th>
								</tr>
							</thead>
							<tbody>
								{foreach from="$reports" item="report"}
									<tr>
										<td>{$report.unit_name/}</td>
										<td>{$report.head_name/}</td>
										<td>{$report.rep_start/}</td>
										<td>{$report.rep_end/}</td>
										<td><a href="/details/{$report.id/}" class="btn btn-success" role="button">More details...</a></td>
										<td>
											<div class="dropdown">
											 	<button class="btn btn-success dropdown-toggle" type="button" data-toggle="dropdown">Export</button>
												<ul class="dropdown-menu">
											 		<li><a href="/export_json/{$report.id/}">to JSON</a></li>
											 		<li><a href="/export_xml/{$report.id/}">to XML</a></li>
												</ul>
											</div>
										</td>
										<td><a href="/edit/{$report.id/}" class="btn btn-primary" role="button">Edit</a></td>
										<td><button onclick="requestDeletion('{$report.id/}', '{$report.unit_name/}');" type="button" class="btn btn-danger">Delete</button></td>
									</tr>
								{/foreach}
							</tbody>
						</table>
					</div>
					<div role="tabpanel" class="tab-pane fade" id="query">
						<div class="form" style="margin-top: 25px;">
							<form class="form-horizontal" name="request" id="request" method="POST" action="/admin" >
								<div class="form-group row">
									<div class="col-sm-6 col-md-6">
										<label for="type_of_query" class="control-label">Select query</label>
									</div>
									<div class="col-sm-6 col-md-6">
										<select name="type_of_query" style="font-size: 14pt; width: 75%;" required>
											<option></option>
  										<option value="query_publications">All publications of the university in a given year</option>
	  									<option value="courses_taught">Courses taught by a Laboratory between initial and final date</option>
	  									<option value="number_of_supervised_students">Number of supervised students by Laboratories</option>
											<option value="number_of_research_collaborations">Number of research collaborations, if any, by Laboratories</option>
											<option value="number_of_projects_awarded_grants">Number of projects awarded grants</option>
	  									<option value="cumulative_info">Cumulative info of a given unit over several years</option>
											<option value="patents_filed_or_submitted">Patents filed of submitted</option>
										</select>
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 col-md-6">
										<label for="unit_name" class="control-label">Name of unit</label>
									</div>
									<div class="col-sm-6 col-md-6">
										<select name="lab_name" style="font-size: 14pt; width: 75%;" required="">
											<option></option>
											{foreach from="$labs" item="item"}
  											<option value="{$item/}">{$item/}</option>
											{/foreach}
										</select>
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 col-md-6">
										<label for="rep_start" class="control-label">Start of reporting period</label>
									</div>
									<div class="col-sm-6 col-md-6">
										<input type="text" class="form-control input-text datepicker-here" placeholder="Required" name="start_date" required/>
									</div>
								</div>
								<div class="form-group row">
									<div class="col-sm-6 col-md-6">
										<label for="rep_end" class="control-label">End of reporting period</label>
									</div>
									<div class="col-sm-6 col-md-6">
										<input type="text" class="form-control input-text datepicker-here" placeholder="Required" name="end_date" required/>
									</div>
								</div>
								<div class="form-group row">
									<button type="button" class="btn button-yellow" id="submit" name="submit" style="font-size: 12pt; display:block; margin:10px auto; width:120px; height:40px;">Go!</button>
								</div>
							</form>
						</div>
					</div>
					<div role="tabpanel" class="tab-pane fade" id="query-result">
						<div style="margin-top: 50px;">
							<div class="row">
								<div class="col-sm-12 col-md-12">
									<center><label style="font-size: 24pt; font-weight: normal;">Here will be result of your query</label></center>
								</div>
							</div>
							<div class="row">
				 				<div class="col-sm-12 col-md-12">
									<button type="button" class="button-yellow btn" onclick="$('#admin-tabs li:eq(1) a').tab('show');" style="font-size: 30pt; width:320px; height:80px; display:block; margin:7% auto 7% auto;">Make Query!</button>
				 				</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
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
				 <div class="modal-footer"><a href="javascript:window.location.reload()" class="btn btn-danger disabled" role="button">Close</a></div>
			 </div>
		 </div>
		</div>
	</body>
</html>
