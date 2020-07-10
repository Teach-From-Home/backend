package services

import domain.Exam
import repository.ClassroomRepository
import repository.ExamsRepository

class ExamsService {
	ExamsRepository examRepo = ExamsRepository.getInstance
	ClassroomRepository classroomRepo = ClassroomRepository.getInstance
	
	def create(Exam newExam, String classroomId) {
		val classroom = classroomRepo.searchById(classroomId)
		val persistedExam = examRepo.create(newExam)
		classroom.examsIds.add(persistedExam.id)
		classroomRepo.update(classroom)
	}
	
}