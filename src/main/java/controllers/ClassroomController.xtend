package controllers

import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import services.ClassroomService
import utils.Parsers
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Body
import domain.Classroom
import org.uqbar.xtrest.api.annotation.Delete
import org.uqbar.xtrest.api.annotation.Put
import com.fasterxml.jackson.databind.exc.InvalidFormatException

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
	
	@Get("/classroom/:id")
	def getClassroomById(){
		try {
			val users = classroomService.getClassroomById(id)
			return ok(users.toJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Post("/classroom")
	def createClassroom(@Body String body){
		try {
			val classroom = body.fromJson(Classroom)
			classroomService.createClassroom(classroom)
			return ok(Parsers.statusOkJson)
		} catch (InvalidFormatException exception) {
			return badRequest(Parsers.errorJson("Datos invalidos"))
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Delete("/classroom/:id")
	def deleteClassroom(){
		try {
			classroomService.deleteClassroom(id)
			return ok(Parsers.statusOkJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Put("/classroom/:id")
	def editClassroom(@Body String body) {
		try {
			val classroom = body.fromJson(Classroom)
			classroomService.editClassroom(classroom,id)
			return ok(Parsers.statusOkJson)
		} catch (InvalidFormatException exception) {
			return badRequest(Parsers.errorJson("Datos invalidos"))
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}

// TODO
	@Get("/classroom/:id/homework/:userId")
	def getClassroomHomework() {
		try {
			return ok(classroomService.getClassroomHomework(id, userId).toJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}

// TODO
	@Get("/classroom/:id/posts/:userId")
	def getClassroomPosts() {
		try {
			return ok(classroomService.getClassroomPosts(id).toJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	
}
