package domain

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.databind.annotation.JsonSerialize
import java.time.LocalDate
import java.util.HashSet
import java.util.Set
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToMany
import javax.persistence.ManyToOne
import org.eclipse.xtend.lib.annotations.Accessors
import serializers.LocalDateSerializer

@Entity
@Accessors
class ForumPost {

	@Id
	@GeneratedValue
	Long id

	@ManyToOne
	User user
	
	@Column
	boolean available

	@Column
	boolean isPrivate

	@Column(columnDefinition="TEXT")
	String title

	@Column(columnDefinition="TEXT")
	String text

	@Column
	@JsonSerialize(using = LocalDateSerializer)
	LocalDate date
	
	@ManyToMany(fetch=FetchType.EAGER, cascade = CascadeType.ALL)
	@JsonIgnore
	Set<Responses> responses = new HashSet<Responses>
	
	def addComent(Responses comentToAdd){
		responses.add(comentToAdd)
	}
	
	def getCommentsAmount(){
		responses.size
	}
	
	def removeComent(Responses comentToRemove){
		responses.remove(comentToRemove)
	}
}

@Entity
@Accessors
class Responses{
	@Id
	@GeneratedValue
	Long id

	@ManyToOne
	User user

	@Column(columnDefinition="TEXT")
	String title

	@Column(columnDefinition="TEXT")
	String text

	@Column
	@JsonSerialize(using = LocalDateSerializer)
	LocalDate date
}