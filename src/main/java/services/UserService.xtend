package services

import Repository.UserRepository
import domain.User

class UserService {
	UserRepository userRepo = UserRepository.instance
	
	def getUserSignIn(User loginCredentials){
		userRepo.login(loginCredentials)
	}
	
	def getUsers(){
		userRepo.allInstances
	}
}