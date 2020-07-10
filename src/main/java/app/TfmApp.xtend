package app

import controllers.ClassroomController
import controllers.ForumPostController
import controllers.HomeworkController
import controllers.SubjectController
import controllers.UserController
import io.github.cdimascio.dotenv.Dotenv
import org.uqbar.xtrest.api.XTRest
import controllers.ExamController

class TfmApp {
	def static void main(String[] args) {
	
		GenObjects.generateAll()
		var int port
		var Dotenv dotenv

		dotenv = Dotenv.configure().ignoreIfMissing().load()

		try {
			port = Integer.parseInt(dotenv.get("PORT"))
		} catch (NumberFormatException e) {
			println("Probablemente te falta el archivo .env!!")
			throw e
		}

		XTRest.startInstance(
			port,
			new UserController,
			new SubjectController,
			new ClassroomController,
			new HomeworkController,
			new ForumPostController,
			new ExamController
		)
	}
}