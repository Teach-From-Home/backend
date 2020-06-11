package App

import Repository.UserRepository
import org.uqbar.xtrest.api.annotation.Controller

@Controller
class TfmRestAPI {
	UserRepository userRepo
	
	new(UserRepository userR) {
		userRepo = userR

	}

}

