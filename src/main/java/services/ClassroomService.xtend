package services

import domain.Classroom
import javassist.NotFoundException
import repository.ClassroomRepository
import repository.UserRepository
import utils.MailSender
import utils.MailTemplates
import utils.Role

class ClassroomService {
	UserRepository userRepo = UserRepository.getInstance
	ClassroomRepository classroomRepo = ClassroomRepository.instance

	def getClassrooms() {
		classroomRepo.allInstances
	}

	def getClassroomById(String id) {
		classroomRepo.searchById(id)
	}

	def editClassroom(Classroom classroom, String id) {
		val classroomg = getClassroomById(id)
		classroomg.description = classroom.description
		classroomg.subject = classroom.subject
		classroomRepo.update(classroomg)
	}

	def deleteClassroom(String id) {
		val deleted = getClassroomById(id)
		deleted.active = !deleted.active
		classroomRepo.update(deleted)
	}

	def createClassroom(Classroom clasroom) {
		classroomRepo.create(clasroom)
		//Genero una key """random""" para la call
		//No la creo antes por que no tiene id el classroom
		//suprimo espacios en blanco y agrego la id, para que sea unico
		clasroom.keyName = clasroom.subject.name.replaceAll("\\s+","").toLowerCase+clasroom.id
		//updateo con la key creada
		classroomRepo.update(clasroom)
	}

	def getClassroomUsers(String id) {
		classroomRepo.getClassroomByListType(id, "users").users
	}

	def getClassroomHomework(String idClassroom, String userId) {
		if (Role.validateRole(userId, Role.teacher)) {
			val hw = classroomRepo.searchById(idClassroom).homework
			if(hw.nullOrEmpty) throw new NotFoundException("No hay tareas subidas")
			return hw
		} else {
			// DANGER ZONE!!!!!
			//FOR YOUR MADAFAKIN LIFE PLEASE NEVER UPDATE A HW WITH THE RESPONSE OF THIS METHOD!!!
			val user = UserRepository.getInstance.searchById(userId)
			val homeworks = classroomRepo.searchById(idClassroom).homework.filter[it.available].toSet
			homeworks.forEach[ it.uploaded = it.isDoneByUser(user) ]
			homeworks.forEach[ it.uploadedHomeworks = it.uploadedHomeworks.filter[ it.student == user ].toSet ]
			if(homeworks.nullOrEmpty) throw new NotFoundException("No hay tareas pendientes")
			return homeworks
			//DANGER ZONE!!!!!
		}
	}

	def getUserUploadedHomework(String idClassroom, String userId) {
		val user = UserRepository.getInstance.searchById(userId)
		val homeworks = classroomRepo.searchById(idClassroom).homework.filter[it.available]
		var hw = homeworks.map[it.uploadedHomeworks].flatten.toList
		hw = hw.filter[it.student.id == user.id].toList
		if(hw.nullOrEmpty) throw new NotFoundException("No hay tareas subidas")
		hw
	}

	def getClassroomPosts(String id,String idUser) {
		if (Role.validateRole(idUser, Role.teacher)) {
			val ps = classroomRepo.getClassroomByListType(id, "posts").posts
			if(ps.nullOrEmpty) throw new NotFoundException("No hay posts pendientes")
			return ps
		} else {
			val userValue = userRepo.searchById(idUser)
			val ps = classroomRepo.getClassroomByListType(id, "posts").posts.filter[!it.isPrivate || it.user == userValue].toList
			if(ps.nullOrEmpty) throw new NotFoundException("No hay posts pendientes")
			return ps
		}
	}

	def getClassroomsByUser(String id) {
		classroomRepo.getClassroomsByUser(id).toList
	}
	
	def notAddedByUserType(String classroomId, String userType){
		val classr = classroomRepo.searchById(classroomId)
		if(classr.users.isEmpty){
			val all = userRepo.getActiveUsers(userType)
			if(userType == Role.teacher)
				return all.filter[it.subjects.exists[it == classr.subject]].toList
			return all
		} 
		
		if(userType == Role.teacher){
			val error = "No hay profesores para agregar"
			var all = classroomRepo.notAddedByUserType(classr, userType, error)
			all = all.filter[it.subjects.exists[it == classr.subject]].toList
			return all
		}else{
			val error = "No hay estudiantes para agregar"
			var all = classroomRepo.notAddedByUserType(classr, userType, error)
			return all
		}
	}

	def addUser(String classroomId, String userId){
		val classr = classroomRepo.searchById(classroomId)
		val newUser = userRepo.searchById(userId)
		classr.users.add(newUser)
		classroomRepo.update(classr)
		//MailSender.send(newUser,MailTemplates.addedToClassroom(newUser,classr),"Notificación TFM")
	}
	
	def deleteUser(String classroomId, String userId){
		val classr = classroomRepo.searchById(classroomId)
		classr.users.remove(userRepo.searchById(userId))
		classroomRepo.update(classr)
	}
}
