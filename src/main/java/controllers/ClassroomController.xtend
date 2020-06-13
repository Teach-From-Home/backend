package controllers

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
	def getClassrooms() {
		try {
			return ok(classroomService.getClassrooms().toJson)

		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}

	@Get("/classroom/:id/users")
	def getClassroomUsers() {
		try {
			return ok(classroomService.getClassroomUsers(id).toJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}

// TODO
	@Get("/classroom/:id/homework/:userId")
	def getClassroomHomework() {
		try {
			return ok(classroomService.getClassroomHomework(id).toJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}

// TODO
	@Get("/classroom/:id/posts/teacher")
	def getClassroomPosts() {
		try {
			return ok(classroomService.getClassroomPosts(id).toJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
}
