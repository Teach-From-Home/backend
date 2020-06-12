package controllers

import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.commons.model.exceptions.UserException
import com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException
import services.SubjectService
import org.uqbar.xtrest.json.JSONUtils

@Controller
class SubjectController {
	SubjectService subjectService = new SubjectService
	extension JSONUtils = new JSONUtils
	
	@Get("/subjects")
	def getUsers(){
		try {
			try {
				return ok(subjectService.getSubjects().toJson)
			} catch (UserException exception) {
				return badRequest()
			}
		} catch (UnrecognizedPropertyException exception) {
			return badRequest()
		}
	}
}