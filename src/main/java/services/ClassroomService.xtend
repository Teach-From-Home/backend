package services

import domain.Classroom
import javassist.NotFoundException
import repository.ClassroomRepository
import repository.UserRepository
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
			val user = UserRepository.getInstance.searchById(userId)
			val homeworks = classroomRepo.searchById(idClassroom).homework.filter[it.available]
			val hw = homeworks.filter[!it.isDoneByUser(user)].toList
			if(hw.nullOrEmpty) throw new NotFoundException("No hay tareas pendientes")
			return hw
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

	def getClassroomPosts(String id) {
		classroomRepo.getClassroomByListType(id, "posts").posts
	}

	def getClassroomsByUser(String id) {
		classroomRepo.getClassroomsByUser(id)
	}
	
	def notAddedTeachers(String classroomId){
		val classr = classroomRepo.searchById(classroomId)
		var all = classroomRepo.notAddedTeachers(classr)
		all = all.filter[it.subjects.exists[it == classr.subject]].toList
		return all
	}
	
	def notAddedStudents(String classroomId){
		val classr = classroomRepo.searchById(classroomId)
		var all = classroomRepo.notAddedStudents(classr)
		return all
	}
	
	def addUser(String classroomId, String userId){
		val classr = classroomRepo.searchById(classroomId)
		classr.users.add(userRepo.searchById(userId))
		classroomRepo.update(classr)
	}
	
	def deleteUser(String classroomId, String userId){
		val classr = classroomRepo.searchById(classroomId)
		classr.users.remove(userRepo.searchById(userId))
		classroomRepo.update(classr)
	}
}
