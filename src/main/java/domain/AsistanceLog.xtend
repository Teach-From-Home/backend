package domain

import java.time.LocalDateTime
import java.time.temporal.ChronoUnit
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
@Entity
class AsistanceLog {
	@Id @GeneratedValue
	Long id
	@ManyToOne
	User userInClass
	@Column
	LocalDateTime inDate = LocalDateTime.now

	new(){}
	
	new(User u) {
		userInClass = u
	}

	def hoursUntilNow() {
		inDate.until(LocalDateTime.now, ChronoUnit.HOURS)
	}
	
	def isFromToday(){
		inDate.until(LocalDateTime.now, ChronoUnit.HOURS) < 6
	}
}
