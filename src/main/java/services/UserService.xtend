package services

import Repository.UserRepository
import org.eclipse.xtend.lib.annotations.Accessors
import Parsers.ParserStringToLong

class UserService {
	UserRepository userRepo = UserRepository.instance
	static ParserStringToLong parserStringToLong = ParserStringToLong.instance
	
	def getUserSignIn(UserSignIn userSignInData){
		userRepo.getUserBySignIn(userSignInData)
	}
	
	def getUsers(){
		userRepo.getUsers()
	}
	
	def getTeacherSubjects(String id){
		userRepo.getTeacherSubjects(parserStringToLong.parsearDeStringALong(id)).subjects
	}
}

@Accessors
class UserSignIn{
	int dni
	String password
}