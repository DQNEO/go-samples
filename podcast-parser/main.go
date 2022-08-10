// go run . < data/the-daily.xml > a.html
package main

import (
	"html/template"
	"os"
	"time"

	"github.com/mmcdole/gofeed"
)

type Podcast struct {
	Title    string
	ImageURL string
	Items    []*Item
}

type Item struct {
	Title     string
	AudioURL  string
	Duration  string
	Published *time.Time
}

func convPostcast(feed *gofeed.Feed) *Podcast {
	p := &Podcast{
		Title:    feed.Title,
		ImageURL: feed.Image.URL,
	}
	var items []*Item
	for _, item := range feed.Items[0:5] {
		items = append(items, &Item{
			Title:     item.Title,
			Published: item.PublishedParsed,
			AudioURL:  item.Enclosures[0].URL,
			Duration:  item.ITunesExt.Duration,
		})
	}
	p.Items = items
	return p
}

func main() {
	fp := gofeed.NewParser()
	feed, _ := fp.Parse(os.Stdin)
	//fmt.Print(feed)
	cast := convPostcast(feed)
	renderHTML(cast)
}

func renderHTML(cast *Podcast) {
	t, err := template.New("webpage").Parse(tpl)
	check(err)
	err = t.Execute(os.Stdout, cast)
	check(err)
}

const tpl = `
<!DOCTYPE html>
<html>

	<head>
	<meta charset="UTF-8">
	<title>Listening All The Time</title>
	</head>

	<body>
	<div>
	<h1><img src="{{.ImageURL}}" width=64 height=64> {{.Title}}</h1>
	
	</div>
	<ul>
	{{range .Items}}
		<li>
 		{{.Published}} - {{ .Title }} [{{.Duration}}]
		<audio controls	src="{{.AudioURL}}">Your browser does not support the audio element.</audio>
		</li>
	{{else}}
		<div><strong>no rows</strong></div>
	{{end}}
	<ul>
	</body>
</html>
`

var check = func(err error) {
	if err != nil {
		panic(err)
	}
}
