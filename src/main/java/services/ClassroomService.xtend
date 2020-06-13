package services

import repository.ClassroomRepository
import utils.Parsers
import domain.Classroom

class ClassroomService {
	ClassroomRepository classroomRepo = ClassroomRepository.instance
	Parsers parsers = new Parsers
	
	def getClassrooms(){
		classroomRepo.allInstances
	}
	
	def getClassroomById(String id){
		classroomRepo.searchById(id)
	}
	
	def editClassroom(Classroom classroom, String id){
		val classroomg = getClassroomById(id)
		classroomg.description = classroom.description
		classroomg.subject = classroom.subject
		classroomRepo.update(classroomg)
	}
	
	def deleteClassroom(String id){
		val deleted = getClassroomById(id)
		deleted.active = !deleted.active
		classroomRepo.update(deleted)
	}
	
	def createClassroom(Classroom clasroom){
		classroomRepo.create(clasroom)
	}
	
	def getClassroomUsers(String id){
		classroomRepo.getClassroomByListType(id, "users").users
	}
	
	def getClassroomHomework(String id){
		classroomRepo.getClassroomByListType(id, "homework").homework
	}
	
	def getClassroomPosts(String id){
		classroomRepo.getClassroomByListType(id, "posts").posts
	}
}