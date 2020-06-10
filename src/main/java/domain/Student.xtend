package domain

import java.util.ArrayList
import java.util.List
import javax.persistence.ManyToMany
import javax.persistence.FetchType
import javax.persistence.CascadeType

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