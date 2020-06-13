package services

import Repository.SubjectRepository

class SubjectService {
	SubjectRepository subjectRepo = SubjectRepository.instance
	
	def getSubjects(){
		subjectRepo.allInstances
	}
}