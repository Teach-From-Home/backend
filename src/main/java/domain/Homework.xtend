package domain

import com.fasterxml.jackson.databind.annotation.JsonSerialize
import java.time.LocalDate
import java.util.HashSet
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.LocalDateSerializer

@Entity
@Accessors
class Homework {
	@Id
	@GeneratedValue
	Long id
	
	@Column
	String title
	
	@ManyToOne
	User teacher
	
	@Column(columnDefinition="TEXT")
	String description
	
	@Column
	boolean available
	
	@Column
	boolean uploaded = false
	
	@Column
	@JsonSerialize(using = LocalDateSerializer)
	LocalDate deadLine = LocalDate.now
	
	@OneToMany(fetch=FetchType.EAGER, cascade = CascadeType.ALL)
	Set<HomeworkDone> uploadedHomeworks = new HashSet<HomeworkDone>
	
	def changeState(){
		available = !available
	}
	
	def uploadHomework(HomeworkDone homeworkDoneToAdd){
		homeworkDoneToAdd.outOfTerm = LocalDate.now > deadLine
		uploadedHomeworks.add(homeworkDoneToAdd)
	}
	
	def removeHomework(HomeworkDone homeworkDoneToRemove){
		uploadedHomeworks.remove(homeworkDoneToRemove)
	}
	
	def isDoneByUser(User user){
		return uploadedHomeworks.exists[it.student == user]
	}
	
	def getIsOnTerm(){
		deadLine > LocalDate.now
	}
}

@Entity
@Accessors
class HomeworkDone{
	@Id @GeneratedValue
	Long id
	
	@Column
	Double grade
	
	@Column(columnDefinition="TEXT")
	String coment
	
	@Column
	@JsonSerialize(using = LocalDateSerializer)
	LocalDate uploadDate 
	
	@ManyToOne
	User student
	
	@Column
	String file
	
	@Column
	boolean outOfTerm
	
	override equals(Object obj) {
		try {
			val other = obj as HomeworkDone
			id == other?.id
		} catch (ClassCastException e) {
			return false
		}
	}
}
