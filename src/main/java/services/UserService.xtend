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
	
	
	def getUserById(String id){
		userRepo.searchById(id)
	}
	
	def editUser(User user, String id){
		val userg = getUserById(id)
		userg.name = user.name
		userg.lastname = user.lastname
		userg.email = user.email
		userg.dni = user.dni
		userg.password = user.password
		userRepo.update(userg)
	}
	
	def deleteUser(String id){
		val deleted = getUserById(id)
		deleted.active = false
		userRepo.update(deleted)
	}
	
	def createUser(User user){
		userRepo.create(user)
	}
}