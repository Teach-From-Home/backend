package domain

import java.time.LocalDate
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Column

class Homework {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	Long id
	
	@Column
	boolean available
	
	@Column
	LocalDate date
	
	@Column
	String file_link
	
	@Column
	double grade
	
	@Column
	String coment
	
	def changeState(){
		available = !available
	}
}