package services

import repository.ClassroomRepository
import utils.Parsers
import domain.Classroom
import utils.Role
import java.util.List
import domain.Homework

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
	
	def getClassroomHomework(String id, String userId){
		if(Role.validateRole(userId, Role.teacher) ){
			classroomRepo.getClassroomByListType(id, "homework").homework
		}else if(Role.validateRole(userId, Role.student)){
			val homeworkList = classroomRepo.getClassroomByStudentView(id, userId)//.filter[it |  it.hasThisHomeworkDone(Long.parseLong(userId))]
			val chanchullo = chanchullo(homeworkList, userId).toList
			val mapMisTareas = mapMisTareas(classroomRepo.getClassroomByListType(id, "homework").homework, userId)
			chanchullo.addAll(mapMisTareas)
			return chanchullo
		}
	}
	
	def chanchullo(List<Homework> homeworks, String userId) {
		return homeworks.filter[homework |  homework.hasThisHomeworkDone(Long.parseLong(userId))]
	}
	
	def mapMisTareas(List<Homework> homeworks, String userId){
		homeworks.map[homework | homework.getHomeworkDone(Long.parseLong(userId))]
	}
	
	
	def getClassroomPosts(String id){
		classroomRepo.getClassroomByListType(id, "posts").posts
	}
}

