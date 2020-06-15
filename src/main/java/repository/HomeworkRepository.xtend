package repository

import domain.Homework
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

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

}
