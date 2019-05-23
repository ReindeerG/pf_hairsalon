package hairsalon.service;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

public interface TaskService {
	void proceed() throws MessagingException;
	void once() throws MessagingException;
}
