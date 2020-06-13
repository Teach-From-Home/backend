package controllers

import domain.User
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Delete
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.api.annotation.Put
import org.uqbar.xtrest.json.JSONUtils
import services.UserService
import utils.BadCredentialsException
import utils.Parsers
import utils.ShortUserSerializer

@Controller
class UserController {
	extension JSONUtils = new JSONUtils
	UserService userService = new UserService

	@Post("/login")
	def login(@Body String body) {
		try {
			val loginCredentials = body.fromJson(User)
			val loggedUser = userService.getUserSignIn(loginCredentials)
			return ok(ShortUserSerializer.toJson(loggedUser))
		} catch (BadCredentialsException e) {
			return forbidden(Parsers.errorJson(e.message))
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}

	@Get("/users")
	def getUsers() {
		try {
			val users = userService.getUsers()
			return ok(users.toJson)
		} catch (UserException exception) {
			return badRequest()
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}

	@Get("/user/:id")
	def getUserById() {
		try {
			val users = userService.getUserById(id)
			return ok(users.toJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Post("/user")
	def createUser(@Body String body) {
		try {
			val user = body.fromJson(User)
			userService.createUser(user)
			return ok(Parsers.statusOkJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Delete("/user/:id")
	def deleteUser() {
		try {
			userService.deleteUser(id)
			return ok(Parsers.statusOkJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
	
	@Put("/user/:id")
	def editUser(@Body String body) {
		try {
			val user = body.fromJson(User)
			userService.editUser(user,id)
			return ok(Parsers.statusOkJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
}
