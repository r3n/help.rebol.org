REBOL [
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
		description: ""
		unless call/wait/output reform [
			system/options/boot
			"-cq --do"
			mold join "help " word: url-decode lowercase word
		] description [
			reject 500 "Eek!"
		]
		description: trim/head/tail detab description
	]
]

