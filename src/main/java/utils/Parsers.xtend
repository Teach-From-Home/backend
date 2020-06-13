package utils

class Parsers{
	static def errorJson(String message) {
		'{ "error": "' + message + '" }'
	}
	static def statusOkJson() {
		'{ "status": "ok" }'
	}
}
