package services

import domain.ForumPost
import repository.ClassroomRepository
import repository.ForumPostRepository

class ForumPostService {
	ForumPostRepository forumPostRepo = ForumPostRepository.getInstance
	//UserRepository userRepo = UserRepository.getInstance
	ClassroomRepository classroomRepo = ClassroomRepository.getInstance
	
	def createPost(String IdClassroom, ForumPost post){
		val classroom = classroomRepo.searchById(IdClassroom)
		classroom.addPost(post)
		classroomRepo.update(classroom)
	}
	
	def uploadComment(String idPost, String idUser, ForumPost comment){
		val postParent = forumPostRepo.searchById(idPost)
		postParent.addComent(comment)
		forumPostRepo.update(postParent)
	}
	
	def getCommentsOfPost(String idPost) {
		val asd = forumPostRepo.searchById(idPost).responses.toList
		println(asd)
		return asd
	}
}