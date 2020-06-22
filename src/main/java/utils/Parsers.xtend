package utils

import java.time.LocalDate
import java.time.format.DateTimeFormatter
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.exceptions.UserException

class Parsers{
	static val DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy")

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
	
	static def ParseStringToDate(String date){
		try{
			if(!date.nullOrEmpty){
				LocalDate.parse(date,formatter)
			}
		} catch(UserException exception){
			throw new UserException("anda mal")
		}
	}
	
	static def dateString(LocalDate date){
		val formatter = DateTimeFormatter.ofPattern("dd/MM/YYYY");
		return formatter.format(date)
	}

}

@Accessors
class HomeworkParser{
	String title
	String description
	boolean available
	String deadLine
	
}