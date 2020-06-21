package services

import domain.CalendarEntry
import domain.User
import java.util.List
import repository.UserRepository
import repository.ClassroomRepository

class UserService {
	UserRepository userRepo = UserRepository.instance
	ClassroomRepository classroomRepo = ClassroomRepository.instance
	
	def getUserSignIn(User loginCredentials, String AppType){
		userRepo.login(loginCredentials,AppType)
	}
	
	def getUsers(){
		userRepo.allInstances
	}
	
	def getUserById(String id){
		userRepo.searchById(id)
	}
	
	def editUser(User user, String id){
		val userg = getUserById(id)
		userg.name = user.name
		userg.lastname = user.lastname
		userg.email = user.email
		userg.dni = user.dni
		userg.password = user.password
		userg.subjects = user.subjects
		userRepo.update(userg)
	}
	
	def deleteUser(String id){
		val deleted = getUserById(id)
		deleted.active = !deleted.active
		userRepo.update(deleted)
	}
	
	def createUser(User user){
		userRepo.create(user)
		//MailSender.send(user,MailTemplates.newUser(user),"Bienvenido a TFM")
	}
	
	def getNotAddedSubjects(String id) {
		userRepo.notAddedSubjects(id)
	}
	
	def getUserCalerndar(String id){
		val userClassrooms = classroomRepo.getClassroomsByUser(id)
		val List<CalendarEntry> calendar = newArrayList
		userClassrooms.forEach[calendar.addAll(it.calendarEntries)]
		calendar.sortBy[deadLine].reverseView.toList
	}
	
}