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
	List<SolvedExam> uploadedExams
	boolean uploaded
	
	def setCorrections(double grade, String userId, String comment){ 
		val exam = studentExam(userId)
		exam.setGrade(grade)
		exam.setTeacherComment(comment)
	}
	
	def solvedExams(){
		val examsSolved = uploadedExams.filter[it.getExamIsDone()].toList
		examsSolved.forEach[it.solvedOnTime = it.getExpendedMinutesToSolve<minutes]
		examsSolved
	}
	
	def studentExam(String id){
		uploadedExams.findFirst[it.studentId == id]
	}
	
	def setIsUploadedBy(String id){
		val exam = studentExam(id)
		uploaded = exam.getExamIsDone
	}
	
	def filterUploadedExams(String id){
		uploadedExams = uploadedExams.filter[it == studentExam(id)].toList
	}
	
	def uploadExam(SolvedExam newExam){
		uploadedExams.add(newExam)
	}
}

@Accessors
class SolvedExam {
	String studentId
	@JsonIgnore LocalDateTime startDate
	@JsonIgnore LocalDateTime finishDate
	double grade
	String teacherComment
	List<Question> answers = newArrayList
	boolean solvedOnTime

	def getExamIsDone() {
		startDate !== null && finishDate !== null
	}

	def getExamIsInprogress() {
		startDate !== null && finishDate === null
	}

	def getExpendedMinutesToSolve() {
		startDate.until(finishDate, ChronoUnit.MINUTES);
	}
}
