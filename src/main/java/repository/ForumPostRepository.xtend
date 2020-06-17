package repository

import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root
import domain.ForumPost

class ForumPostRepository extends HibernateRepository<ForumPost> {
	
	static ForumPostRepository instance

	static def getInstance() {
		if (instance === null) {
			instance = new ForumPostRepository()
		}
		instance
	}

	override getEntityType() {
		ForumPost
	}
	
	override queryById(Long id, CriteriaBuilder builder, CriteriaQuery<ForumPost> query, Root<ForumPost> from) {
		query.select(from).where(builder.equal(from.get("id"), id))
	}
}