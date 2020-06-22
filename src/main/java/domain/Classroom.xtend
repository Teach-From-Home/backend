package domain

import com.fasterxml.jackson.annotation.JsonIgnore
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
import javax.persistence.JoinColumn
import javax.persistence.ManyToMany
import javax.persistence.OneToMany
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.LocalDateSerializer
import utils.Role
import utils.Parsers

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
		active.map[new CalendarEntry(it.deadLine, it.title, this.name ,subject.name)].toList
	}
	
	def allStudents(){
		users.filter[it.role == Role.student]
	}
}

@Accessors
class CalendarEntry{
	@JsonSerialize(using = LocalDateSerializer)
	LocalDate deadLine
	String title
	String classroomName
	String subjectName
	
	new(LocalDate _deadLine, String _title, String _subjectName, String _classroomName){
		deadLine = _deadLine
		title = _title
		classroomName = _subjectName
		subjectName = _classroomName
	}
}
