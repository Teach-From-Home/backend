package App

import Repository.UserRepository
import domain.Student
import domain.User
import domain.Teacher
import domain.Subject
import Repository.ClassroomRepository
import Repository.SubjectRepository
import domain.Classroom
import domain.Homework
import domain.HomeworkDone
import java.time.LocalDate
import domain.Post

class GenObjects {
	def static generateAll(){
		
		//Repo
		
		val userRepo  = new UserRepository
		val classroomRepo = new ClassroomRepository
		val subjectRepo = new SubjectRepository
		
		//Subject data definition
		
		val dataBase = new Subject =>[
			name = "Base de Datos"
			
			description = "Materia en la cual se veran temas relacionados a base de datos, diagramas, formas normales, etc."
		]
		
		//User Data definition
		
		val admin = new User => [
			name = "juan"
			
			lastName = "pedraza"
			
			email = "juanpedraza@gmail.com"
			
			dni = 40128383
			
			password = "admin"
		]
		
		val student1 = new Student => [
			name = "pepe"
		
			lastName = "tini"
		
			email = "agustinmariotini@gmail.com"
		
			dni = 38992539
		
			password = "tini"
		]
		
		val teacher = new Teacher => [
			name = "julian"
			
			lastName = "weich"
			
			email = "julianweich@gmail.com"
			
			dni = 16546867
			
			password = "julian"
		]
		
		teacher.addSubject(dataBase)
		
		//Set student id as the same as Hibernate student id, to init the student
		
		teacher.id = new Long(4)
		
		student1.id = new Long(2)
		
		//Post and coment data definition
		
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
		
		//HomeworkDone data definition
		
		val derRealizado = new HomeworkDone => [
			description = "Una base de datos para una pequeña empresa debe contener información acerca de clientes, artículos y pedidos. Hasta el momento se registran los siguientes datos en documentos varios: • Para cada cliente: Número de cliente (único), Direcciones de envío (varias por cliente), Saldo, Límite de
crédito (depende del cliente, pero en ningún caso debe superar los 3.000.000 pts), Descuento. 
• Para cada artículo: Número de artículo (único), Fábricas que lo distribuyen, Existencias de ese artículo 
en cada fábrica, Descripción del artículo. • Para cada pedido: Cada pedido tiene una cabecera y el cuerpo del pedido. 
La cabecera está formada por el número de cliente, dirección de envío y fecha del pedido. El cuerpo del pedido son varias líneas, en 
cada línea se especifican el número del artículo pedido y la cantidad. 
Además, se ha determinado que se debe almacenar la información de las fábricas. Sin embargo, dado el 
uso de distribuidores, se usará: Número de la fábrica (único) y Teléfono de contacto. Y se desean ver 
cuántos artículos (en total) provee la fábrica. También, por información estratégica, se podría incluir 
información de fábricas alternativas respecto de las que ya fabrican artículos para esta empresa. Nota: Una dirección se entenderá como Nº, Calle, Comuna y Ciudad. Una fecha incluye hora. 
Se pide hacer el diagrama ER para la base de datos que represente esta información."

			date = LocalDate.of(2020, 09, 01)
			
			available = true
			
			student = student1
			file = "asdasd"
			grade = 9
			coment = "nicely done!!"
		]
		
		//Homework data definition
		
		val realizarDer = new Homework => [
			description = "Una base de datos para una pequeña empresa debe contener información acerca de clientes, artículos y pedidos. Hasta el momento se registran los siguientes datos en documentos varios: • Para cada cliente: Número de cliente (único), Direcciones de envío (varias por cliente), Saldo, Límite de
crédito (depende del cliente, pero en ningún caso debe superar los 3.000.000 pts), Descuento. 
• Para cada artículo: Número de artículo (único), Fábricas que lo distribuyen, Existencias de ese artículo 
en cada fábrica, Descripción del artículo. • Para cada pedido: Cada pedido tiene una cabecera y el cuerpo del pedido. 
La cabecera está formada por el número de cliente, dirección de envío y fecha del pedido. El cuerpo del pedido son varias líneas, en 
cada línea se especifican el número del artículo pedido y la cantidad. 
Además, se ha determinado que se debe almacenar la información de las fábricas. Sin embargo, dado el 
uso de distribuidores, se usará: Número de la fábrica (único) y Teléfono de contacto. Y se desean ver 
cuántos artículos (en total) provee la fábrica. También, por información estratégica, se podría incluir 
información de fábricas alternativas respecto de las que ya fabrican artículos para esta empresa. Nota: Una dirección se entenderá como Nº, Calle, Comuna y Ciudad. Una fecha incluye hora. 
Se pide hacer el diagrama ER para la base de datos que represente esta información."

			date = LocalDate.of(2020, 09, 05)
			
			available = true
		]
		
		realizarDer.addHomeworkDone(derRealizado)
		
		//Subject repo create
		
		subjectRepo.createOrUpdate(dataBase)
		dataBase.id = new Long(1)
		
		//Classroom data definition
		
		val cursadaDataBase = new Classroom => [
			subject = dataBase
			description = "cursada de 10 a 12"
		]
		
		cursadaDataBase.addHomeWork(realizarDer)
		cursadaDataBase.addPost(consultaDer)
		cursadaDataBase.addUser(student1)
		cursadaDataBase.addUser(teacher)
		
		//User repo create and setup values on list
		
		userRepo.createOrUpdate(student1)
		userRepo.createOrUpdate(admin)
		userRepo.createOrUpdate(teacher)
		
		//Classroom repo create
		
		classroomRepo.createOrUpdate(cursadaDataBase)
	}
}