REBOL [
	Title: "Home Controller"
	Date: 16-Jul-2013
	Author: "Christopher Ross-Gill"
	Type: 'controller
	Template: %templates/words.rsp
]

route () to %home [
	get [
		require %makedoc/makedoc.r
		document: load-doc wrt://system/views/home/index.rmd
	]
]