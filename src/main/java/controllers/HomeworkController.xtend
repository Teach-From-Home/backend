package controllers

import com.fasterxml.jackson.databind.exc.InvalidFormatException
import domain.Homework
import domain.HomeworkDone
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.json.JSONUtils
import services.HomeworkService
import utils.Parsers
import org.uqbar.xtrest.api.annotation.Put

@Controller
class HomeworkController {
	HomeworkService homerowkService = new HomeworkService
	extension JSONUtils = new JSONUtils

	@Post("/classroom/:id/homework/user/:idUser")
	def createHomework(@Body String body) {
		try {
			val homework = body.fromJson(Homework)
			homerowkService.createHomework(id, homework, idUser)
			return ok(Parsers.statusOkJson)
		} catch (InvalidFormatException exception) {
			return badRequest(Parsers.errorJson("Datos invalidos"))
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}

	@Get("/homework/:homeworkId/uploaded")
	def getClassroomHomeworkDone() {
		try {
			return ok(homerowkService.getUploadedHomeworks(homeworkId).toJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}

	@Put("/homework/:homeworkId/user/:idUser")
	def uploadHomework(@Body String body) {
		try {
			val homework = body.fromJson(Homework)
			homerowkService.updateHomework(homeworkId, homework)
			return ok(Parsers.statusOkJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}

	@Post("/homework/:homeworkId/user/:idUser")
	def createHomeworkDone(@Body String body) {
		try {
			val homeworkDone = body.fromJson(HomeworkDone)
			homerowkService.createHomeworkDone(homeworkId, idUser, homeworkDone)
			return ok(Parsers.statusOkJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
}
