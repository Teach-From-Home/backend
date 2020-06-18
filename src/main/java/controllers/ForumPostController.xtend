package controllers

import com.fasterxml.jackson.databind.exc.InvalidFormatException
import domain.ForumPost
import domain.Responses
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.json.JSONUtils
import services.ForumPostService
import utils.Parsers

@Controller
class ForumPostController {
	ForumPostService postService = new ForumPostService
	extension JSONUtils = new JSONUtils

	@Post("/classroom/:idClassroom/post/user/:idUser")
	def createPost(@Body String body) {
		try {
			val post = body.fromJson(ForumPost)
			postService.createPost(idClassroom, post,idUser)
			return ok(Parsers.statusOkJson)
		} catch (InvalidFormatException exception) {
			return badRequest(Parsers.errorJson("Datos invalidos"))
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}

	@Get("/post/:idPost/comments")
	def getClassroomPostComments() {
		try {
			return ok(postService.getCommentsOfPost(idPost).toJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}

	@Post("/post/:idPost/user/:idUser")
	def uploadComment(@Body String body) {
		try {
			val post = body.fromJson(Responses)
			postService.uploadComment(idPost, idUser, post)
			return ok(Parsers.statusOkJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
}
