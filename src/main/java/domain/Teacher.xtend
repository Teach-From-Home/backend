package domain

import java.util.List
import java.util.ArrayList
import javax.persistence.OneToMany
import javax.persistence.FetchType
import javax.persistence.CascadeType

class Teacher extends User{
	
	@OneToMany(fetch=FetchType.LAZY, cascade = CascadeType.ALL)
	List<Subject> subjects = new ArrayList<Subject>
	
	def addSubject(Subject subjectToAdd){
		subjects.add(subjectToAdd)
	}
	
	def removeSubject(Subject subjectToRemove){
		subjects.remove(subjectToRemove)
	}
}