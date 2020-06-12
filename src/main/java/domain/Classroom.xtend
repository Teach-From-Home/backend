package domain

import java.util.ArrayList
import java.util.List
import javax.persistence.CascadeType
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToMany
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import org.uqbar.commons.model.annotations.Observable
import javax.persistence.OneToOne
import javax.persistence.Column

@Entity
@Observable
@Accessors
class Classroom {
	
	@Id
	@GeneratedValue
	Long id
	
	@Column(columnDefinition="TEXT")
	String description
	
	@OneToOne
	Subject subject
	
	@OneToMany(fetch=FetchType.LAZY, cascade = CascadeType.ALL)
	List<Homework> homework = new ArrayList<Homework>
	
	@ManyToMany(fetch=FetchType.LAZY, cascade = CascadeType.ALL)
	List<User> users = new ArrayList<User>
	
	@OneToMany(fetch=FetchType.LAZY, cascade = CascadeType.ALL)
	List<Post> posts = new ArrayList<Post>
	
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