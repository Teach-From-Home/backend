package Repository

import domain.User
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root
import services.UserSignIn

class UserRepository extends HibernateRepository<User>{
	
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
	
	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<User> query, Root<User> camposCandidato, User t) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	def getUserBySignIn(UserSignIn userSignInData) {
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			query.where(newArrayList => [
					add(criteria.equal(from.get("dni"), userSignInData.dni))
					add(criteria.equal(from.get("password"), userSignInData.password))
					add(criteria.equal(from.get("active"),1))
				]
			)
			
			return entityManager.createQuery(query).singleResult
			
		} finally {
			
		}
	}
	
	def getUsers(){
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			
			return entityManager.createQuery(query).resultList
			
		} finally {
			
		}
	}
}