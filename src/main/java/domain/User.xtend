package domain

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors

@Entity
@Accessors
class User{
	
	@Id
	@GeneratedValue
	Long id
	
	@Column
	boolean active = true
	
	@Column
	String name
	
	@Column
	String lastname
	
	@Column
	String email
	
	@Column
	int dni
	
	@Column
	String password
}