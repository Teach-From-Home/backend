package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.util.ArrayList
import java.util.HashSet
import java.util.List
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.JoinColumn
import javax.persistence.ManyToMany
import javax.persistence.OneToMany
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors

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
	
	//le tuve que sacar el jsonignore para poder meter una tarea
	@OneToMany(fetch=FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinColumn(name="classroomId") @JsonIgnore
	List<Homework> homework = new ArrayList<Homework>
	
	//not using cascade classroom should not change any users
	@ManyToMany(fetch=FetchType.EAGER)
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