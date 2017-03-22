<!DOCTYPE html>
<html>
	<head>
		<title>The main page</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" charset="UTF-8">
		<link rel="stylesheet" type="text/css" href="../resources/bootstrap.css">
		<link rel="stylesheet" type="text/css" href="../resources/bootstrap-theme.css" >
		<script type="text/javascript" src="../resources/bootstrap.min.js"></script>
		<style>
				html, body {
					height: 100%;
				}
				.move-in-center {
					display: flex;
					flex-direction: column;
					align-items: center;
					justify-content: center;
					height: 100%;
				}
		</style>
	</head>
	<body>
		<div class="wrapper container move-in-center">
			<p class="text-success lead">Click the button to change the page</p>
			<a class="btn btn-block btn-success" href="/form" role="button">Button</a>
			<a class="btn btn-block btn-success disabled" href="/form" role="button">Нажимай на кнопку выше, на меня не нажмешь!</a>
		</div>
</html>
