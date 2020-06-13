package app

import domain.Classroom
import domain.Homework
import domain.HomeworkDone
import domain.Post
import domain.Student
import domain.Subject
import domain.Teacher
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

		// User Data definition
		val admin = new User => [
			name = "admin"

			dni = 40128383

			password = "admin"
		]

		val student1 = new Student => [
			name = "pepe"

			lastname = "tini"

			email = "agustinmariotini@gmail.com"

			dni = 38992539

			password = "tini"
		]

		val teacher = new Teacher => [
			name = "julian"

			lastname = "weich"

			email = "julianweich@gmail.com"

			dni = 16546867

			password = "julian"
		]

		teacher.addSubject(dataBase)


		// Post and coment data definition
		val comentarioDer = new Post => [
			user = teacher
			isPrivate = true
			text = "hola, como estas? que necesitas?"
			date = LocalDate.of(2020, 09, 04)
		]

		val consultaDer = new Post => [
			user = student1
			isPrivate = true
			text = "hola, tengo una consulta con el der de la tarea."
			date = LocalDate.of(2020, 09, 03)
		]

		consultaDer.addComent(comentarioDer)

		

		// Homework data definition
		val realizarDer = new Homework => [
			description = "Una base de datos para una peque�a empresa debe contener informaci�n acerca de clientes, art�culos y pedidos. Hasta el momento se registran los siguientes datos en documentos varios: � Para cada cliente: N�mero de cliente (�nico), Direcciones de env�o (varias por cliente), Saldo, L�mite de
				cr�dito (depende del cliente, pero en ning�n caso debe superar los 3.000.000 pts), Descuento. 
				� Para cada art�culo: N�mero de art�culo (�nico), F�bricas que lo distribuyen, Existencias de ese art�culo 
				en cada f�brica, Descripci�n del art�culo. � Para cada pedido: Cada pedido tiene una cabecera y el cuerpo del pedido. 
				La cabecera est� formada por el n�mero de cliente, direcci�n de env�o y fecha del pedido. El cuerpo del pedido son varias l�neas, en 
				cada l�nea se especifican el n�mero del art�culo pedido y la cantidad. 
				Adem�s, se ha determinado que se debe almacenar la informaci�n de las f�bricas. Sin embargo, dado el 
				uso de distribuidores, se usar�: N�mero de la f�brica (�nico) y Tel�fono de contacto. Y se desean ver 
				cu�ntos art�culos (en total) provee la f�brica. Tambi�n, por informaci�n estrat�gica, se podr�a incluir 
				informaci�n de f�bricas alternativas respecto de las que ya fabrican art�culos para esta empresa. Nota: Una direcci�n se entender� como N�, Calle, Comuna y Ciudad. Una fecha incluye hora. 
				Se pide hacer el diagrama ER para la base de datos que represente esta informaci�n."

			date = LocalDate.of(2020, 09, 05)

			available = true
		]
		// HomeworkDone data definition
		val derRealizado = new HomeworkDone => [
			uploadDate = LocalDate.of(2020, 09, 01)
			student = student1
			file = "asdasd"
			grade = 9
			coment = "nicely done!!"
		]

		realizarDer.uploadHomework(derRealizado)
		
		// Classroom data definition
		val cursadaDataBase = new Classroom => [
			subject = dataBase
			description = "cursada de 10 a 12"
		]
		
		// Subject repo create
		subjectRepo.create(dataBase)
		
		// User repo create and setup values on list
		userRepo.create(student1)
		userRepo.create(admin)
		userRepo.create(teacher)
		
		cursadaDataBase.addHomeWork(realizarDer)
		cursadaDataBase.addPost(consultaDer)
		cursadaDataBase.addUser(student1)
		cursadaDataBase.addUser(teacher)
		
		// Classroom repo create
		classroomRepo.create(cursadaDataBase)


	}
}
