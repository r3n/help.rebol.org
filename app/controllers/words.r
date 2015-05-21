Rebol [
	Title: "Words Controller"
	Date: 16-Jul-2013
	Author: "Christopher Ross-Gill"
	Type: 'controller
	Template: %templates/words.rsp
]

route () to %words [
	get [print "WORDS"]
]

route (word: string!) to %word [
	get [
		require %core/args.r
		require %text/wordify.r
		description: get-args/prepped word: url-decode lowercase word

		unless 'ok = first description [
			render/status %notfound 404
		]
	]
]

