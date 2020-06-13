package app

import org.uqbar.xtrest.api.XTRest
import controllers.UserController
import controllers.SubjectController
import controllers.ClassroomController

class TfmApp {
	def static void main(String[] args) {
		
		
		
		GenObjects.generateAll()
		
		
		XTRest.startInstance(16000,
			new UserController,
			new SubjectController,
			new ClassroomController
		)
	}
}