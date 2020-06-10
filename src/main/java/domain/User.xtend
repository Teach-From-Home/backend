package domain

import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Column

class User {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	Long id
	
	@Column
	String name
	
	@Column
	String lastname
	
	@Column
	String email
	
	@Column
	int dni

}