package repository

import domain.Classroom
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.Root

class ClassroomRepository extends HibernateRepository<Classroom> {

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

	override allInstances() {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			entityManager.createQuery(query).resultList
		} finally {
			entityManager?.close
		}
	}

}
