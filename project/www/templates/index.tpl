<!DOCTYPE html>
<html>
	<head>
		<title>IU Eiffel Reporter</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" charset="UTF-8">
		<script type="text/javascript" src="../resources/jquery-3.2.0.min.js"></script>
		<script type="text/javascript" src="../resources/bootstrap.min.js"></script>
		<script type="text/javascript" src="../resources/js.cookie.js"></script>
		<script type="text/javascript" src="../resources/reporterlibrary.js"></script>
		<link type="text/css" rel="stylesheet" href="../resources/bootstrap.css">
		<link type="text/css" rel="stylesheet" href="../resources/bootstrap-theme.css">
		<link type="text/css" rel="stylesheet" href="../resources/reporterlibrary.css">
		<style type="text/css">
			a:link, a:active, a:visited {
				color: #000;
			}
		</style>
  </head>
  <body onload="checkCookie();">
    <div class="wrapper main-wrapper container">
			<div class="row">
  			<div class="col-sm-12 col-md-12">
					<div class="logo-text">
						<label class="logo-text">IU Eiffel Reporter</label>
					</div>
				</div>
			</div>
			<div class="row">
 				<div class="col-sm-12 col-md-12">
					<a class="button-yellow btn" href="/form" role="button" style="font-size: 30pt; width:320px; height:80px; display:block; margin:7% auto 0 auto;">Create Report</a>
 				</div>
			</div>
			<div class="row">
				<a id="edit-button" class="btn button-yellow disabled" href="#" role="button" style="width:270px; height:67.5px; display:block; margin: 1% auto 7% auto;">Edit last report</a>
			</div>
			<div class="row">
				<div class="col-sm-12 col-md-12">
					<center><label style="font-size: 24pt; font-weight: normal;">This tool will help you to create and submit a report</label></center>
				</div>
			</div>
    </div>
  	<div class="footer">
    	Developed by <label class="team-logo">DANDy</label> team
  	</div>
  </body>
</html>
