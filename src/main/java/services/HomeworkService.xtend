package services

import repository.HomeworkRepository
import domain.Homework
import repository.UserRepository

class HomeworkService {
	HomeworkRepository homeworkRepo = HomeworkRepository.instance
	UserRepository userRepo = UserRepository.instance
	
	def createHomework(String idClassroom,Homework homework, String idUser){
		homework.teacher = Long.parseLong(idUser)//userRepo.searchById(idUser)
		homework.classroomId = Long.parseLong(idClassroom)
		homeworkRepo.create(homework)
	}
	
	def createHomeworkDone(String idClassroom, String idHomework,String idUser, Homework homeworkDone){
		val description =  homeworkDone.description
		
		homeworkDone.student = Long.parseLong(idUser)//userRepo.searchById(idUser)
		
		homeworkRepo.create(homeworkDone)
		
		val homeworkDONE = homeworkRepo.searchByExample(idUser, description)
		
		val homework = homeworkRepo.searchById(idHomework)
		
		homework.uploadHomework(homeworkDONE)
		
		homeworkRepo.update(homework)
	}
}