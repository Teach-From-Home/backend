package controllers

import com.fasterxml.jackson.databind.exc.InvalidFormatException
import domain.Homework
import domain.HomeworkDone
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.json.JSONUtils
import services.HomeworkService
import utils.Parsers

@Controller
class HomeworkController {
	HomeworkService homerowkService = new HomeworkService
	extension JSONUtils = new JSONUtils
	
	@Post("/classroom/:id/homework/user/:idUser")
	def createHomework(@Body String body){
		try {
			val homework = body.fromJson(Homework)
			homerowkService.createHomework(id,homework)
			return ok(Parsers.statusOkJson)
		} catch (InvalidFormatException exception) {
			return badRequest(Parsers.errorJson("Datos invalidos"))
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Post("/homework/:homeworkId/user/:idUser")
	def uploadHomework(@Body String body) {
		try {
			val homeworkDone = body.fromJson(HomeworkDone)
			homerowkService.uploadHomework(homeworkId, idUser, homeworkDone)
			return ok(Parsers.statusOkJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
}