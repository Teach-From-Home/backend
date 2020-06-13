package domain

import java.time.LocalDate
import java.util.ArrayList
import java.util.List
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToMany
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import com.fasterxml.jackson.annotation.JsonIgnore

@Entity
@Accessors
class Post {
	
	@Id
	@GeneratedValue
	Long id

	@OneToOne
	User user

	@Column
	boolean isPrivate

	@Column(columnDefinition="TEXT")
	String text

	@Column
	LocalDate date
	
	@OneToMany(fetch=FetchType.LAZY, cascade = CascadeType.ALL)
	@JsonIgnore
	List<Post> responses = new ArrayList<Post>
	
	def addComent(Post comentToAdd){
		responses.add(comentToAdd)
	}
	
	def removeComent(Post comentToRemove){
		responses.remove(comentToRemove)
	}
}