package controllers

import com.fasterxml.jackson.databind.exc.InvalidFormatException
import domain.Exam
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.json.JSONUtils
import services.ExamsService
import utils.Parsers

@Controller
class ExamController {
	extension JSONUtils = new JSONUtils
	ExamsService examsService = new ExamsService

	@Post("/classroom/:id/exam")
	def createPost(@Body String body) {
		try {
			val exam = body.fromJson(Exam)
			examsService.create(exam,id)
			return ok(Parsers.statusOkJson)
		} catch (InvalidFormatException exception) {
			return badRequest(Parsers.errorJson("Datos invalidos"))
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}

}