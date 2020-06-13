package repository

import domain.User
import javax.persistence.NoResultException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root
import utils.BadCredentialsException

class UserRepository extends HibernateRepository<User> {

	static UserRepository instance

	static def getInstance() {
		if (instance === null) {
			instance = new UserRepository()
		}
		instance
	}

	override getEntityType() {
		User
	}

	def login(User userCredentials) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from).where(
				criteria.and(
					criteria.equal(from.get("dni"), userCredentials.dni),
					criteria.equal(from.get("password"), userCredentials.password),
					criteria.equal(from.get("active"), true)
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

	override queryById(Long id, CriteriaBuilder builder, CriteriaQuery<User> query, Root<User> from){
		query.select(from).where(builder.equal(from.get("id"), id))
	}
	
	def getUserById(Long id){
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from).where(
				criteria.and(
					criteria.equal(from.get("id"), id)
				)
			)
			entityManager.createQuery(query).singleResult
		}catch (NoResultException e) {
			throw new BadCredentialsException("No existe el usuario consultado")
		} 
		finally {
			entityManager?.close
		}
	}

}
