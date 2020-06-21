package services

import domain.Homework
import domain.HomeworkDone
import java.time.LocalDate
import java.time.LocalDateTime
import repository.ClassroomRepository
import repository.HomeworkRepository
import repository.UserRepository
import utils.Role

class HomeworkService {
	HomeworkRepository homeworkRepo = HomeworkRepository.getInstance
	UserRepository userRepo = UserRepository.getInstance
	ClassroomRepository classroomRepo = ClassroomRepository.getInstance
	
	def createHomework(String classroomId, Homework homework, String idUser){
		val userParent = userRepo.searchById(idUser)
		homework.teacher = userParent
		homework.available = false
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
		homeworkDone.uploadDate = LocalDate.now
		homework.uploadHomework(homeworkDone)
		homeworkRepo.update(homework)
	}
	
	def updateHomeworkDone(String homeworkId, HomeworkDone newHomeworkDone){
		val homeworkParent = homeworkRepo.searchById(homeworkId)
		val oldHomeworkDone = homeworkParent.uploadedHomeworks.findFirst[it == newHomeworkDone]
		homeworkParent.removeHomework(oldHomeworkDone)
		if(newHomeworkDone.grade !== null){
			oldHomeworkDone.grade = newHomeworkDone.grade
		}
		if(newHomeworkDone.coment !== null){
			oldHomeworkDone.coment = newHomeworkDone.coment
		}
		if(oldHomeworkDone.file != newHomeworkDone.file){
			oldHomeworkDone.file = newHomeworkDone.file
			oldHomeworkDone.grade = null
			oldHomeworkDone.coment = null
		}
		oldHomeworkDone.uploadDate = LocalDate.now
		homeworkParent.uploadHomework(oldHomeworkDone)
		homeworkRepo.update(homeworkParent)
	}
	
	def getUploadedHomeworks(String idHomework, String idUser) {
		if(Role.validateRole(idUser, Role.teacher)){
			return homeworkRepo.searchById(idHomework).uploadedHomeworks.toList
		}else{ //ELIMINAR ESTO
			val user = userRepo.searchById(idUser)
			val homeworks = homeworkRepo.searchById(idHomework).uploadedHomeworks.filter[it.student == user].toList
			return homeworks
		}
	}
}