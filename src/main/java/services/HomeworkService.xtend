package services

import domain.Homework
import domain.HomeworkDone
import repository.ClassroomRepository
import repository.HomeworkRepository
import repository.UserRepository

class HomeworkService {
	HomeworkRepository homeworkRepo = HomeworkRepository.getInstance
	UserRepository userRepo = UserRepository.getInstance
	ClassroomRepository classroomRepo = ClassroomRepository.getInstance
	
	def createHomework(String classroomId, Homework homework, String idUser){
		val userParent = userRepo.searchById(idUser)
		homework.teacher = userParent
		val classroom = classroomRepo.searchById(classroomId)
		classroom.addHomeWork(homework)
		classroomRepo.update(classroom)
	}
	
	def updateHomework(String idHomework, Homework homework){
		val homeworkParent = homeworkRepo.searchById(idHomework)
		homeworkParent.title = homework.title
		homeworkParent.description = homework.description
		homeworkParent.available = homework.available
		homeworkRepo.update(homeworkParent)
	}
	
	def createHomeworkDone(String homeworkId, String idUser, HomeworkDone homeworkDone){
		homeworkDone.student = userRepo.searchById(idUser)
		val homework = homeworkRepo.searchById(homeworkId)
		homework.uploadHomework(homeworkDone)
		homeworkRepo.update(homework)
	}
	
	def getUploadedHomeworks(String idHomework) {
		return homeworkRepo.searchById(idHomework).uploadedHomeworks.toList
	}
}