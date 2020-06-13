package domain

import java.time.LocalDate
import java.util.ArrayList
import java.util.List
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToMany
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import com.fasterxml.jackson.annotation.JsonIgnore

@Entity
@Accessors
class Homework {
	@Id
	@GeneratedValue
	Long id
	
	@Column(columnDefinition="TEXT")
	String description
	
	@Column
	boolean available
	
	
	LocalDate date
	
	@Column
	@OneToMany(fetch=FetchType.LAZY, cascade = CascadeType.ALL)
	@JsonIgnore
	List<HomeworkDone> uploadedHomeworks = new ArrayList<HomeworkDone>
	
	def changeState(){
		available = !available
	}
	
	def uploadHomework(HomeworkDone homeworkDoneToAdd){
		uploadedHomeworks.add(homeworkDoneToAdd)
	}
	
}

@Entity
@Accessors
class HomeworkDone{
	@Id
	@GeneratedValue
	Long id
	
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
	
	@Column
	LocalDate uploadDate
}
