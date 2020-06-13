package utils

class ParserStringToLong {

	static ParserStringToLong instance = null

	private new() {
	}

	static def getInstance() {
		if (instance === null) {
			instance = new ParserStringToLong
		}
		instance
	}

	def parsearDeStringALong(String unString) {
		Long.parseLong(unString)
	}
	
	def parsearDeLongAString(Long unLong){
		Long.toString(unLong)
	}
}