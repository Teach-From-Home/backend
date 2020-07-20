package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.databind.annotation.JsonSerialize
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.HashSet
import java.util.List
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.ElementCollection
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.JoinColumn
import javax.persistence.ManyToMany
import javax.persistence.OneToMany
import javax.persistence.OneToOne
import javax.persistence.Transient
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.LocalDateSerializer
import utils.Parsers
import utils.Role
import repository.ExamsRepository

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

	@OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	@JoinColumn(name="classroomId")
	@JsonIgnore
	Set<Homework> homework = new HashSet<Homework>

	@ManyToMany(fetch=FetchType.EAGER)
	@JsonIgnore
	Set<User> users = new HashSet<User>

	@OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	@JsonIgnore
	Set<ForumPost> posts = new HashSet<ForumPost>
	
	//esto va a mongo, poligloto! :D
	@JsonIgnore
	@ElementCollection(fetch=FetchType.EAGER)
	List<ObjectId>examsIds = newArrayList
	
	@JsonIgnore
	@OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	Set<Bibliography>bibliography = newHashSet
		
	@Transient
	List<Exam>exams

	@Column
	boolean active = true
	
	@Column
	String name = ""
	
	@Column
	String keyName = ""
	
	@Column
	boolean live = false
	
	def getTeachers(){
		users.filter[user |Role.validateRole(Parsers.parsearDeLongAString(user.id), Role.teacher)].map[it.getFullName].toList
	}
	
	def addUser(User userToAdd) {
		users.add(userToAdd)
	}

	def removeUser(User userToRemove) {
		users.remove(userToRemove)
	}

	def addHomeWork(Homework homeWorkToAdd) {
		homework.add(homeWorkToAdd)
	}

	def removeHomeWork(Homework homeWorkToRemove) {
		homework.remove(homeWorkToRemove)
	}

	def addPost(ForumPost postToAdd) {
		posts.add(postToAdd)
	}

	def removePost(ForumPost postToRemove) {
		posts.remove(postToRemove)
	}
	
	def calendarEntries(){
		val active = homework.filter[it.available]
		val events = active.map[new CalendarEntry(it,this)].toList
		var activeEx = examsIds.map[ExamsRepository.getInstance.searchById(it)].toList
		activeEx = activeEx.filter[it.available].toList
		events.addAll(activeEx.map[new CalendarEntry(it,this)].toList)
		
		events
	}
	
	def allStudents(){
		users.filter[it.role == Role.student]
	}
	
	def reset(){
		homework.forEach[it.clearUploadedHomeworks it.disable]
		removeStudents()
	}
	
	def removeStudents(){
		users.removeIf[it.role != Role.teacher ]
	}
	
	def addBibliography(Bibliography newBilbio){
		bibliography.add(newBilbio)
	}
	
	def removeBibliography(Bibliography bilbio){
		bibliography.remove(bilbio)
	}
	
	def removeBibliography(String bilbioid){
		bibliography.removeIf[it.id.toString == bilbioid]
	}
	
}

@Accessors
class CalendarEntry{
	@JsonSerialize(using = LocalDateSerializer)
	LocalDate deadLine
	String title
	String classroomName
	String subjectName
	String start
	long classroomId
	boolean allDay = true
	String type
	
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("YYYY-MM-dd");
	
	new(Homework hw,Classroom classroom){
		deadLine = hw.deadLine
		title = hw.title
		classroomName = classroom.name
		subjectName = classroom.subject.name
		start = formatter.format(hw.deadLine)
		classroomId = classroom.id
		type = "HW"
	}
	
	new(Exam hw,Classroom classroom){
		deadLine = hw.deadLine
		title = hw.title
		classroomName = classroom.name
		subjectName = classroom.subject.name
		start = formatter.format(hw.deadLine)
		classroomId = classroom.id
		type = "EX"
	}
}




