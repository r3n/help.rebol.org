REBOL [
	Title: "Build Feeds"
	Date: 4-Sep-2012
	Author: "Christopher Ross-Gill"
	Type: 'module
	Exports: [build-feeds]
	Folder: wrt://site/feed/
	Target: http://notesfortheroad.com/feed/
]

build-feeds: use [build-articles build-places build-topics build-authors][
	build-articles: has [feed][
		feed: context [
			title: "Notes For The Road"
			subtitle: settings/strap
			foreach entry entries: select qm/models/published [last 15][
				entry/load-doc
			]
			base: settings/home
			target: header/target/articles
		]

		render/with %feed/feed.rsp [feed]
	]

	build-feeds: has [articles][
		write header/folder/articles.atom articles: build-articles
		articles
	]
]