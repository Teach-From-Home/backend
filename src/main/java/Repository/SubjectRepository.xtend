package Repository

import domain.Subject
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root
import javax.persistence.criteria.CriteriaBuilder

class SubjectRepository extends HibernateRepository<Subject>{
	
	static SubjectRepository instance

	static def getInstance() {
		if (instance === null) {
			instance = new SubjectRepository()
		}
		instance
	}
	
	override getEntityType() {
		Subject
	}

	
	override queryById(Long id, CriteriaBuilder builder, CriteriaQuery<Subject> query, Root<Subject> from) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}