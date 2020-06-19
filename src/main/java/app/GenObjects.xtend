package app

import domain.Classroom
import domain.ForumPost
import domain.Homework
import domain.HomeworkDone
import domain.Responses
import domain.Subject
import domain.User
import java.time.LocalDate
import repository.ClassroomRepository
import repository.SubjectRepository
import repository.UserRepository

class GenObjects {
	def static generateAll() {

		// Repo
		val userRepo = new UserRepository
		val classroomRepo = new ClassroomRepository
		val subjectRepo = new SubjectRepository

		// Subject data definition
		val dataBase = new Subject => [
			name = "Base de Datos"

			description = "Materia en la cual se veran temas relacionados a base de datos, diagramas, formas normales, etc."
		]

		val phm = new Subject => [
			name = "Programacion con herramientas modernas"

			description = "Materia en la cual utilizamos 14 millones de tipos de bases de datos y/o graficos geniales para una aplicacion"
		]

		// User Data definition
		val admin = new User => [
			name = "Blanca"

			lastname = "Suarez"

			dni = 40128383

			email = "blancasuarez@gmail.com"

			password = "admin"

			role = "ADMIN"
		]

		val student1 = new User => [
			name = "Agustin Mario"

			lastname = "Tini"

			email = "agustinmariotini@gmail.com"

			dni = 38992539

			password = "madera"

			role = "STUDENT"
		]

		val student2 = new User => [
			name = "Eugenio"

			lastname = "Rossetto"

			email = "eugerosso22@gmail.com"

			dni = 39912240

			password = "challenger"

			role = "STUDENT"
		]

		val student3 = new User => [
			name = "Javier"

			lastname = "Gomez"

			email = "javiemgz@gmail.com"

			dni = 40244802

			password = "oro"

			role = "STUDENT"
		]

		val teacher1 = new User => [
			name = "Julian"

			lastname = "Weich"

			email = "julianweich@gmail.com"

			dni = 16546867

			password = "julian"

			role = "TEACHER"
		]

		val teacher2 = new User => [
			name = "Dodain"

			lastname = "Mc Clane"

			email = "durodecodear@gmail.com"

			dni = 18943634

			password = "lorddodain"

			role = "TEACHER"
		]

		teacher1.addSubject(dataBase)

		teacher2.addSubject(phm)

		// Post and coment data definition
		val comentarioDer = new Responses => [
			user = teacher1
			text = "Hola, como estas? Que necesitas?"
			date = LocalDate.of(2020, 09, 04)
		]
		
		val consultaUml = new ForumPost => [
			user = student2
			isPrivate = false
			title = "UML tarea"
			text = "hola, tengo una consulta con el uml de la tarea."
			date = LocalDate.of(2020, 09, 09)
		]

		val consultaDer = new ForumPost => [
			user = student1
			isPrivate = true
			title = "Der tarea"
			text = "Hola, tengo una consulta con el der de la tarea."
			date = LocalDate.of(2020, 09, 03)
		]

		consultaDer.addComent(comentarioDer)

		// Homework data definition
		val realizarDer = new Homework => [
			title = "Crear der"
			
			description = "Crear der simulando una aerolinea, relacionando vuelos, asientos, usuarios y pasajes."

			deadLine = LocalDate.of(2020, 09, 05)
			
			teacher = teacher1
			
			available = true
		]

		// HomeworkDone data definition
		val crearUML = new Homework => [
			title = "Crear uml"
			
			description = "Crear uml de los libros que vimos en clases"

			deadLine = LocalDate.of(2020, 011, 03)
			
			teacher = teacher1
			
			available = false
		]
		
		val subirCUS = new Homework => [
			title = "Subir CUS"
		
			description = "Subir CUS que vimos en clases"

			deadLine = LocalDate.of(2020, 011, 03)

			teacher = teacher1

			available = true
		]

		val derRealizado = new HomeworkDone => [
			uploadDate = LocalDate.of(2020, 09, 05)
			student = student1
			file = "asdasd"
			grade = 9.00
			coment = "Muy completo!"
			file="https://firebasestorage.googleapis.com/v0/b/teach-from-home.appspot.com/o/homeworks%2FCuadernillo%20practica_del_alumno.pdf?alt=media&token=361a0334-172b-40ca-935e-7122ae9454ef"
		]

		realizarDer.uploadHomework(derRealizado)

		// Classroom data definition
		val cursadaDataBase = new Classroom => [
			subject = dataBase
			name="Miercoles - Viernes Noche"
			description = "Cursada dias miercoles y viernes en el horario de 18 A 21:30HS "
		]

		// Subject repo create
		subjectRepo.create(dataBase)
		subjectRepo.create(phm)

		// User repo create and setup values on list
		userRepo.create(student1)
		userRepo.create(student2)
		userRepo.create(student3)
		userRepo.create(admin)
		userRepo.create(teacher1)
		userRepo.create(teacher2)

		cursadaDataBase.addHomeWork(realizarDer)
		cursadaDataBase.addHomeWork(crearUML)
		cursadaDataBase.addHomeWork(subirCUS)
		cursadaDataBase.addPost(consultaDer)
		cursadaDataBase.addPost(consultaUml)
		cursadaDataBase.addUser(student1)
		cursadaDataBase.addUser(student2)
		cursadaDataBase.addUser(teacher1)

		// Classroom repo create
		classroomRepo.create(cursadaDataBase)
		cursadaDataBase.keyName = cursadaDataBase.subject.name.replaceAll("\\s+","").toLowerCase+cursadaDataBase.id
		classroomRepo.update(cursadaDataBase)

	}
}
