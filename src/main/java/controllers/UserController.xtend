package controllers

import domain.User
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.json.JSONUtils
import services.UserService
import utils.BadCredentialsException
import utils.Parsers

@Controller
class UserController {
	extension JSONUtils = new JSONUtils
	UserService userService = new UserService

	@Post("/login")
	def login(@Body String body) {
		try {
			try {
				val loginCredentials = body.fromJson(User)
				val loggedUser = userService.getUserSignIn(loginCredentials)
				return ok(loggedUser.toJson)
			} catch (UserException exception) {
				return badRequest()
			}
		} catch (BadCredentialsException e) {
			return forbidden(Parsers.errorJson(e.message))
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}

	@Get("/users")
	def getUsers() {
		try {
			try {
				val users = userService.getUsers()
				return ok(users.toJson)
			} catch (UserException exception) {
				return badRequest()
			}
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
}
