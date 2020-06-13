package services

import repository.SubjectRepository

class SubjectService {
	SubjectRepository subjectRepo = SubjectRepository.instance
	
	def getSubjects(){
		subjectRepo.allInstances
	}
}