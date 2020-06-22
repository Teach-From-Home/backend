package utils

import domain.User
import java.util.Date
import java.util.Properties
import javax.mail.Authenticator
import javax.mail.Message
import javax.mail.PasswordAuthentication
import javax.mail.Session
import javax.mail.Transport
import javax.mail.internet.InternetAddress
import javax.mail.internet.MimeMessage

class MailSender {

	def static send(User user, String BODY,String subject ) {

		val String fromEmail = "teachfromhometfm@gmail.com"; 
		val String password = "TFM_lospibes"; 
		val String toEmail = user.email; 
		val props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com"); 
		props.put("mail.smtp.port", "587"); 
		props.put("mail.smtp.auth", "true"); 
		props.put("mail.smtp.starttls.enable", "true"); 
		val Authenticator auth = new Authenticator() {
			override protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromEmail, password);
			}
		}
		println("start")
		val Session session = Session.getInstance(props, auth);

		try {
			val MimeMessage msg = new MimeMessage(session);
			msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
			msg.addHeader("format", "flowed");
			msg.addHeader("Content-Transfer-Encoding", "8bit");

			msg.setFrom(new InternetAddress("TFM-admin", "Notificaciones TFM"));

			msg.setSubject(subject, "UTF-8");

			msg.setContent(BODY, "text/html;charset=UTF-8");

			msg.setSentDate(new Date());

			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));

			Transport.send(msg);

		} catch (Exception e) {
			println(e)
			e.printStackTrace();
		}

	}
	
}
