package Repository

import java.util.List
import javax.persistence.PersistenceException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.EntityManager
import javax.persistence.EntityManagerFactory
import javax.persistence.Persistence

@Accessors
abstract class HibernateRepository<T> {

	static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("TeachFromHome")
	protected static EntityManager entityManager = entityManagerFactory.createEntityManager

	def List<T> allInstances() {
		val criteria = entityManager.criteriaBuilder
		val query = criteria.createQuery as CriteriaQuery<T>
		val from = query.from(entityType)
		query.select(from)
		entityManager.createQuery(query).resultList
	}

	def Class<T> getEntityType()

	def List<T> searchByExample(T t) {
		val criteria = entityManager.criteriaBuilder
		val query = criteria.createQuery as CriteriaQuery<T>
		val from = query.from(entityType)
		query.select(from)
		generateWhere(criteria, query, from, t)
		entityManager.createQuery(query).resultList
	}

	abstract def void generateWhere(CriteriaBuilder criteria, CriteriaQuery<T> query, Root<T> camposCandidato,T t)

	def void createOrUpdate(T t) {
		try {
			entityManager => [
				transaction.begin
				merge(t)
				transaction.commit
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ha ocurrido un error. La operación no puede completarse.", e)
		}
	}

}