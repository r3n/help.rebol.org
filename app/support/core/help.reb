#!/usr/local/bin/r3 -q

Rebol [
	Title: "Help On Word"
	Date: 18-May-2015
	Author: "Christopher Ross-Gill"
]

neaten: func [block [block!] /pairs /flat][
    new-line/all/skip block not flat either pairs [2] [1]
]

supported-words: neaten/pairs collect [
	foreach word words-of system/contexts/lib [
		if any-function? get word [keep to string! word keep get word]
	]
]

clean-spec: func [
	spec [block!]
	/local argument description types
][
	collect [
		parse spec [
			[set description string! (keep description) | (keep "No Description")]
			any [
				/local opt string! any [word! opt block! opt string!]
				|
				set argument refinement! [
					  set description string! | (description: "No Description")
				] (
					keep reduce [
						argument none description
					]
				)
				|
				set argument [word! | lit-word! | get-word!][
					  and set types block! into [some word!] | (types: none)
				][
					  set description string! | (description: "No Description")
				] (
					keep reduce [
						argument types description
					]
				)
			]
		]
	]
]

print either all [
	target: select supported-words name: input
][
	mold/all neaten reduce [
		'ok name type? :target clean-spec spec-of :target
	]
][
	"[fail]"
]