package hairsalon.service;

import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hairsalon.entity.AdminDto;
import hairsalon.entity.CustomerDto;
import hairsalon.repository.AdminDao;

@Service("adminService")
public class AdminService_Oracle implements AdminService {
	@Autowired
	private AdminDao adminDao;
	
	@Autowired
	private EncryptService SHA512Service;

	public int signin(AdminDto adminDto) {
		return adminDao.insert(adminDto);
	}
	
	public int login(String email, String pw, HttpSession session) throws NoSuchAlgorithmException {
		AdminDto adminDto = AdminDto.builder().email(email).pw(SHA512Service.encrypt(pw, 9)).build();
		System.out.println(adminDto.getPw());
		AdminDto result = adminDao.login(adminDto);
		if(result==null) return 0;
		else {
			session.setAttribute("loginno", result.getNo());
			session.setAttribute("loginname", result.getName());
			session.setAttribute("loginauth", "admin");
			return result.getNo();
		}
	}
	
	public int expr_admin(HttpSession session) {
		session.setAttribute("loginno", 1);
		session.setAttribute("loginname", "제작자");
		session.setAttribute("loginauth", "admin");
		return 1;
	}
}
