package services

import domain.Exam
import repository.ClassroomRepository
import repository.ExamsRepository
import utils.Role

class ExamsService {
	ExamsRepository examRepo = ExamsRepository.getInstance
	ClassroomRepository classroomRepo = ClassroomRepository.getInstance
	
	def create(Exam newExam, String classroomId) {
		val classroom = classroomRepo.searchById(classroomId)
		val persistedExam = examRepo.create(newExam)
		classroom.examsIds.add(persistedExam.id)
		classroomRepo.update(classroom)
	}
	
	def updateExam(Exam exam) {
		examRepo.update(exam)
	}
	
	def clasroomsExams(String id, String role){
		val classroom = classroomRepo.searchById(id)
		var exams = classroom.examsIds.map[examRepo.searchById(it)].toList
		if(Role.student == role)
			exams = exams.filter[it.available].toList
		exams
	}
	
}