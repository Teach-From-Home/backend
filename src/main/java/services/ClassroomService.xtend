package services

import repository.ClassroomRepository

class ClassroomService {
	ClassroomRepository classroomRepo = ClassroomRepository.instance
	
	def getClassrooms(){
		classroomRepo.allInstances
	}
}