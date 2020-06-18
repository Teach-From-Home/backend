package utils

import org.eclipse.xtend.lib.annotations.Accessors
import repository.UserRepository

@Accessors
class Role {
	public static String admin = "ADMIN"
	public static String teacher = "TEACHER"
	public static String student = "STUDENT"
	

	static def validateRole(String userId, String role) {
		UserRepository.instance.searchById(userId).role == role
	}
}
