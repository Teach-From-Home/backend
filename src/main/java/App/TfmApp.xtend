package App

import org.uqbar.xtrest.api.XTRest

class TfmApp {
	def static void main(String[] args) {
		
		
		
		GenObjects.generateAll()
		
		
		XTRest.startInstance(16000)
	}
}