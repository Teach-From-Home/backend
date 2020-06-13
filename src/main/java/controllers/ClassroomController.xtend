package controllers

import com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import services.ClassroomService

@Controller
class ClassroomController {
	ClassroomService classroomService = new ClassroomService
	extension JSONUtils = new JSONUtils
	
	@Get("/classrooms")
	def getUsers(){
		try {
			try {
				return ok(classroomService.getClassrooms().toJson)
			} catch (UserException exception) {
				return badRequest()
			}
		} catch (UnrecognizedPropertyException exception) {
			return badRequest()
		}
	}
}