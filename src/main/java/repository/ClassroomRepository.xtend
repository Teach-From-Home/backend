package repository

import domain.Classroom
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.JoinType
import javax.persistence.criteria.Root
import javax.persistence.NoResultException
import utils.BadCredentialsException
import domain.Homework
import domain.User

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
	
	def getClassroomByListType(String id, String dataJoinType){
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
		}catch (NoResultException e) {
			throw new BadCredentialsException("No existe la combinacion de usuario y contraseña")
		} 
		finally {
			entityManager?.close
		}
	}
	
	def getClassroomByStudentView(String idClassroom, String idUser){
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(Homework)
			val from = query.from(Homework)
			query.select(from).where(
				criteria.and(
					criteria.equal(from.get("classroomId"), Long.parseLong(idClassroom)),
					criteria.equal(from.get("available"), 1)
				)
			)
			entityManager.createQuery(query).resultList
		}catch (NoResultException e) {
			throw new BadCredentialsException("No existe la combinacion de usuario y contraseña")
		} 
		finally {
			entityManager?.close
		}
	}
	
	def getHomeworkDoneOfHomework(String idClassroom, String idHomework){
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(Homework)
			val from = query.from(Homework)
			query.select(from).where(
				criteria.and(
					criteria.equal(from.get("classroomId"), Long.parseLong(idClassroom)),
					criteria.equal(from.get("id"), Long.parseLong(idHomework))
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
	
	def notAddedUsers(String idClassroom){
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(User)
			val from = query.from(User)
			val classroom = searchById(idClassroom)
			query.select(from).where(
				criteria.not(
					from.get("id").in(classroom.users.map[it.id].toSet)	
				),
				criteria.or(
					criteria.equal(from.get("role"), "STUDENT"),
					criteria.equal(from.get("role"), "TEACHER")
				)
			)			
			entityManager.createQuery(query).resultList
		}catch (NoResultException e) {
			throw new BadCredentialsException("No existe la combinacion de usuario y contraseña")
		} 
		finally {
			entityManager?.close
		}
	}
}