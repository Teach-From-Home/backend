package controllers

import domain.Subject
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Delete
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.json.JSONUtils
import services.SubjectService
import utils.Parsers

@Controller
class SubjectController {
	SubjectService subjectService = new SubjectService
	extension JSONUtils = new JSONUtils

	@Get("/subjects")
	def getUsers() {
		try {
			return ok(subjectService.getSubjects().toJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}

	@Get("/subject/:id")
	def getById() {
		try {
			val subject = subjectService.getSubjectById(id)
			return ok(subject.toJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Post("/subject")
	def create(@Body String body) {
		try {
			val subject = body.fromJson(Subject)
			subjectService.createSubject(subject)
			return ok(Parsers.statusOkJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Delete("/subject/:id")
	def delete() {
		try {
			subjectService.deleteSubject(id)
			return ok(Parsers.statusOkJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Put("/subject/:id")
	def edit(@Body String body) {
		try {
			val subject = body.fromJson(Subject)
			subjectService.editSubject(subject,id)
			return ok(Parsers.statusOkJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
}
