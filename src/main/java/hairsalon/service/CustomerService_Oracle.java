package hairsalon.service;

import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

import hairsalon.entity.BoardDto;
import hairsalon.entity.CurrentDate;
import hairsalon.entity.CustomerDto;
import hairsalon.repository.CustomerDao;

@Service("customerService")
@PropertySource({"classpath:/properties/page.properties"})
public class CustomerService_Oracle implements CustomerService {
	@Autowired
	private CustomerDao customerDao;
	
	@Autowired
	private EncryptService SHA512Service;
	
	@Autowired
	private RandomStringService randomStringService;
	
	@Autowired
	private EmailService emailService;
	
	@Autowired
	private DesignerService designerService;
	
	@Autowired
	private Environment env;
	
	private CustomerDto setString(CustomerDto customerDto) {
		if(customerDto.getDesigner()!=0) customerDto.setDesigner_str(designerService.getOne(customerDto.getDesigner()).getName());
		else customerDto.setDesigner_str("-");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		customerDto.setBirth_str(format.format(customerDto.getBirth()));
		customerDto.setReg_str(format.format(customerDto.getReg()));
		customerDto.setLatestdate_str(format.format(customerDto.getLatestdate()));
		Calendar c = Calendar.getInstance();
		c.setTime(customerDto.getDeletedate());
		c.add(Calendar.DATE, 1);
		customerDto.setDeletedate_str(format.format(c.getTime()));
		return customerDto;
	}
	
	private List<CustomerDto> setString(List<CustomerDto> list) {
		for(CustomerDto customerDto : list) {
			customerDto = this.setString(customerDto);
		}
		return list;
	}

	public int signinSelf(CustomerDto customerDto) throws NoSuchAlgorithmException {
		customerDto.setPw(SHA512Service.encrypt(customerDto.getPw(), 6));
		customerDto.setConfirmcode(SHA512Service.encrypt(customerDto.getEmail(), 7));
		return customerDao.insertSelf(customerDto);
	}
	
	public int signinByAdmin(CustomerDto customerDto) throws NoSuchAlgorithmException {
		StringBuilder builder = new StringBuilder();
		builder.append(customerDto.getBirth_str().substring(2, 4));
		builder.append(customerDto.getBirth_str().substring(5, 7));
		builder.append(customerDto.getBirth_str().substring(8, 10));
		customerDto.setPw(SHA512Service.encrypt(builder.toString(), 7));
		return customerDao.insertByAdmin(customerDto);
	}
	
	public int login(String email, String pw, HttpSession session) throws NoSuchAlgorithmException {
		CustomerDto customerDto = CustomerDto.builder().email(email).pw(SHA512Service.encrypt(pw, 6)).build();
		CustomerDto result = customerDao.login(customerDto);
		if(result==null) return 0;
		else {
			if(result.getConfirmed()==0) return -1;
			session.setAttribute("loginno", result.getNo());
			session.setAttribute("loginname", result.getName());
			session.setAttribute("loginauth", "customer");
			customerDao.loginDeleteDelay(result.getNo());
			return result.getNo();
		}
	}
	
	public int expr_customer(HttpSession session) {
		CustomerDto customerDto = customerDao.getOne(21);
		session.setAttribute("loginno", customerDto.getNo());
		session.setAttribute("loginname", customerDto.getName());
		session.setAttribute("loginauth", "customer");
		customerDao.loginDeleteDelay(customerDto.getNo());
		return customerDto.getNo();
	}
	
	public int tempPw(int no) throws NoSuchAlgorithmException, MessagingException {
		String newpw = randomStringService.getRandomString(6);
		CustomerDto customerDto = CustomerDto.builder().no(no).pw(SHA512Service.encrypt(newpw,7)).build();
		int result = customerDao.modifyPw(customerDto);
		CustomerDto origin = customerDao.getOne(no);
		emailService.sendTempPwMail(origin.getEmail(), newpw);
		return result;
	}
	
	public boolean existByEmail(String email) {
		int result = customerDao.existByEmail(email);
		return (result==1);
	}
	
	public int mailConfirm(int no) {
		return customerDao.mailConfirm(no);
	}
	
	public CustomerDto getOne(int no) {
		return this.setString(customerDao.getOne(no));
	}
	
	public CustomerDto getOneByName(String name) {
		return this.setString(customerDao.getOneByName(name));
	}
	
	public CustomerDto getOneByEmail(String email) {
		return this.setString(customerDao.getOneByEmail(email));
	}

