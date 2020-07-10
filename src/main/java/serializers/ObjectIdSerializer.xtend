package serializers

import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.JsonSerializer
import com.fasterxml.jackson.databind.SerializerProvider
import java.io.IOException
import org.bson.types.ObjectId

class ObjectIdSerializer extends JsonSerializer<ObjectId> {
	
	override serialize(ObjectId value, JsonGenerator gen, SerializerProvider serializers) throws IOException {
		gen.writeString(value.toString)
	}

}
