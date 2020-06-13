package domain

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors

@Entity
@Accessors
class Subject {
	
	@Id
	@GeneratedValue
	Long id
	
	@Column
	String name
	
	@Column(columnDefinition="TEXT")
	String description
	
	@Column
	boolean active = true
}