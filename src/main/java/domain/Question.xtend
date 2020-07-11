package domain

import com.fasterxml.jackson.annotation.JsonSubTypes
import com.fasterxml.jackson.annotation.JsonTypeInfo
import com.fasterxml.jackson.annotation.JsonTypeName
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@JsonTypeInfo(use=JsonTypeInfo.Id.NAME, include=JsonTypeInfo.As.PROPERTY, property="type")
@JsonSubTypes(@JsonSubTypes.Type(value = ChoiseQuestion, name = "choice"),
       	 @JsonSubTypes.Type(value = WriteQuestion, name = "write"))
@Accessors
abstract class Question {
	String title
	String validAnswer

	def String getAnswer()
	
	def void setAnswer() 
}

@JsonTypeName("choice")
@Accessors
class ChoiseQuestion extends Question {
	List<Options> options = newArrayList

	override setAnswer() {
		validAnswer = "La respuesta correcta es: " + selectedOption.question
	}

	def selectedOption() {
		options.findFirst[it.selected]
	}

	override getAnswer() {
		"La respuesta es: " + selectedOption.question
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
	
	override setAnswer() {
		validAnswer = "La respuesta correcta es: " + answer
	}

	override getAnswer() {
		"La respuesta es: " + answer
	}

}
