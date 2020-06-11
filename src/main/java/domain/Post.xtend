package domain

import java.time.LocalDate
import java.util.ArrayList
import java.util.List
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Column
import javax.persistence.OneToMany
import javax.persistence.GenerationType
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
	
	@OneToOne(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	Student student
	
	@Column
	boolean isPrivate
	
	@Column
	String text
	
	@Column
	String type
	
	@Column
	LocalDate date
	
	@OneToMany
	List<Post> coments = new ArrayList<Post>
	
	def addComent(Post comentToAdd){
		coments.add(comentToAdd)
	}
	
	def removeComent(Post comentToRemove){
		coments.remove(comentToRemove)
	}
}