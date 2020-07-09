package domain

import java.util.List
import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import utils.QuestionType

@Entity
@Accessors
class Exam {
	String title
	String description

	List<Question> questions = newArrayList

}
@Accessors
abstract class Question {
	String type
	String title

	def String getAnswer()
}

@Accessors
class ChoiseQuestion extends Question {
	String title
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
