<!DOCTYPE html>
<html>
	<head>
		<title>IU Reporter</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" charset="UTF-8">
		<script type="text/javascript" src="../resources/jquery-3.2.0.min.js"></script>
		<link rel="stylesheet" type="text/css" href="../resources/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="../resources/bootstrap-theme.css" >
		<script type="text/javascript" src="../resources/bootstrap.min.js"></script>
		<link href="../resources/reporterlibrary.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="../resources/jquery.tablesorter.js"></script>
		<style type="text/css">
			a {
				outline: none; /* Убираем границу вокруг ссылок  */
 			}
 		</style>
	</head>
	<body onload='$("#list-of-reports").tablesorter();'>
		<div class="wrapper container">
			<div class="logo-text">
				<label class="logo-text">Administrative Panel</label>
			</div>
			<div class="form">
				<ul class="nav nav-tabs" role="tablist">
    			<li class="active"><a href="#list" aria-controls="list" role="tab" data-toggle="tab">List of Reports</a></li>
    			<li><a href="#query" aria-controls="query" role="tab" data-toggle="tab">Make query</a></li>
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
										<td><a href="/edit?id={$report.id/}" class="btn btn-primary" role="button">Edit</a></td>
										<td><a href="/delete?id={$report.id/}" class="btn btn-danger" role="button">Delete</a></td>
									</tr>
								{/foreach}
							</tbody>
						</table>
					</div>
					<div role="tabpanel" class="tab-pane fade" id="query">
						<div class="form" style="margin-top: 25px;">
							<form class="form-horizontal" name="request" id="request" method="POST" action="/admin">
								<div class="form-group row">
									<div class="col-sm-4 col-md-4">
										<label for="unit_name" class="control-label">Name of unit</label>
									</div>
									<div class="col-sm-8 col-md-8">
										<input type="text" class="form-control input-text" id="unit_name" name="unit_name" placeholder="Required" value="{$unit_name/}" required/>
									</div>
								</div>
								<div class="form-group row">
									<button type="submit" class="btn button-yellow" style="font-size: 12pt; display:block; margin:10px auto; width:120px; height:40px;">Go!</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="footer">
    	Developed by <label class="team-logo">DANDy</label> team
  	</div>
	</body>
</html>
