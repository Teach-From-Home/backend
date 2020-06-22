package services

import domain.Homework
import domain.HomeworkDone
import java.time.LocalDate
import repository.ClassroomRepository
import repository.HomeworkRepository
import repository.UserRepository
import utils.HomeworkParser
import utils.Role
import utils.Parsers

class HomeworkService {
	HomeworkRepository homeworkRepo = HomeworkRepository.getInstance
	UserRepository userRepo = UserRepository.getInstance
	ClassroomRepository classroomRepo = ClassroomRepository.getInstance
	
	def createHomework(String classroomId, HomeworkParser homework, String idUser){
		val userParent = userRepo.searchById(idUser)
		val homeworkParent = new Homework
		homeworkParent.teacher = userParent
		homeworkParent.available = homework.available
		homeworkParent.title = homework.title
		homeworkParent.description = homework.description
		homeworkParent.deadLine = Parsers.ParseStringToDate(homework.deadLine)
		val classroom = classroomRepo.searchById(classroomId)
		classroom.addHomeWork(homeworkParent)
		classroomRepo.update(classroom)
	}
	
	def updateHomework(String idHomework, HomeworkParser homework){
		val homeworkParent = homeworkRepo.searchById(idHomework)
		homeworkParent.title = homework.title
		homeworkParent.description = homework.description
		homeworkParent.available = homework.available
		homeworkParent.deadLine = Parsers.ParseStringToDate(homework.deadLine)
		homeworkRepo.update(homeworkParent)
	}
	
	def createHomeworkDone(String homeworkId, String idUser, HomeworkDone homeworkDone){
		homeworkDone.student = userRepo.searchById(idUser)
		val homework = homeworkRepo.searchById(homeworkId)
		homeworkDone.uploadDate = LocalDate.now
		homework.uploadHomework(homeworkDone)
		homeworkRepo.update(homework)
	}
	
	def reUploadHomeworkDone(String homeworkId, String idUser, HomeworkDone updateHomeworkDone){
		val user = userRepo.searchById(idUser)
		val homework = homeworkRepo.searchById(homeworkId)
		homework.updateHomeworkDone(user,updateHomeworkDone.file)
		homeworkRepo.update(homework)
	}
	
	def updateHomeworkDone(String homeworkId,String idUser, HomeworkDone newHomeworkDone){
		val homeworkParent = homeworkRepo.searchById(homeworkId)
		val student = userRepo.searchById(idUser)
		val oldHomeworkDone = homeworkParent.uploadedHomeworks.findFirst[it.student == student]
		homeworkParent.removeHomework(oldHomeworkDone)
		if(newHomeworkDone.grade !== null)
			oldHomeworkDone.grade = newHomeworkDone.grade
		if(newHomeworkDone.coment !== null)
			oldHomeworkDone.coment = newHomeworkDone.coment
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