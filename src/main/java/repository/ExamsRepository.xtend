package repository

import com.mongodb.MongoClient
import domain.Exam
import java.util.List
import javassist.NotFoundException
import org.bson.types.ObjectId
import org.mongodb.morphia.Datastore
import org.mongodb.morphia.Morphia
import org.mongodb.morphia.query.Query

class ExamsRepository {
	static protected Datastore ds
	static Morphia morphia

	private new() {
		if (ds === null) {
			val mongo = new MongoClient("localhost", 27017)
			morphia = new Morphia => [
				ds = createDatastore(mongo, "tfm")
				ds.ensureIndexes
			]
		}
	}

	static ExamsRepository instance

	static def getInstance() {
		if (instance === null) {
			instance = new ExamsRepository()
		}
		instance
	}

	def create(Exam t) {
		ds.save(t)
		t
	}

	def void delete(Exam t) {
		ds.delete(t)
	}

	def List<Exam> allInstances() {
		ds.createQuery(this.getEntityType()).asList
	}

	def validateQuery(Query<Exam> query, String msg) {
		if (query.asList.empty)
			throw new NotFoundException(msg)
	}

	def getEntityType() { Exam }

	def searchById(ObjectId id) {
		val query = ds.createQuery(entityType)
		if (id !== null) {
			query.field("id").equal(id)
		}
		validateQuery(query, "No existe el vuelo")
		query.get()
	}

//	def void update(Exam flight) {
//		ds.update(flight, this.defineUpdateOperations(flight))
//	}
//
//	def defineUpdateOperations(Exam flight){
//		ds.createUpdateOperations(entityType)
//			.set("seats", flight.)
//	}
}
