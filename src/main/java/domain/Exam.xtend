package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonSubTypes
import com.fasterxml.jackson.annotation.JsonTypeInfo
import com.fasterxml.jackson.annotation.JsonTypeName
import com.fasterxml.jackson.databind.annotation.JsonSerialize
import java.time.LocalDateTime
import java.util.List
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Embedded
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import serializers.ObjectIdSerializer
import serializers.LocalDateTimeSerializer

@Entity(value="Exams", noClassnameStored=false)
@Accessors
class Exam {
	@JsonSerialize(using = ObjectIdSerializer)
	@Id ObjectId id
	String title
	String description
	@JsonIgnore LocalDateTime startDate
	@JsonIgnore LocalDateTime finishDate
	@JsonSerialize(using = LocalDateTimeSerializer)
	LocalDateTime deadLine
	boolean available
	@Embedded
	List<Question> questions = newArrayList
	int minutes

}

@JsonTypeInfo(use=JsonTypeInfo.Id.NAME, include=JsonTypeInfo.As.PROPERTY, property = "type")
@JsonSubTypes(@JsonSubTypes.Type(value = ChoiseQuestion, name = "choice"),
       	 @JsonSubTypes.Type(value = WriteQuestion, name = "write"))
@Accessors
abstract class Question {
	String title

	def String getAnswer()
}

@JsonTypeName("choice")
@Accessors
class ChoiseQuestion extends Question {
	List<Options> options = newArrayList

	override getAnswer() {
		"La respuesta correcta es: " + correctAnswer.question
	}

	def correctAnswer() {
		options.findFirst[it.selected]
	}

}

@Accessors
class Options {
	boolean selected
	String question
}

@JsonTypeName("write")
@Accessors
class WriteQuestion extends Question {
	String answer

	override getAnswer() {
		"La respuesta correcta es: " + answer
	}

}
