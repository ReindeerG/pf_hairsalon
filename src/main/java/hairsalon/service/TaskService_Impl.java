package hairsalon.service;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

@Service("taskService")
public class TaskService_Impl implements TaskService {
	private boolean once = false;
	
	@Autowired
	CustomerService customerService;
	
	@Autowired
	ReservationService reservationService;
	
	@Autowired
	VacationService vacationService;
	
	@Autowired
	DesignerService designerService;
	
	@Autowired
	DesignService designService;
	
	@Autowired
	EmailService emailService;
	
	@Scheduled(cron="0 0 0 * * ?") // 매일 00시 00분 00초 마다
	public void proceed() throws MessagingException {
		reservationService.dayover();
		vacationService.dayover();
		vacationService.setVacations();
		customerService.dayover();
		customerService.notConfirmOver();
		designerService.restore();
		designService.restore();
		emailService.sendWarningMail(customerService.warningList());
	}
	
	@Scheduled(fixedDelay=Long.MAX_VALUE)
	public void once() throws MessagingException {
		if(!once) {
			this.proceed();
			once=true;
			return;
		}
	}
}
