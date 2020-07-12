package domain

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.GeneratedValue

@Accessors
@Entity
class Bibliography {
	@Id @GeneratedValue
	Long id
	@Column
	String title
	@Column
	String description
	@Column
	String file
	
	override equals(Object obj) {
		try {
			val other = obj as Bibliography
			id == other?.id
		} catch (ClassCastException e) {
			return false
		}
	}
	
	override hashCode() {
		if (id !== null) id.hashCode else super.hashCode
	}
}