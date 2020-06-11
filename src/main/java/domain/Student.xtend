package domain

import java.util.ArrayList
import java.util.List
import javax.persistence.ManyToMany
import javax.persistence.FetchType
import javax.persistence.CascadeType
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import org.uqbar.commons.model.annotations.Observable

@Entity
@Observable
@Accessors
class Student extends User{
	
	@ManyToMany(fetch=FetchType.LAZY, cascade = CascadeType.ALL)
	List<Homework> homework = new ArrayList<Homework>
	
	def addHomework(Homework homeworkToAdd){
		homework.add(homeworkToAdd)
	}
	
	def removeHomework(Homework homeworkToRemove){
		homework.remove(homeworkToRemove)
	}
}