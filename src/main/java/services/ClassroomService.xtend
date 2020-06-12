package services

import Repository.ClassroomRepository
import Parsers.ParserStringToLong

class ClassroomService {
	ClassroomRepository classroomRepo = ClassroomRepository.instance
	static ParserStringToLong parserStringToLong = ParserStringToLong.instance
	
	def getClassrooms(){
		classroomRepo.getClassrooms()
	}
	
	def getUsersOfClassroom(String id){
		classroomRepo.getClassroom(parserStringToLong.parsearDeStringALong(id)).users
	}
	
	def getTeacherGetHomeworkOfClassroom(String id){
		classroomRepo.getClassroom(parserStringToLong.parsearDeStringALong(id)).homework	
	}
	
	def getStudentGetHomeworkOfClassroom(String id){
		classroomRepo.getHomeworkFromStudentView(parserStringToLong.parsearDeStringALong(id))	
	}
}