	public List<CustomerDto> getAllList() {
		List<CustomerDto> list = customerDao.getAllList();
		return this.setString(list);
	}
	
	public List<CustomerDto> findId(CustomerDto customerDto) {
		List<CustomerDto> list = customerDao.findId(customerDto);
		return this.setString(list);
	}
	
	public int getTotalPagenation(CustomerDto customerDto) {
		int total = customerDao.countSearch(customerDto);
		if(customerDto.getSearch().equals("no")) total=1;
		int perview = Integer.parseInt(env.getProperty("view.customer"));
		int pagenation = total/perview;
		if(total%perview!=0) pagenation++;
		if(pagenation==0) pagenation=1;
		return pagenation;
	}
	
	public int getMinPagenation(int no) {
		int perpage = Integer.parseInt(env.getProperty("pages.customer"));
		if(no%perpage==0) {
			return ((no/perpage-1)*perpage+1);
		} else return ((no/perpage)*perpage+1);
	}
	
	public int getMaxPagenation(int no, CustomerDto customerDto) {
		int perpage = Integer.parseInt(env.getProperty("pages.customer"));
		int result = 0;
		if(no%perpage==0) {
			result = no;
		} else result = (no/perpage+1)*perpage;
		if(result<this.getTotalPagenation(customerDto)) return result;
		else return this.getTotalPagenation(customerDto);
	}
	
	public int getPrevPagenation(int no) {
		if(no==1) return 0;
		else return this.getMinPagenation(no)-1;
	}
	
	public int getNextPagenation(int no, CustomerDto customerDto) {
		if(this.getMaxPagenation(no, customerDto)==this.getTotalPagenation(customerDto)) return 0;
		else return this.getMaxPagenation(no, customerDto)+1;
	}
	
	public List<CustomerDto> getSearchList(int no, CustomerDto customerDto) {
		int perview = Integer.parseInt(env.getProperty("view.customer"));
		List<CustomerDto> list = customerDao.getSearchList((no-1)*perview+1, perview, customerDto);
		return this.setString(list);
	}
	
	public List<CustomerDto> searchInSchedule(CustomerDto customerDto) {
		return customerDao.searchInSchedule(customerDto);
	}
	
	public int delete(int no) {
		return customerDao.delete(no);
	}
	
	public int modifyByAdmin(CustomerDto customerDto) {
		return customerDao.modifyByAdmin(customerDto);
	}
	
	public int modifyByCustomer(CustomerDto customerDto) {
		return customerDao.modifyByCustomer(customerDto);
	}
	
	public int modifyPw(int no, String originpw, String pw) throws NoSuchAlgorithmException {
		CustomerDto origin = CustomerDto.builder().no(no).pw(SHA512Service.encrypt(originpw, 6)).build();
		int result = customerDao.checkPw(origin);
		if(result==1) {
			CustomerDto customerDto = CustomerDto.builder().no(no).pw(SHA512Service.encrypt(pw, 6)).build();
			return customerDao.modifyPw(customerDto);
		} else {
			return 0;
		}
	}
	
	public boolean mileageEnough(CustomerDto customerDto) {
		CustomerDto realCustomerDto = customerDao.getOne(customerDto.getNo());
		if(realCustomerDto.getMileage()>=customerDto.getMileage()) {
			return true;
		}
		else return false;
	}
	
	public int mileageUse(CustomerDto customerDto) {
		return customerDao.mileageUse(customerDto);
	}
	
	public int mileageCharge(CustomerDto customerDto) {
		return customerDao.mileageCharge(customerDto);
	}
	
	public int visitcount(int no) {
		return customerDao.visitcount(no);
	}
	
	public boolean confirm(int no, String confirmcode) {
		CustomerDto customerDto = CustomerDto.builder().no(no).confirmcode(confirmcode).build();
		int result = customerDao.confirmCheck(customerDto);
		if(result==1) {
			customerDao.mailConfirm(no);
			return true;
		} else {
			return false;
		}
	}
	
	public void dayover() {
		customerDao.dayover();
	}
	
	public void notConfirmOver() {
		customerDao.notConfirmOver();
	}
	
	public String[] warningList() {
		List<CustomerDto> list = customerDao.warningList();
		ArrayList<String> strings = new ArrayList<>();
		for(CustomerDto customerDto : list) {
			strings.add(customerDto.getEmail());
		}
		return list.toArray(new String[list.size()]);
	}
}
