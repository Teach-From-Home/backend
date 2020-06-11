package domain

import java.time.LocalDate
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Column
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import org.uqbar.commons.model.annotations.Observable
import java.util.ArrayList
import java.util.List
import javax.persistence.OneToMany

@Entity
@Observable
@Accessors
class Homework {
	
	@Id
	@GeneratedValue
	Long id
	
	@Column
	String description
	
	@Column
	boolean available
	
	@Column
	LocalDate date
	
	//student edit only file_link and send the new homework to the homeworkDone list
	
	@Column
	String file_link
	
	//teacher edit grade and coment on the selected homework on homeworkDone
	
	@Column
	double grade
	
	@Column
	String coment
	
	def changeState(){
		available = !available
	}
	
	@OneToMany
	List<Homework> homeworkDone = new ArrayList<Homework>
	
	
}