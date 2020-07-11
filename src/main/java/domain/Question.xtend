package domain

import com.fasterxml.jackson.annotation.JsonSubTypes
import com.fasterxml.jackson.annotation.JsonTypeInfo
import com.fasterxml.jackson.annotation.JsonTypeName
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

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
