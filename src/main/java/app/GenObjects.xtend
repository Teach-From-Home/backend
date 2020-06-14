package app

import domain.Classroom
import domain.Homework
import domain.Post
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
			name = "blanca"

			lastname = "suarez"

			dni = 40128383
			
			email = "blancasuarez@gmail.com"

			password = "admin"
			
			role = "ADMIN"
		]

		val student1 = new User => [
			name = "agustin mario"

			lastname = "tini"

			email = "agustinmariotini@gmail.com"

			dni = 38992539

			password = "madera"
			
			role = "STUDENT"
		]

		val student2 = new User => [
			name = "eugenio"
			
			lastname = "rossetto"
			
			email = "eugerosso22@gmail.com"
			
			dni = 40213293
			
			password = "challenger"
			
			role = "STUDENT"
		]
		
		val student3 = new User => [
			name = "javier"
			
			lastname = "gomez"
			
			email = "javiemgz@gmail.com"
			
			dni = 40244802
			
			password = "oro"
			
			role = "STUDENT"
		]
		
		val teacher = new User => [
			name = "julian"
			
			lastname = "weich"
			
			email = "julianweich@gmail.com"
			
			dni = 16546867
			
			password = "julian"
			
			role = "TEACHER"
		]
		
		val teacher2 = new User => [
			name = "dodain"
			
			lastname = "Mc Clane"
			
			email = "durodecodear@gmail.com"
			
			dni = 18943634
			
			password = "lorddodain"
			
			role = "TEACHER"
		]
		
		teacher.addSubject(dataBase)
		
		teacher2.addSubject(phm)
		
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
		
		val crearUML = new Homework => [
			description = "Crear uml"

			date = LocalDate.of(2020, 011, 03)
			
			available = true
		]
		
		val derRealizado = new Homework => [
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
			
			uploadDate = LocalDate.of(2020, 09, 01)
			studentId = Long.parseLong("3")
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
		subjectRepo.create(phm)
		
		// User repo create and setup values on list
		userRepo.create(student1)
		userRepo.create(student2)
		userRepo.create(student3)
		userRepo.create(admin)
		userRepo.create(teacher)
		userRepo.create(teacher2)
		
		cursadaDataBase.addHomeWork(realizarDer)
		cursadaDataBase.addHomeWork(crearUML)
		cursadaDataBase.addPost(consultaDer)
		cursadaDataBase.addUser(student1)
		cursadaDataBase.addUser(teacher)
		
		// Classroom repo create
		classroomRepo.create(cursadaDataBase)


	}
}
