package domain

import java.time.LocalDate
import java.time.temporal.ChronoUnit
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToOne
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import utils.BadCredentialsException

@Entity
@Accessors
class SessionToken {
	@Id @GeneratedValue
	Long id
	
	@OneToOne
	User user
	
	@Column
	LocalDate creationDate
	
	@Column
	ObjectId token = new ObjectId
	
	def getToken(){
		token.toString
	}
	
	def validate(){
		val diference = ChronoUnit.DAYS.between(creationDate, LocalDate.now)
		if(diference >= 1)
			throw new BadCredentialsException("sesion Invalida")
	}
}