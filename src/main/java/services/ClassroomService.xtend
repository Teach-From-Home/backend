package services

import Repository.ClassroomRepository

class ClassroomService {
	ClassroomRepository classroomRepo = ClassroomRepository.instance
	
	def getClassrooms(){
		classroomRepo.getClassrooms()
	}
}