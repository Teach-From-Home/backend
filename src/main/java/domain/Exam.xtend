package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import java.time.LocalDateTime
import java.util.List
import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import utils.QuestionType

@Entity
@Accessors
class Exam {
	String title
	String description
	@JsonIgnore LocalDateTime startDate
	@JsonIgnore LocalDateTime finishDate
	LocalDateTime deadLine
	boolean available
	List<Question> questions = newArrayList
	int minutes

}
@Accessors
abstract class Question {
	String type
	String title

	def String getAnswer()
}

@Accessors
class ChoiseQuestion extends Question {
	List<SingleQuestion> questions = newArrayList
	
	new(){
		super.type = QuestionType.choice
	}
	override getAnswer() {
		"La respuesta correcta es: " + correctAnswer.question
	}
	def correctAnswer(){
		questions.findFirst[it.isValid]
	}

}

@Accessors
class SingleQuestion {
	boolean isValid
	String question
}

@Accessors
class WriteQuestion extends Question {
	String answer
	new(){
		super.type = QuestionType.write
	}
	override getAnswer() {
		"La respuesta correcta es: " + answer
	}

}
