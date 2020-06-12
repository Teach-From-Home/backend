package controllers

import org.uqbar.xtrest.api.annotation.Controller
import Repository.ClassroomRepository
import org.uqbar.xtrest.json.JSONUtils
import org.uqbar.commons.model.exceptions.UserException
import com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException
import org.uqbar.xtrest.api.annotation.Get

@Controller
class ClassroomController {
	ClassroomRepository classroomRepo = new ClassroomRepository
	extension JSONUtils = new JSONUtils
	
	@Get("/classrooms")
	def getUsers(){
		try {
			try {
				return ok(classroomRepo.getClassrooms().toJson)
			} catch (UserException exception) {
				return badRequest()
			}
		} catch (UnrecognizedPropertyException exception) {
			return badRequest()
		}
	}
}