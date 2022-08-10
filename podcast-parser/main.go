// go run . > out/index.html
package main

import (
	"github.com/mmcdole/gofeed"
	"gopkg.in/yaml.v3"
	"html/template"
	"io"
	"os"
	"sort"
	"time"
)

type Podcast struct {
	Title    string
	ImageURL string
	Items    []*Item
}

type Item struct {
	Id        string
	Title     string
	AudioURL  string
	Duration  string
	Published time.Time
}

type LineItem struct {
	Id              string
	Title           string
	AudioURL        string
	Duration        string
	Published       time.Time
	ChannelImageURL string
	ChannelTitle    string
}

func convPostcast(feed *gofeed.Feed) *Podcast {
	p := &Podcast{
		Title:    feed.Title,
		ImageURL: feed.Image.URL,
	}
	var items []*Item
	for _, item := range feed.Items[0:3] {
		items = append(items, &Item{
			Id:        item.GUID,
			Title:     item.Title,
			Published: *item.PublishedParsed,
			AudioURL:  item.Enclosures[0].URL,
			Duration:  item.ITunesExt.Duration,
		})
	}
	p.Items = items
	return p
}

type FeedURL struct {
	Name string
	URL  string
}

func getPodcasts() []*Podcast {
	y, err := os.Open("./data/feeds.yaml")
	if err != nil {
		panic(err)
	}
	binYaml, err := io.ReadAll(y)
	if err != nil {
		panic(err)
	}
	var feeds []FeedURL
	err = yaml.Unmarshal(binYaml, &feeds)
	if err != nil {
		panic(err)
	}

	var casts []*Podcast
	for _, fd := range feeds {
		fp := gofeed.NewParser()
		feed, err := fp.ParseURL(fd.URL)
		if err != nil {
			panic(err)
		}
		cast := convPostcast(feed)
		casts = append(casts, cast)
	}
	return casts
}

func main() {
	casts := getPodcasts()
	var items []*LineItem
	for _, c := range casts {
		for _, i := range c.Items {
			li := &LineItem{
				Id:              i.Id,
				Title:           i.Title,
				AudioURL:        i.AudioURL,
				Duration:        i.Duration,
				Published:       i.Published,
				ChannelImageURL: c.ImageURL,
				ChannelTitle:    c.Title,
			}
			items = append(items, li)

		}
	}
	// Sort for timeline view (newer is upper)
	sort.Slice(items, func(i, j int) bool {
		return items[i].Published.After(items[j].Published)
	})
	renderItems(items)
}

func renderItems(items []*LineItem) {
	t, err := template.ParseFiles("tpl/index.html")
	check(err)
	type data struct {
		Items []*LineItem
	}
	d := data{
		Items: items,
	}
	err = t.Execute(os.Stdout, d)
	check(err)
}

func renderPodcast(cast *Podcast) {
	t, err := template.New("webpage").Parse(htmlTemplate)
	check(err)
	err = t.Execute(os.Stdout, cast)
	check(err)
}

var check = func(err error) {
	if err != nil {
		panic(err)
	}
}
