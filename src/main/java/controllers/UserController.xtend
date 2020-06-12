package controllers

import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Body
import services.UserService
import com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.api.annotation.Get

@Controller
class UserController {
	
	UserService userService = new UserService
	
	@Post("/login")
	def login(@Body String body){
	try {
			try {
				return ok(userService.getUserSignIn(body))
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
				return ok(userService.getUsers())
			} catch (UserException exception) {
				return badRequest()
			}
		} catch (UnrecognizedPropertyException exception) {
			return badRequest()
		}
	}
}

