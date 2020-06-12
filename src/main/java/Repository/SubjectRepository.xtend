package Repository

import domain.Subject
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root
import javax.persistence.criteria.CriteriaBuilder

class SubjectRepository extends HibernateRepository<Subject>{
	
	static SubjectRepository instance

	static def getInstance() {
		if (instance === null) {
			instance = new SubjectRepository()
		}
		instance
	}
	
	override getEntityType() {
		Subject
	}
	
	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Subject> query, Root<Subject> camposCandidato, Subject t) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	def getSubjects(){
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