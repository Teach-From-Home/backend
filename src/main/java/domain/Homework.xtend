package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.databind.annotation.JsonSerialize
import java.time.LocalDate
import java.util.ArrayList
import java.util.List
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
	
	@Column(columnDefinition="TEXT")
	String description
	
	@Column
	boolean available
	
	@Column
	@JsonSerialize(using = LocalDateSerializer)
	LocalDate deadLine
	
	@OneToMany(fetch=FetchType.EAGER, cascade = CascadeType.ALL)
	@JsonIgnore
	List<HomeworkDone> uploadedHomeworks = new ArrayList<HomeworkDone>
	
	def changeState(){
		available = !available
	}
	
	def uploadHomework(HomeworkDone homeworkDoneToAdd){
		uploadedHomeworks.add(homeworkDoneToAdd)
	}
	
	def isDoneByUser(User user){
		uploadedHomeworks.exists[it.student == user]
	}
	
}

@Entity
@Accessors
class HomeworkDone{
	@Id @GeneratedValue
	Long id
		
	@Column
	double grade
	
	@Column(columnDefinition="TEXT")
	String coment
	
	@Column
	@JsonSerialize(using = LocalDateSerializer)
	LocalDate uploadDate = LocalDate.now
	
	@ManyToOne
	User student
		
	@Column
	String file
}
