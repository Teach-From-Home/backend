package utils

import domain.Classroom
import domain.Exam
import domain.Homework
import domain.User

class MailTemplates {

	static def newUser(User user) {
		return String.join(
			System.getProperty("line.separator"),
			"<h1>Bienvenido a TFM!</h1>",
			"<p>Hola " + user.name +
				", queremos darte la bienvenida a TFM una nueva plataforma para educación virtual.</p>",
			"<p>Tu usuario de " + getStringRole(user.role) + " fue dado de alta por un administrador.</p>",
			"<p>A continuacion te dejamos las credenciales para el primer ingreso<p>",
			"<p>Usuario: <strong>" + user.dni + "</strong></p>",
			"<p>Contraseña: <strong>" + user.password + "</strong></p>",
			"<p>Podes ingresar a la aplicación haciendo click <a href='https://teach-from-home.web.app/'>ACA</a></p>"
		)
	}

	static def addedToClassroom(User user, Classroom classRoom) {
		return String.join(
			System.getProperty("line.separator"),
			"<h1>Aviso TFM</h1>",
			"<p>Hola " + user.name + "</p>",
			"<p>Has sido agregado al siguiente classroom de: <strong> " + classRoom.subject.name + "</strong></p>",
			"<p>En el horario: <strong> " + classRoom.name + "</strong> <p>",
			"<p>Podes ingresar a la aplicación haciendo click <a href='https://teach-from-home.web.app/'>ACA</a></p>"
		)
	}

	static def liveStart(User user, Classroom classRoom) {
		return String.join(
			System.getProperty("line.separator"),
			"<h1>Empezo la clase!</h1>",
			"<p>Hola " + user.name + "</p>",
			"<p>Ha comenzado la clase de <strong> " + classRoom.subject.name + " " + classRoom.name +
				"</strong><br><p>",
			"<p>Podes ingresar a la aplicación haciendo click <a href='https://teach-from-home.web.app/'>ACA</a></p>"
		)
	}

	static def newHomework(User user, Classroom classRoom, Homework homework) {
		return String.join(
			System.getProperty("line.separator"),
			"<h1>Nueva Tarea!</h1>",
			"<p>Hola " + user.name + ",</p>",
			"<p>Se ha agregado una tarea de: <strong> " + classRoom.subject.name + "</strong><br><p>",
			"<p>La tarea es: <strong>" + homework.title + "</strong></p>",
			"<p>Recorda entregarla antes del <strong>" + Parsers.dateString(homework.deadLine) + "</strong></p>",
			"<p>Podes ingresar a la aplicación haciendo click <a href='https://teach-from-home.web.app/'>ACA</a></p>"
		)
	}

	static def newExam(User user, Classroom classRoom, Exam exam) {
		return String.join(
			System.getProperty("line.separator"),
			"<h1>Examen activo!</h1>",
			"<p>Hola " + user.name + ",</p>",
			"<p>Se ha activado el examen de: <strong> " + classRoom.subject.name + "</strong><br><p>",
			"<p>La examen es: <strong>" + exam.title + "</strong></p>",
			"<p>Recorda entregarlo antes del <strong>" + Parsers.dateString(exam.deadLine) + "</strong></p>",
			"<p> <strong>Importante: </strong> Una vez que inicies el examen empieza a correr el tiempo!
				 recorda entregarlo dentro de <strong> " + exam.minutes + " minutos</strong></p>",
			"<p>Podes ingresar a la aplicación haciendo click <a href='https://teach-from-home.web.app/'>ACA</a></p>"
		)
	}

	static def getStringRole(String role) {
		if (role == Role.admin)
			return "administrador"

		if (role == Role.teacher)
			return "profesor"

		if (role == Role.student)
			return "estudiante"
	}
}
