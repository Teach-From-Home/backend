package utils

import domain.Classroom
import domain.User

class MailTemplates {

	static def newUser(User user) {
		return String.join(
			System.getProperty("line.separator"),
			"<h1>Bienvenido a TFM!</h1>",
			"<p>Hola " + user.name + " queremos darte la bienvenida a TFM una nueva plataforma para educacion virtual.</p>",
			"<p>Tu usuario de " + getStringRole(user.role) + " fue dado de alta por un administrador.</p>",
			"<p>A continuacion te dejamos las credenciales para el primer ingreso<p>",
			"<p>Usuario: <strong>" + user.dni + "</strong></p>",
			"<p>Contraseña: <strong>" + user.password + "</strong></p>",
			"<p>Podes ingresar a la aplicacion haciendo click <a href='google.com'>ACA</a></p>"
		)
	}
	
	static def addedToClassroom(User user, Classroom classRoom) {
		return String.join(
			System.getProperty("line.separator"),
			"<h1>Aviso TFM</h1>",
			"<p>Hola " + user.name+"</p>",
			"<p>Has sido agregado al siguiente classroom <strong> "+classRoom.name+"</strong></p>",
			"<p>Se dicta la materia: <strong> "+classRoom.subject.name+"</strong> <p>",
			"<p>Podes ingresar a la aplicacion haciendo click <a href='google.com'>ACA</a></p>"
		)
	}
	
	
	
	static def getStringRole(String role){
		if(role == Role.admin)
			return "administrador"
			
		if(role == Role.teacher)
			return "profesor"
			
		if(role == Role.student)
			return "estudiante"
	}
}
