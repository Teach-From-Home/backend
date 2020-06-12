package Repository

import domain.Classroom
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

class ClassroomRepository extends HibernateRepository<Classroom>{
	
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
	
	override generateWhere(CriteriaBuilder criteria, CriteriaQuery<Classroom> query, Root<Classroom> camposCandidato, Classroom t) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	def getClassrooms(){
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			
			return entityManager.createQuery(query).resultList
			
		} finally {
			
		}
	}
	
	def getClassroom(Long id){
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(Classroom)
			val from = query.from(Classroom)
			query.select(from)
			
			query.where(newArrayList => [
					add(criteria.equal(from.get("id"), id))
				]
			)
			return entityManager.createQuery(query).singleResult
			
		} finally {
			
		}
	}
	
	def getHomeworkFromStudentView(Long id){
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(Classroom)
			val from = query.from(Classroom)
			query.select(from)
			
			query.where(newArrayList => [
					add(criteria.equal(from.get("id"), id))
				]
			)
			return entityManager.createQuery(query).singleResult
			
		} finally {
			
		}
	}
}