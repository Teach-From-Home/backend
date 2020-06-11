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

@Entity
@Observable
@Accessors
class Post {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	Long id
	
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