REBOL [
	Title: "Words Controller"
	Date: 16-Jul-2013
	Author: "Christopher Ross-Gill"
	Type: 'controller
]

route () to %words [
	get [print "WORDS"]
]

route (word: string!) to %words [
	get [
		print url-decode word
		probe rejoin ["I am " system/options/cgi/server-software]
	]
]