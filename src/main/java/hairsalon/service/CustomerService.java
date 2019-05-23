package hairsalon.service;

import java.security.NoSuchAlgorithmException;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import hairsalon.entity.BoardDto;
import hairsalon.entity.CustomerDto;

public interface CustomerService {
	int signinSelf(CustomerDto customerDto) throws NoSuchAlgorithmException;
	int signinByAdmin(CustomerDto customerDto) throws NoSuchAlgorithmException;
	int login(String email, String pw, HttpSession session) throws NoSuchAlgorithmException;
	int expr_customer(HttpSession session);
	int tempPw(int no) throws NoSuchAlgorithmException, MessagingException;
	boolean existByEmail(String email);
	int mailConfirm(int no);
	List<CustomerDto> getAllList();
	List<CustomerDto> findId(CustomerDto customerDto);
	List<CustomerDto> searchInSchedule(CustomerDto customerDto);
	int delete(int no);
	int modifyByAdmin(CustomerDto customerDto);
	int modifyByCustomer(CustomerDto customerDto);
	int modifyPw(int no, String originpw, String pw) throws NoSuchAlgorithmException;
	CustomerDto getOne(int no);
	CustomerDto getOneByName(String name);
	CustomerDto getOneByEmail(String email);
	boolean mileageEnough(CustomerDto customerDto);
	int mileageUse(CustomerDto customerDto);
	int mileageCharge(CustomerDto customerDto);
	int visitcount(int no);
	List<CustomerDto> getSearchList(int no, CustomerDto customerDto);
	int getTotalPagenation(CustomerDto customerDto);
	int getMinPagenation(int no);
	int getMaxPagenation(int no, CustomerDto customerDto);
	int getPrevPagenation(int no);
	int getNextPagenation(int no, CustomerDto customerDto);
	boolean confirm(int no, String confirmcode);
	void dayover();
	void notConfirmOver();
	String[] warningList();
}