package services

import domain.ForumPost
import repository.UserRepository
import repository.ClassroomRepository
import repository.ForumPostRepository

class ForumPostService {
	ForumPostRepository forumPostRepository = ForumPostRepository.getInstance
	//UserRepository userRepo = UserRepository.getInstance
	ClassroomRepository classroomRepo = ClassroomRepository.getInstance
	
	def createPost(String IdClassroom, ForumPost post){
		val classroom = classroomRepo.searchById(IdClassroom)
		classroom.addPost(post)
		classroomRepo.update(classroom)
	}
	
	def uploadComment(String idPost, String idUser, ForumPost comment){
		
	}
	
	def getCommentsOfPost(String idPost) {
		val asd = forumPostRepository.searchById(idPost).responses.toList
		println(asd)
		return asd
	}
}