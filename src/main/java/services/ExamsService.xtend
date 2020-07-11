package services

import domain.Exam
import domain.Question
import domain.SolvedExam
import java.util.List
import org.bson.types.ObjectId
import repository.ClassroomRepository
import repository.ExamsRepository
import utils.Role
import repository.UserRepository

class ExamsService {
	ExamsRepository examRepo = ExamsRepository.getInstance
	ClassroomRepository classroomRepo = ClassroomRepository.getInstance
	
	
	def create(Exam newExam, String classroomId) {
		val classroom = classroomRepo.searchById(classroomId)
		newExam.questions.forEach[it.setAnswer]
		val persistedExam = examRepo.create(newExam)
		classroom.examsIds.add(persistedExam.id)
		classroomRepo.update(classroom)
	}
	
	def updateExam(Exam exam) {
		examRepo.update(exam)
	}
	
	def clasroomsExams(String id, String uid){
		val classroom = classroomRepo.searchById(id)
		var exams = classroom.examsIds.map[examRepo.searchById(it)].toList
		if(Role.validateRole(uid, Role.student)){
			exams = exams.filter[it.available].toList
			exams.forEach[it.setUploadedExam(uid)]
		}
		exams
	}
	
	def startExam(String examId,String userId){
		val exam = examRepo.searchById(new ObjectId(examId))
		exam.uploadExam(new SolvedExam(UserRepository.instance.searchById(userId)))
		examRepo.update(exam)
	}
	
	def finishExam(String examId, String userId, List<Question> answers){
		val exam = examRepo.searchById(new ObjectId(examId))
		exam.uploadQuestions(userId, answers)
		examRepo.update(exam)
	}
	
	def uploadCorrections(SolvedExam solvedExam, String eid){
		val exam = examRepo.searchById(new ObjectId(eid))
		exam.setCorrections(solvedExam.grade, solvedExam.studentId, solvedExam.teacherComment)
		examRepo.update(exam)
		
	}
	
	def uploadedExams(String eid){
		val exam = examRepo.searchById(new ObjectId(eid))
		exam.uploadedExams
	}
	
}