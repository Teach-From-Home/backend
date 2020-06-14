package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.util.ArrayList
import java.util.List
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToMany
import javax.persistence.OneToMany
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.HashSet
import java.util.Set
import javax.persistence.JoinColumn

@Entity
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
	@JoinColumn(name="classroomId")
	@JsonIgnore
	List<Homework> homework = new ArrayList<Homework>
	
	//not using cascade classroom should not change any users
	@ManyToMany(fetch=FetchType.LAZY)
	@JsonIgnore
	Set<User> users = new HashSet<User>
	
	@OneToMany(fetch=FetchType.LAZY, cascade = CascadeType.ALL)
	@JsonIgnore
	List<Post> posts = new ArrayList<Post>
	
	@Column
	boolean active = true
	
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