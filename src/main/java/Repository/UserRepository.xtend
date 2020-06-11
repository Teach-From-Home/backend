package Repository

import domain.User
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root


class UserRepository extends HibernateRepository<User>{
	
	override getEntityType() {
		User
	}
	
	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<User> query, Root<User> camposCandidato, User t) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}