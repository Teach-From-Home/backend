package controllers

import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Body
import services.UserService
import com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import services.UserSignIn

@Controller
class UserController {
	extension JSONUtils = new JSONUtils
	UserService userService = new UserService
	
	@Post("/login")
	def login(@Body String body){
	try {
			try {
				val userSignInBody = body.fromJson(UserSignIn)
				return ok(userService.getUserSignIn(userSignInBody).toJson)
			} catch (UserException exception) {
				return badRequest()
			}
		} catch (UnrecognizedPropertyException exception) {
			return badRequest()
		}
	}
	
	@Get("/users")
	def getUsers(){
		try {
			try {
				return ok(userService.getUsers().toJson)
			} catch (UserException exception) {
				return badRequest()
			}
		} catch (UnrecognizedPropertyException exception) {
			return badRequest()
		}
	}
	
	@Get("/teacherSubjects/:id")
	def getTeacherSubjects(){
		try {
			try {
				return ok(userService.getTeacherSubjects(id).toJson)
			} catch (UserException exception) {
				return badRequest()
			}
		} catch (UnrecognizedPropertyException exception) {
			return badRequest()
		}
	}
}