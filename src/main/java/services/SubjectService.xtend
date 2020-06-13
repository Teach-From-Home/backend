package services

import domain.Subject
import repository.SubjectRepository

class SubjectService {
	SubjectRepository subjectRepo = SubjectRepository.instance
	
	def getSubjects(){
		subjectRepo.allInstances
	}
	
	def getSubjectById(String id){
		subjectRepo.searchById(id)
	}
	
	def editSubject(Subject subject, String id){
		val subjectg = subjectRepo.searchById(id)
		subjectg.name = subject.name
		subjectg.description = subject.description
		subjectRepo.update(subjectg)
	}
	
	def deleteSubject(String id){
		val deleted = subjectRepo.searchById(id)
		deleted.active = false
		subjectRepo.update(deleted)
	}
	
	def createSubject(Subject subject){
		subjectRepo.create(subject)
	}
}