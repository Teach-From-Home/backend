package services

import domain.ForumPost
import repository.ClassroomRepository
import repository.ForumPostRepository
import repository.UserRepository
import java.time.LocalDate
import domain.Responses

class ForumPostService {
	ForumPostRepository forumPostRepo = ForumPostRepository.getInstance
	UserRepository userRepo = UserRepository.getInstance
	ClassroomRepository classroomRepo = ClassroomRepository.getInstance
	
	def createPost(String IdClassroom, ForumPost post, String idUser){
		val userParent = userRepo.searchById(idUser)
		post.user = userParent
		val classroom = classroomRepo.searchById(IdClassroom)
		classroom.addPost(post)
		classroomRepo.update(classroom)
	}
	
	def uploadComment(String idPost, String idUser, Responses comment){
		val postParent = forumPostRepo.searchById(idPost)
		val userParent = userRepo.searchById(idUser)
		comment.user = userParent
		comment.date = LocalDate.now
		postParent.addComent(comment)
		forumPostRepo.update(postParent)
	}
	
	def getCommentsOfPost(String idPost) {
		val comments = forumPostRepo.searchById(idPost).responses.sortBy[date].reverseView.toList
		return comments
	}
}