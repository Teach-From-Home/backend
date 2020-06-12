package Repository

import domain.Subject
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root
import javax.persistence.criteria.CriteriaBuilder

class SubjectRepository extends HibernateRepository<Subject>{
		override getEntityType() {
		Subject
	}
	
	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Subject> query, Root<Subject> camposCandidato, Subject t) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
}