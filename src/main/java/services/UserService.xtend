package services

import domain.User
import repository.UserRepository

class UserService {
	UserRepository userRepo = UserRepository.instance
	
	def getUserSignIn(User loginCredentials){
		userRepo.login(loginCredentials)
	}
	
	def getUsers(){
		userRepo.allInstances
	}
}