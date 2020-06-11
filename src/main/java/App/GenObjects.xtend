package App

import Repository.UserRepository
import domain.Student

class GenObjects {
	def static generateAll(){
		val userRepo  = new UserRepository
		
		//User Data definition
		
		val estudiante = new Student => [
			name = "pepe"
	
			lastname = "tini"
	
			email = "agustinmariotini@gmail.com"
			
			dni = 38992539
		]
		
		//User repo create
		
		userRepo.createOrUpdate(estudiante)
		
		
	}
}