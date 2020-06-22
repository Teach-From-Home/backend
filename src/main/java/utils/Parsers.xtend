package utils

import java.time.LocalDate
import java.time.format.DateTimeFormatter

class Parsers{
	static def errorJson(String message) {
		'{ "message": "' + message + '" }'
	}
	static def statusOkJson() {
		'{ "status": "ok" }'
	}
	static def parsearDeStringALong(String unString) {
		Long.parseLong(unString)
	}
	
	static def parsearDeLongAString(Long unLong){
		Long.toString(unLong)
	}
	
	static def dateString(LocalDate date){
		val formatter = DateTimeFormatter.ofPattern("dd/MM/YYYY");
		return formatter.format(date)
	}
}