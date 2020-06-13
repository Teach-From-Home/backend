package domain

import java.util.ArrayList
import java.util.List
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors

@Entity
@Accessors
class Teacher extends User{
	
	@OneToMany(fetch=FetchType.LAZY)
	List<Subject> subjects = new ArrayList<Subject>
	
	def addSubject(Subject subjectToAdd){
		subjects.add(subjectToAdd)
	}
	
	def removeSubject(Subject subjectToRemove){
		subjects.remove(subjectToRemove)
	}
}