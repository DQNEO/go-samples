package main

const htmlTemplate = `
<!DOCTYPE html>
<html>

	<head>
	<meta charset="UTF-8">
	<title>Listening English All The Time</title>
	<script>
	document.addEventListener("DOMContentLoaded", function(){
		document.body.addEventListener("click", ()=>{
		var audios = document.getElementsByTagName("audio");
		audios[0].play();
		})
	});
	</script>
	</head>

	<body>
	<div>
	<h1><img src="{{.ImageURL}}" width=64 height=64> {{.Title}}</h1>
	
	</div>
	<ul>
	{{range .Items}}
		<li>
 		{{.Published}} - {{ .Title }} [{{.Duration}}]
		<audio id="{{.Id}}" controls src="{{.AudioURL}}">Your browser does not support the audio element.</audio>
		</li>
	{{else}}
		<div><strong>no rows</strong></div>
	{{end}}
	<ul>
	</body>
</html>
`
