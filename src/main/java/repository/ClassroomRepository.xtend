package repository

import domain.Classroom
import domain.User
import javax.persistence.NoResultException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.Root
import utils.BadCredentialsException
import utils.Role

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

	def getClassroomByListType(String id, String dataJoinType) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			from.fetch(dataJoinType, JoinType.LEFT)
			query.select(from).where(
				criteria.and(
					criteria.equal(from.get("id"), Long.parseLong(id))
				)
			)
			entityManager.createQuery(query).singleResult
		} catch (NoResultException e) {
			throw new BadCredentialsException("No existe la combinacion de usuario y contraseña")
		} finally {
			entityManager?.close
		}
	}

	def notAddedByUserType(Classroom classroom, String userType, String error) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(User)
			val from = query.from(User)
			query.where(					
				criteria.and(
					if (!classroom.users.empty) {
						criteria.not(from.get("id").in(classroom.users.map[it.id].toSet))
					},
					criteria.equal(from.get("role"), userType),
					criteria.equal(from.get("active"), true)
				)
			)
			entityManager.createQuery(query).resultList
		} catch (NoResultException e) {
			throw new BadCredentialsException(error)
		} finally {
			entityManager?.close
		}
	}

	def getClassroomsByUser(String idUser) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			val users = from.joinSet("users", JoinType.INNER)
			from.fetch("users", JoinType.INNER)
			query.select(from).where(
				criteria.equal(from.get("active"), true),
				criteria.equal(users.get("id"),Long.parseLong(idUser))
			).distinct(true)
			entityManager.createQuery(query).resultList
		} catch (NoResultException e) {
			throw new BadCredentialsException("No existe la combinacion de usuario y contraseña")
		} finally {
			entityManager?.close
		}
	}

	def getClassroomListTypeByUser(String string) {
		
	}

}
