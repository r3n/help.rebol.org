Rebol [
	Title: "Get Function Args"
	Date: 17-Jul-2013
	Author: "Christopher Ross-Gill"
	Type: 'module
	Exports: [get-args]
]

command: system/script/path/%help.reb

usage-from-spec: func [name [word! string!] type [datatype!] spec [block!]][
	spec: collect [
		keep name
		foreach [argument types description] spec [keep mold argument]
	]

	if type = op! [
		insert next spec take spec
	]

	spec
]

get-args: func [
	[catch] value [word! string!] /prepped
	/local response error refinements arguments
][
	value: form value

	response: copy ""
	error: copy ""

	either all [
		zero? call/wait/input/output/error command value response error
		block? response: try [load response]
	][
		if all [
			response/1 = 'ok
			prepped
		][
			append/only response usage-from-spec response/2 response/3 next response/4

			either refinements: find response/4 refinement! [
				repend response [
					copy/part next response/4 refinements

					collect [
						foreach [argument types description] refinements [
							either refinement? argument [
								keep reduce [
									argument description arguments: copy []
								]
							][
								repend arguments [
									argument types description
								]
							]
						]
					]
				]
			][
				repend response [
					next response/4

					none
				]
			]
		]

		neaten response
	][
		throw make error! "Could Not Call Support Script: help.reb"
	]
]