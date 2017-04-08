<!DOCTYPE html>
<html>
	<head>
		<title>IU Reporter</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" charset="UTF-8">
		<link rel="stylesheet" type="text/css" href="../resources/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="../resources/bootstrap-theme.css" >
		<script type="text/javascript" src="../resources/bootstrap.min.js"></script>
		<script type="text/javascript" src="../resources/jquery-3.2.0.min.js"></script>
		<link href="../resources/reporterlibrary.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="../resources/jquery.tablesorter.js"></script>
		<script>
			$(document).ready(function()
				{
					$("#list-of-reports").tablesorter();
				}
			);
		</script>
	</head>
	<body>
		<div class="wrapper container">
			<div class="logo-text">
				<label class="logo-text">Administrative Panel</label>
			</div>
			<div class="form">
				<table class="table tablesorter" id="list-of-reports">
					<thead>
						<tr>
							<th style="text-align: center;">Name of Unit</th>
							<th style="text-align: center;">Name of Unit`s Head</th>
							<th style="text-align: center;">Starting Date</th>
							<th style="text-align: center;">End Date</th>
							<th style="text-align: center;"></th>
							<th style="text-align: center;"></th>
							<th style="text-align: center;"></th>
						</tr>
					</thead>
					<tbody>
						{foreach from="$reports" item="report"}
						<tr>
							<td>{$report.unit_name/}</td>
							<td>{$report.head_name/}</td>
							<td>{$report.rep_start/}</td>
							<td>{$report.rep_end/}</td>
							<td><a href="/details?id={$report.id/}" class="btn btn-success" role="button">More details...</a></td>
							<td><a href="/edit?id={$report.id/}" class="btn btn-primary" role="button">Edit</a></td>
							<td><a href="/delete?id={$report.id/}" class="btn btn-danger" role="button">Delete</a></td>
						</tr>
						{/foreach}
						<tr>
							<td>1{$report.unit_name/}</td>
							<td>2{$report.head_name/}</td>
							<td>3{$report.rep_start/}</td>
							<td>4{$report.rep_end/}</td>
							<td><a href="/details?id={$report.id/}" class="btn btn-success" role="button">More details...</a></td>
							<td><a href="/edit?id={$report.id/}" class="btn btn-primary" role="button">Edit</a></td>
							<td><a href="/delete?id={$report.id/}" class="btn btn-danger" role="button">Delete</a></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="footer">
    Developed by <label class="team-logo">DANDy</label> team
  </div>
	</body>
</html>
