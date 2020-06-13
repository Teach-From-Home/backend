package repository

import domain.Classroom
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.Root
import javax.persistence.NoResultException
import utils.BadCredentialsException

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
		query.select(from).where(builder.equal(from.get("id"), id))
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
	
	def getClassroomByListType(Long id, String dataJoinType){
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			from.fetch(dataJoinType, JoinType.LEFT)
			query.select(from).where(
				criteria.and(
					criteria.equal(from.get("id"), id)
				)
			)
			entityManager.createQuery(query).singleResult
		}catch (NoResultException e) {
			throw new BadCredentialsException("No existe la combinacion de usuario y contraseña")
		} 
		finally {
			entityManager?.close
		}
	}
}
