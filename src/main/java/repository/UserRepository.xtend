package repository

import domain.Subject
import domain.User
import javax.persistence.NoResultException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root
import utils.BadCredentialsException
import javassist.NotFoundException
import domain.Classroom

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
	
	def notAddedSubjects(String userId) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(Subject)
			val from = query.from(Subject)
			val user = searchById(userId)
			query.select(from).where(
				criteria.not(
					from.get("id").in(user.subjects.map[it.id].toSet)	
				)
			)
			entityManager.createQuery(query).resultList
		}catch (NoResultException e) {
			throw new NotFoundException("No hay mas materias por agregar")
		} 
		finally {
			entityManager?.close
		}
	}

	override queryById(Long id, CriteriaBuilder builder, CriteriaQuery<User> query, Root<User> from){
		query.select(from).where(builder.equal(from.get("id"), id))
	}
	

}
