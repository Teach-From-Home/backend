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
		post.date = LocalDate.now
		post.user = userParent
		post.available = true
		val classroom = classroomRepo.searchById(IdClassroom)
		classroom.addPost(post)
		classroomRepo.update(classroom)
	}
	
	def updatePost(String idPost, ForumPost post){
		val postParent = forumPostRepo.searchById(idPost)
		postParent.title = post.title
		postParent.text = post.text
		forumPostRepo.update(postParent)
	}
	
	def deletePost(String idPost){
		val postParent = forumPostRepo.searchById(idPost)
		postParent.available = false
		forumPostRepo.update(postParent)
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