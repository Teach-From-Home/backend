package repository

import domain.Classroom
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

class ClassroomRepository extends HibernateRepository<Classroom>{
	
	static ClassroomRepository instance

	static def getInstance() {
		if (instance === null) {
			instance = new ClassroomRepository()
		}
		instance
	}
	
	override getEntityType() {
		Classroom
	}

	
	override queryById(Long id, CriteriaBuilder builder, CriteriaQuery<Classroom> query, Root<Classroom> from) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}
