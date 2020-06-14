package domain

import com.fasterxml.jackson.annotation.JsonIgnore
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
	
	@Column
	LocalDate date
	
	@Column
 	Long classroomId;
 	
 	//student edit only file_link and send the new homework to the homeworkDone list
	@Column
	Long studentId
	
	@Column
	String file
	
	//teacher edit grade and coment on the selected homework on homeworkDone
	@Column
	double grade
	
	@Column
	String coment
	
	@Column
	LocalDate uploadDate
	
	@OneToMany(fetch=FetchType.EAGER, cascade = CascadeType.ALL)
	@JsonIgnore
	List<Homework> uploadedHomeworks = new ArrayList<Homework>
	
	def changeState(){
		available = !available
	}
	
	def uploadHomework(Homework homeworkDoneToAdd){
		uploadedHomeworks.add(homeworkDoneToAdd)
	}
	
	def hasThisHomeworkDone(Long userId){
		if(uploadedHomeworks !== null){
			uploadedHomeworks.exists(homework | homework.studentId == userId)//  exists(homework|homework.studentId == userId)
		}else{
			false
		}
	}
	
	def getHomeworkDone(Long userId){
		uploadedHomeworks.findFirst[homework | homework.studentId == userId]
	}
}
