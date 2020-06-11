package domain

import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Column
import javax.persistence.GenerationType
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import org.uqbar.commons.model.annotations.Observable

@Entity
@Observable
@Accessors
class Subject {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	Long id
	
	@Column
	String name
	
	@Column
	String description
}