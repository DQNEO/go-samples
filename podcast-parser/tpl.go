package main

const htmlTemplateItems = `
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
	<h1>Listening English All The Time</h1>
	</div>

	<div id="items">
	{{range .Items}}
		<div>
		<img src="{{.ChannelImageURL}}" width=64 height=64> 
 		{{.Published}} 
		<audio id="{{.Id}}" controls src="{{.AudioURL}}">Your browser does not support the audio element.</audio>
		- {{ .Title }} - {{ .ChannelTitle }}
		[{{.Duration}}]
		</div>
	{{else}}
		<div><strong>no rows</strong></div>
	{{end}}
	</div>
	</body>
</html>
`
