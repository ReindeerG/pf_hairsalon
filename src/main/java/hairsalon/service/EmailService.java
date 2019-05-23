package hairsalon.service;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

public interface EmailService {
	 void sendConfirmMail(String email, HttpServletRequest request) throws MessagingException;
	 void sendTempPwMail(String email, String newpw) throws MessagingException;
	 void sendWarningMail(String[] emails) throws MessagingException;
}
