package services

import Repository.UserRepository
import org.uqbar.xtrest.json.JSONUtils
import org.eclipse.xtend.lib.annotations.Accessors

class UserService {
	extension JSONUtils = new JSONUtils
	UserRepository userRepo = UserRepository.instance
	
	def getUserSignIn(String userSignInBody){
		val userSignInData = userSignInBody.fromJson(UserSignIn)
		userRepo.getUserBySignIn(userSignInData).toJson
	}
	
	def getUsers(){
		userRepo.getUsers()
	}
}

@Accessors
class UserSignIn{
	int dni
	String password
}