package services

import repository.ClassroomRepository
import utils.ParserStringToLong

class ClassroomService {
	ClassroomRepository classroomRepo = ClassroomRepository.instance
	static ParserStringToLong parserStringToLong = ParserStringToLong.instance
	
	def getClassrooms(){
		classroomRepo.allInstances
	}
	
	def getClassroomUsers(String id){
		classroomRepo.getClassroomByListType(parserStringToLong.parsearDeStringALong(id), "users").users
	}
	
	def getClassroomHomework(String id){
		classroomRepo.getClassroomByListType(parserStringToLong.parsearDeStringALong(id), "homework").homework
	}
	
	def getClassroomPosts(String id){
		classroomRepo.getClassroomByListType(parserStringToLong.parsearDeStringALong(id), "posts").posts
	}
}