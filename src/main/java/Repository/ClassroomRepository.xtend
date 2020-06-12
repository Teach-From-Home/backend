package Repository

import domain.Classroom
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

class ClassroomRepository extends HibernateRepository<Classroom>{
	
	override getEntityType() {
		Classroom
	}
	
	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Classroom> query, Root<Classroom> camposCandidato, Classroom t) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}