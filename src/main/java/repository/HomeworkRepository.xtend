package repository

import domain.Homework
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root
import utils.BadCredentialsException
import javax.persistence.NoResultException

class HomeworkRepository extends HibernateRepository<Homework> {
	
	static HomeworkRepository instance

	static def getInstance() {
		if (instance === null) {
			instance = new HomeworkRepository()
		}
		instance
	}
	
	override getEntityType() {
		Homework
	}
	
	override queryById(Long id, CriteriaBuilder builder, CriteriaQuery<Homework> query, Root<Homework> from) {
		query.select(from).where(builder.equal(from.get("id"), id))
	}
	
	def searchByExample(String idUser, String description){
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from).where(
				criteria.and(
					criteria.equal(from.get("student"), Long.parseLong(idUser)),
					criteria.equal(from.get("description"), description)
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