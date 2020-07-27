package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.databind.annotation.JsonSerialize
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.HashSet
import java.util.List
import java.util.Set
import java.util.function.Function
import java.util.stream.Collectors
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
import repository.ExamsRepository
import serializers.LocalDateSerializer
import utils.Parsers
import utils.Role

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

	// esto va a mongo, poligloto! :D
	@JsonIgnore
	@ElementCollection(fetch=FetchType.EAGER)
	List<ObjectId> examsIds = newArrayList

	@JsonIgnore
	@OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	Set<Bibliography> bibliography = newHashSet

	@Transient
	List<Exam> exams

	@JsonIgnore
	@OneToMany(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	Set<AsistanceLog> asistances = newHashSet

	@Column
	boolean active = true

	@Column
	String name = ""

	@Column
	String keyName = ""

	@JsonIgnore
	@OneToOne(fetch=FetchType.EAGER, cascade=CascadeType.ALL)
	AsistanceLog asintaceLog

	@Column
	int numberOfLive = 0

	def getTeachers() {
		users.filter[user|Role.validateRole(Parsers.parsearDeLongAString(user.id), Role.teacher)].map[it.getFullName].
			toList
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

	def calendarEntries() {
		val active = homework.filter[it.available]
		val events = active.map[new CalendarEntry(it, this)].toList
		var exams = examsIds.map[ExamsRepository.getInstance.searchById(it)].toList
		events.addAll(exams.map[new CalendarEntry(it, this)].toList)

		events
	}

	def allStudents() {
		users.filter[it.role == Role.student]
	}

	def reset() {
		homework.forEach[it.clearUploadedHomeworks it.disable]
		exams.forEach[it.clearUploadedExams it.disable]
		removeStudents()
	}

	def removeStudents() {
		users.removeIf[it.role != Role.teacher]
	}

	def addBibliography(Bibliography newBilbio) {
		bibliography.add(newBilbio)
	}

	def removeBibliography(Bibliography bilbio) {
		bibliography.remove(bilbio)
	}

	def removeBibliography(String bilbioid) {
		bibliography.removeIf[it.id.toString == bilbioid]
	}

	def getLive() {
		if (asintaceLog === null)
			return false
		asintaceLog.hoursUntilNow < 6
	}

	def goLive(User user) {
		if (!getLive) {
			asintaceLog = new AsistanceLog(user)
			numberOfLive++
		}
	}

	def checkIn(User user) {
		if (!asistances.exists[it.userInClass == user && it.isFromToday] && getLive)
			asistances.add(new AsistanceLog(user))
	}

	def asistanceReport() {
		val List<ReportLog> listOfReports = newArrayList
		val usersCount = students
		usersCount.addAll(asistances.map[it.userInClass])
		val asd = usersCount.stream().collect(Collectors.groupingBy(Function.identity(), Collectors.counting()));
		asd.forEach[k, v|listOfReports.add(new ReportLog(numberOfLive, v, k))]
		return listOfReports
	}

	def homeworksReport() {
		val List<ReportLog> listOfReports = newArrayList
		val List<User> uploads = students
		activeHomeworks.forEach[uploads.addAll(it.usersThatUpload)]
		var asd = uploads.stream().collect(Collectors.groupingBy(Function.identity(), Collectors.counting()));
		asd.forEach [ k, v |
			listOfReports.add(new ReportLog(activeHomeworks.size, v, k))
		]
		return listOfReports
	}

	def examsReport() {
		val List<ReportLog> listOfReports = newArrayList
		val List<User> uploads = students
		activeExams.forEach[uploads.addAll(it.usersThatUpload)]
		var asd = uploads.stream().collect(Collectors.groupingBy([user|user], Collectors.counting()));
		asd.forEach [ k, v |
			listOfReports.add(new ReportLog(activeExams.size, v, k))
		]
		return listOfReports
	}

	def examsGradeReport() {
		val List<ReportLogGrade> listOfReports = newArrayList
		val List<UserInReport> test = newArrayList
		activeExams.forEach[test.addAll(it.usersThatUploadWithGrade)]
		test.addAll(students.map[new UserInReport(it.name, it.lastname, it.id, 0)])
		var asd = test.stream().collect(Collectors.groupingBy(Function.identity(), Collectors.summarizingDouble([ a |
			grade(a)
		])))

		asd.forEach [ k, v |
			listOfReports.add(new ReportLogGrade(activeExams.size, v.sum, k))
		]
		return listOfReports
	}
	
	def hwGradeReport() {
		val List<ReportLogGrade> listOfReports = newArrayList
		val List<UserInReport> test = newArrayList
		activeHomeworks.forEach[test.addAll(it.usersThatUploadWithGrade)]
		test.addAll(students.map[new UserInReport(it.name, it.lastname, it.id, 0)])
		var asd = test.stream().collect(Collectors.groupingBy(Function.identity(), Collectors.summarizingDouble([ a |
			grade(a)
		])))

		asd.forEach [ k, v |
			listOfReports.add(new ReportLogGrade(activeHomeworks.size, v.sum, k))
		]
		return listOfReports
	}
	
	def totalGradeReport() {
		val List<ReportLogGrade> listOfReports = newArrayList
		val List<UserInReport> test = newArrayList
		activeHomeworks.forEach[test.addAll(it.usersThatUploadWithGrade)]
		activeExams.forEach[test.addAll(it.usersThatUploadWithGrade)]
		test.addAll(students.map[new UserInReport(it.name, it.lastname, it.id, 0)])
		var asd = test.stream().collect(Collectors.groupingBy(Function.identity(), Collectors.summarizingDouble([ a |
			grade(a)
		])))

		asd.forEach [ k, v |
			listOfReports.add(new ReportLogGrade(activeExams.size + activeHomeworks.size, v.sum, k))
		]
		return listOfReports
	}

	def grade(UserInReport report) {
		return report.getGrade()
	}

	def activeHomeworks() {
		homework.filter[it.available].toList
	}

	def activeExams() {
		exams = examsIds.map[ExamsRepository.getInstance.searchById(it)].toList
		exams.filter[it.available].toList
	}

	def students() {
		users.filter[it.role == Role.student].toList
	}

}

@Accessors
class CalendarEntry {
	@JsonSerialize(using=LocalDateSerializer)
	LocalDate deadLine
	String title
	String classroomName
	String subjectName
	String start
	long classroomId
	boolean allDay = true
	String type

	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("YYYY-MM-dd");

	new(Homework hw, Classroom classroom) {
		deadLine = hw.deadLine
		title = hw.title
		classroomName = classroom.name
		subjectName = classroom.subject.name
		start = formatter.format(hw.deadLine)
		classroomId = classroom.id
		type = "HW"
	}

	new(Exam hw, Classroom classroom) {
		deadLine = hw.deadLine
		title = hw.title
		classroomName = classroom.name
		subjectName = classroom.subject.name
		start = formatter.format(hw.deadLine)
		classroomId = classroom.id
		type = "EX"
	}
}

@Accessors
class ReportLog {
	String name
	String lastName
	int total
	Long parcial
	double percentage

	new(int t, Long p, User u) {
		total = t
		parcial = p - 1 // le resto uno por que genero un registro con cada user para que esten todos en el reporte
		if (total > 0)
			percentage = (parcial * 100) / total
		else
			percentage = 0
		name = u.name
		lastName = u.lastname
	}
}

@Accessors
class ReportLogGrade {
	String name
	String lastName
	int total
	double parcial
	double percentage

	new(int t, double p, UserInReport u) {
		total = t
		
		if (total > 0){
			parcial = p / t
			percentage = (parcial * 10) 
		}
		else
			percentage = 0
			
		name = u.name
		lastName = u.lastname
	}
}

@Accessors
class UserInReport {
	Long id
	String name
	String lastname
	double grade

	new(String na, String lastn, Long i, double gr) {
		name = na
		lastname = lastn
		grade = gr
		id = i
	}

	override equals(Object obj) {
		try {
			val other = obj as UserInReport
			id == other?.id
		} catch (ClassCastException e) {
			return false
		}
	}

	override hashCode() {
		if(id !== null) id.hashCode else super.hashCode
	}
}
