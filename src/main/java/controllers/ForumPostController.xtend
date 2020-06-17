package controllers

import com.fasterxml.jackson.databind.exc.InvalidFormatException
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.json.JSONUtils
import utils.Parsers
import org.uqbar.xtrest.api.annotation.Post
import domain.ForumPost
import services.ForumPostService

@Controller
class ForumPostController {
	ForumPostService postService = new ForumPostService
	extension JSONUtils = new JSONUtils

	@Post("/classroom/:idClassroom/post/user/:idUser")
	def createPost(@Body String body) {
		try {
			val post = body.fromJson(ForumPost)
			postService.createPost(idClassroom, post)
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
			val post = body.fromJson(ForumPost)
			postService.uploadComment(idPost, idUser, post)
			return ok(Parsers.statusOkJson)
		} catch (Exception e) {
			return internalServerError(Parsers.errorJson(e.message))
		}
	}
}
