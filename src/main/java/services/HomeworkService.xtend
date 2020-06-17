package services

import domain.Homework
import domain.HomeworkDone
import repository.HomeworkRepository
import repository.UserRepository
import repository.ClassroomRepository

class HomeworkService {
	HomeworkRepository homeworkRepo = HomeworkRepository.getInstance
	UserRepository userRepo = UserRepository.getInstance
	ClassroomRepository classroomRepo = ClassroomRepository.getInstance
	
	def createHomework(String classroomId, Homework homework){
		val classroom = classroomRepo.searchById(classroomId)
		classroom.addHomeWork(homework)
		classroomRepo.update(classroom)
	}
	
	def uploadHomework(String homeworkId, String idUser, HomeworkDone homeworkDone){
		homeworkDone.student = userRepo.searchById(idUser)
		val homework = homeworkRepo.searchById(homeworkId)
		homework.uploadHomework(homeworkDone)
		homeworkRepo.update(homework)
	}
	
	def getUploadedHomeworks(String idHomework) {
		return homeworkRepo.searchById(idHomework).uploadedHomeworks.toList
	}
	
}