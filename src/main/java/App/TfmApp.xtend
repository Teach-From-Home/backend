package App

import org.uqbar.xtrest.api.XTRest
import controllers.UserController

class TfmApp {
	def static void main(String[] args) {
		
		
		
		GenObjects.generateAll()
		
		
		XTRest.startInstance(16000,
			new UserController
		)
	}
}