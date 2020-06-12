package domain

import java.time.LocalDate
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Column
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import org.uqbar.commons.model.annotations.Observable
import java.util.ArrayList
import java.util.List
import javax.persistence.OneToMany
import javax.persistence.OneToOne
import javax.persistence.FetchType
import javax.persistence.CascadeType
import javax.persistence.Inheritance
import javax.persistence.InheritanceType

@Entity
@Observable
@Accessors
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
class Homework {
	@Id
	@GeneratedValue
	Long id
	
	@Column(columnDefinition="TEXT")
	String description
	
	@Column
	boolean available
	
	@Column
	LocalDate date
	
	def changeState(){
		available = !available
	}
	
	@OneToMany(fetch=FetchType.LAZY, cascade = CascadeType.ALL)
	List<HomeworkDone> homeworkDone = new ArrayList<HomeworkDone>
	
	def addHomeworkDone(HomeworkDone homeworkDoneToAdd){
		homeworkDone.add(homeworkDoneToAdd)
	}
	
}

@Entity
@Observable
@Accessors
class HomeworkDone extends Homework{
	//student edit only file_link and send the new homework to the homeworkDone list
	
	@OneToOne
	Student student
	
	@Column
	String file
	
	//teacher edit grade and coment on the selected homework on homeworkDone
	
	@Column
	double grade
	
	@Column
	String coment
}