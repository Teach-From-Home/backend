package controllers

import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import services.ClassroomService
import utils.Parsers

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
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
}