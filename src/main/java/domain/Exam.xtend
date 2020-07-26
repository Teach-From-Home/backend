package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.databind.annotation.JsonDeserialize
import com.fasterxml.jackson.databind.annotation.JsonSerialize
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.temporal.ChronoUnit
import java.util.List
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Embedded
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.mongodb.morphia.annotations.Transient
import serializers.LocalDateDeserializer
import serializers.LocalDateSerializer
import serializers.ObjectIdSerializer

@Entity(value="Exams", noClassnameStored=false)
@Accessors
class Exam {
	@JsonSerialize(using=ObjectIdSerializer)
	@Id ObjectId id
	String title
	String description
	@JsonSerialize(using=LocalDateSerializer)
	@JsonDeserialize(using=LocalDateDeserializer)
	LocalDate deadLine
	boolean available
	@Embedded
	List<Question> questions = newArrayList
	int minutes
	@Embedded
	@JsonIgnore List<SolvedExam> uploadedExams = newArrayList
	@Transient boolean uploaded = false
	@Transient SolvedExam uploadedExam

	def setCorrections(double grade, String userId, String comment) {
		val exam = studentExam(userId)
		exam.setGrade(grade)
		exam.setTeacherComment(comment)
	}

	def solvedExams() {
		val examsSolved = uploadedExams.filter[it.getExamIsDone()].toList
		examsSolved.forEach[it.solvedOnTime = it.getElapsedTimeToSolve < minutes]
		examsSolved
	}

	def studentExam(String id) {
		uploadedExams.findFirst[it.studentId == id]
	}

	def setUploadedExam(String id) {
		if (examIsUploaded(id)) {
			uploadedExam = studentExam(id)
			uploaded = true
			if(uploadedExam.examIsDone)
				uploadedExam.solvedOnTime = uploadedExam.getElapsedTimeToSolve < minutes
		}
	}

	def examIsUploaded(String id) {
		uploadedExams.exists[it.studentId.equalsIgnoreCase(id)]
	}

	def uploadExam(SolvedExam newExam) {
		uploadedExams.add(newExam)
	}
	
	def uploadQuestions(String id, List<Question> answers){
		val exam = studentExam(id)
		exam.setAnswers(answers)
		exam.finishDate = LocalDateTime.now
	}
	
	def clearUploadedExams() {
		uploadedExams.clear
	}
	
	def disable() {
		available = false
	}
	
	def usersThatUpload(){
		uploadedExams.map[new User(it.name, it.lastname)]
	}
	
}

@Accessors
class SolvedExam {
	String studentId
	String name
	String lastname
	@JsonIgnore LocalDateTime startDate
	@JsonIgnore LocalDateTime finishDate
	double grade
	String teacherComment
	List<Question> answers = newArrayList
	@Transient boolean solvedOnTime
	
	new(){}
	
	new(User student){
		startDate = LocalDateTime.now
		studentId = student.id.toString
		name = student.name
		lastname = student.lastname
		
	}

	def getExamIsDone() {
		startDate !== null && finishDate !== null
	}

	def getExamIsInprogress() {
		startDate !== null && finishDate === null
	}

	def getElapsedTimeToSolve() {
		if(getExamIsDone)
			startDate.until(finishDate, ChronoUnit.MINUTES);
	}
}
