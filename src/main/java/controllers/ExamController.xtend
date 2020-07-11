package controllers

import com.fasterxml.jackson.databind.exc.InvalidFormatException
import domain.Exam
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Put
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
	
	@Put("/exam")
	def editExam(@Body String body) {
		try {
			val exam = body.fromJson(Exam)
			examsService.updateExam(exam)
			return ok(Parsers.statusOkJson)
		} catch (InvalidFormatException exception) {
			return badRequest(Parsers.errorJson("Datos invalidos"))
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Get("/classroom/:id/user/:uid/exams")
	def getExams() {
		try {
			val exams = examsService.clasroomsExams(id)
			return ok(exams.toJson)
		} catch (InvalidFormatException exception) {
			return badRequest(Parsers.errorJson("Datos invalidos"))
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}

}