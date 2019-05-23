package hairsalon.service;

import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import hairsalon.entity.CustomerDto;

@Service("emailService")
public class EmailService_gmail implements EmailService {
	@Autowired
	private CustomerService customerService;
	
	private JavaMailSender sender;
	
	private void setSender() {
		JavaMailSenderImpl presender = new JavaMailSenderImpl();
		presender.setHost("smtp.gmail.com");
		presender.setPort(587);
		presender.setUsername("yhairriahy@gmail.com");
		presender.setPassword("dhkdlgpdjy");
		Properties options = new Properties();
		options.put("mail.transport.protocol", "smtp");
		options.put("mail.smtp.auth", "true");
		options.put("mail.debug", "true");
		options.put("mail.smtp.starttls.enable", "true");
		options.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		presender.setJavaMailProperties(options);
		sender = presender;
	}
	
	public void sendConfirmMail(String email, HttpServletRequest request) throws MessagingException {
		String host = request.getHeader("Host");
		String contextpath = request.getServletContext().getContextPath();
		CustomerDto customerDto = customerService.getOneByEmail(email);
		if(customerDto==null) return;
		if(customerDto.getConfirmed()==1) return;
		this.setSender();
		MimeMessage mail = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(mail, true, "UTF-8");
		helper.setFrom("YHair");
		String[] receives = {email};
		helper.setTo(receives);
		helper.setSubject("와이헤어 가입인증메일");
		helper.setText("가입인증메일","<div style='color:white;background-color:black;font-size:2rem;text-align:center;'><p>와이헤어의 회원이 되신 것을 환영합니다!</p><p><a href='"+host+contextpath+"/pc/confirm?no="+customerDto.getNo()+"&confirmcode="+customerDto.getConfirmcode()+"' target='_blank'><button>가입 인증 완료</button></a></p></div>");
		sender.send(mail);
	}
	
	public void sendTempPwMail(String email, String newpw) throws MessagingException {
		this.setSender();
		MimeMessage mail = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(mail, true, "UTF-8");
		helper.setFrom("YHair");
		String[] receives = {email};
		helper.setTo(receives);
		helper.setSubject("와이헤어 임시비밀번호 안내");
		helper.setText("임시비밀번호","<div style='color:white;background-color:black;font-size:2rem;text-align:center;'><p>임시 비밀번호를 알려드립니다!</p><p style='font-weight:bold;'>"+newpw+"</p><p>로그인 후 비밀번호를 변경하시고 사용해주세요.</p></div>");
		sender.send(mail);
	}
	
	public void sendWarningMail(String[] emails) throws MessagingException {
		if(emails==null || emails.length==0) return;
		this.setSender();
		MimeMessage mail = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(mail, true, "UTF-8");
		helper.setFrom("YHair");
		helper.setTo(emails);
		helper.setSubject("와이헤어 회원정보 삭제예정 안내");
		helper.setText("회원삭제예정 안내","<div style='color:white;background-color:black;font-size:2rem;text-align:center;'><p>방문/로그인이 1년이 지난 회원은 자동으로 정보를 삭제합니다.</p><p>회원정보를 유지하고 싶으시면 로그인 혹은 매장방문 해주세요.</p><p>(회원정보 삭제시 마일리지 정보도 모두 삭제됩니다.)</p></div>");
		sender.send(mail);
	}
}
