package domain

import java.time.LocalDate
import java.util.ArrayList
import java.util.List
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Column
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import org.uqbar.commons.model.annotations.Observable
import javax.persistence.OneToOne
import javax.persistence.FetchType
import javax.persistence.CascadeType

@Entity
@Observable
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
	List<Post> coments = new ArrayList<Post>
	
	def addComent(Post comentToAdd){
		coments.add(comentToAdd)
	}
	
	def removeComent(Post comentToRemove){
		coments.remove(comentToRemove)
	}
}