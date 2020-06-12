package controllers

import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.json.JSONUtils
import org.uqbar.commons.model.exceptions.UserException
import com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException
import org.uqbar.xtrest.api.annotation.Get
import services.ClassroomService

@Controller
class ClassroomController {
	ClassroomService classroomService = new ClassroomService
	extension JSONUtils = new JSONUtils
	
	@Get("/classrooms")
	def getUsers(){
		try {
			try {
				return ok(classroomService.getClassrooms().toJson)
			} catch (UserException exception) {
				return badRequest()
			}
		} catch (UnrecognizedPropertyException exception) {
			return badRequest()
		}
	}
	
	@Get("/classroomUsers/:id")
	def getUsersOfClassroom(){
		try {
			try {
				return ok(classroomService.getUsersOfClassroom(id).toJson)
			} catch (UserException exception) {
				return badRequest()
			}
		} catch (UnrecognizedPropertyException exception) {
			return badRequest()
		}
	}
	
	@Get("/classroomTeacherGetHomework/:id")
	def getTeacherGetHomeworkOfClassroom(){
		try {
			try {
				return ok(classroomService.getTeacherGetHomeworkOfClassroom(id).toJson)
			} catch (UserException exception) {
				return badRequest()
			}
		} catch (UnrecognizedPropertyException exception) {
			return badRequest()
		}
	}
	
	@Get("/classroomStudentGetHomework/:id")
	def getStudentGetHomeworkOfClassroom(){
		try {
			try {
				return ok(classroomService.getStudentGetHomeworkOfClassroom(id).toJson)
			} catch (UserException exception) {
				return badRequest()
			}
		} catch (UnrecognizedPropertyException exception) {
			return badRequest()
		}
	}
}