package serializers

import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.SerializerProvider
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import domain.User
import java.io.IOException
import java.util.List
import java.util.Set

class ShortUserSerializer extends StdSerializer<User> {

	protected new(Class<User> t) {
		super(t)
	}

	override serialize(User value, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeStartObject()
		gen.writeNumberField("id", value.id)
		gen.writeStringField("name", value.name)
		gen.writeStringField("lastName", value.lastname)
		gen.writeStringField("role", value.role)
		gen.writeEndObject()
	}

	static def String toJson(User user) {
		mapper().writeValueAsString(user)
	}

	static def String toJson(Set<User> user) {
		mapper().writeValueAsString(user)
	}

	static def String toJson(List<User> user) {
		mapper().writeValueAsString(user)
	}

	static def mapper() {
		val ObjectMapper mapper = new ObjectMapper()
		val SimpleModule module = new SimpleModule()
		module.addSerializer(User, new ShortUserSerializer(User))
		mapper.registerModule(module)
		mapper
	}

}


