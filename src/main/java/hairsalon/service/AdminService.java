package hairsalon.service;

import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpSession;

import hairsalon.entity.AdminDto;

public interface AdminService {
	int signin(AdminDto adminDto);
	int login(String email, String pw, HttpSession session) throws NoSuchAlgorithmException;
	int expr_admin(HttpSession session);
}