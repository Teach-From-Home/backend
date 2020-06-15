package serializers

import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.JsonSerializer
import com.fasterxml.jackson.databind.SerializerProvider
import java.io.IOException
import java.time.LocalDate
import java.time.format.DateTimeFormatter

class LocalDateSerializer extends JsonSerializer<LocalDate> {
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/YYYY");
	
	override serialize(LocalDate value, JsonGenerator gen, SerializerProvider serializers) throws IOException {
		gen.writeString((formatter.format(value)))
	}

}
