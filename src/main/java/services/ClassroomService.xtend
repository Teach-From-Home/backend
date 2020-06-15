package services

import domain.Classroom
import repository.ClassroomRepository
import repository.UserRepository
import utils.Role

class ClassroomService {
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
			return classroomRepo.searchById(idClassroom).homework
		} else {
			val user = UserRepository.getInstance.searchById(userId)
			val homeworks = classroomRepo.searchById(idClassroom).homework.filter[it.available]
			return homeworks.filter[!it.isDoneByUser(user)].toList
		}
	}

	def getUploadedHomeworks(String idClassroom, String idHomework) {
		classroomRepo.getHomeworkDoneOfHomework(idClassroom, idHomework).uploadedHomeworks
	}

	def getClassroomPosts(String id) {
		classroomRepo.getClassroomByListType(id, "posts").posts
	}

	def getNotAddedSubjects(String idClassroom) {
		classroomRepo.notAddedUsers(idClassroom)
	}

	def getClassroomsByUser(String id) {
		classroomRepo.getClassroomsByUser(id)
	}
}
