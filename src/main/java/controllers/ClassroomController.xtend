package controllers

import org.uqbar.commons.model.exceptions.UserException
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
	def getClassrooms(){
		try {
			try {
				return ok(classroomService.getClassrooms().toJson)
			} catch (UserException exception) {
				return badRequest()
			}
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Get("/classroom/:id/users")
	def getClassroomUsers(){
		try {
			try {
				return ok(classroomService.getClassroomUsers(id).toJson)
			} catch (UserException exception) {
				return badRequest()
			}
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	//TODO
	@Get("/classroom/:id/homework/:userId")
	def getClassroomHomework(){
		try {
			try {
				return ok(classroomService.getClassroomHomework(id).toJson)
			} catch (UserException exception) {
				return badRequest()
			}
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	//TODO
	@Get("/classroom/:id/posts/teacher")
	def getClassroomPosts(){
		try {
			try {
				return ok(classroomService.getClassroomPosts(id).toJson)
			} catch (UserException exception) {
				return badRequest()
			}
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
}