package domain

import java.util.ArrayList
import java.util.List
import javax.persistence.OneToMany
import javax.persistence.ManyToMany
import javax.persistence.GenerationType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.Column
import javax.persistence.CascadeType
import javax.persistence.FetchType

class Classroom {
	
	@OneToMany(fetch=FetchType.LAZY, cascade = CascadeType.ALL)
	List<Homework> homework = new ArrayList<Homework>
	
	@ManyToMany(fetch=FetchType.LAZY, cascade = CascadeType.ALL)
	List<User> users = new ArrayList<User>
	
	@OneToMany(fetch=FetchType.LAZY, cascade = CascadeType.ALL)
	List<Post> posts = new ArrayList<Post>
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	Long id
	
	@Column
	Subject subject
	
	def addUser(User userToAdd){
		users.add(userToAdd)
	}
	
	def removeUser(User userToRemove){
		users.remove(userToRemove)
	}
	
	def addHomeWork(Homework homeWorkToAdd){
		homework.add(homeWorkToAdd)
	}
	
	def removeHomeWork(Homework homeWorkToRemove){
		homework.remove(homeWorkToRemove)
	}
	
	def addPost(Post postToAdd){
		posts.add(postToAdd)
	}
	
	def removePost(Post postToRemove){
		posts.remove(postToRemove)
	}
}