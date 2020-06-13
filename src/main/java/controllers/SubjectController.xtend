package controllers

import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import services.SubjectService
import utils.Parsers

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
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
}