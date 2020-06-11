package App

import org.uqbar.xtrest.api.XTRest
import Repository.UserRepository
import domain.User

class TfmBootstrap {
	def static void main(String[] args) {
		
		val userRepo  = new UserRepository
		
		val user = new User => [
			name = "pepe"
	
			lastname = "tini"
	
			email = "agustinmariotini@gmail.com"
			
			dni = 38992539
		]
		
		userRepo.createOrUpdate(user)
		
		XTRest.startInstance(16000, new TfmRestAPI(userRepo))
	}
}