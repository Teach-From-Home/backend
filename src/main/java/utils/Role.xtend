package utils

import org.eclipse.xtend.lib.annotations.Accessors
import repository.UserRepository

@Accessors
class Role {
	static String admin = "ADMIN"
	static String teacher = "TEACHER"
	static String alumn = "ALUMN"

	static def validateRole(String userId, String role) {
		UserRepository.instance.getUserById(Long.parseLong(userId)).role == role
	}
}
