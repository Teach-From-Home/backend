package Repository

import domain.User
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

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
					criteria.equal(from.get("active"), userCredentials.active)
				)
			)
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager?.close
		}
	}

	override queryById(Long id, CriteriaBuilder builder, CriteriaQuery<User> query, Root<User> from) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}
