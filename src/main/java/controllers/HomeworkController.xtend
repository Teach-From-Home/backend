package controllers

import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Post
import services.HomeworkService
import domain.Homework
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.json.JSONUtils
import utils.Parsers
import com.fasterxml.jackson.databind.exc.InvalidFormatException

@Controller
class HomeworkController {
	HomeworkService homerowkService = new HomeworkService
	extension JSONUtils = new JSONUtils
	
	@Post("/classroom/:id/homework/user/:idUser")
	def createHomework(@Body String body){
		try {
			val homework = body.fromJson(Homework)
			homerowkService.createHomework(id,homework,idUser)
			return ok(Parsers.statusOkJson)
		} catch (InvalidFormatException exception) {
			return badRequest(Parsers.errorJson("Datos invalidos"))
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Post("/classroom/:id/homework/:homeworkId/user/:idUser")
	def createClassroomHomeworkDone(@Body String body) {
		try {
			val homeworkDone = body.fromJson(Homework)
			return ok(homerowkService.createHomeworkDone(id, homeworkId, idUser, homeworkDone).toJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
}