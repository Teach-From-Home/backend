package domain

import java.util.ArrayList
import java.util.List
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToMany
import org.eclipse.xtend.lib.annotations.Accessors

@Entity
@Accessors
class User{
	
	@Id
	@GeneratedValue
	Long id
	
	@Column
	boolean active = true
	
	@Column
	String name
	
	@Column
	String lastname
	
	@Column
	String email
	
	@Column
	int dni
	
	@Column
	String password
	
	@Column
	String role
	
	@ManyToMany(fetch=FetchType.EAGER)
	List<Subject> subjects = new ArrayList<Subject>
	
	def addSubject(Subject subjectToAdd){
		subjects.add(subjectToAdd)
	}
	
	def removeSubject(Subject subjectToRemove){
		subjects.remove(subjectToRemove)
	}
}