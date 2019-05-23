package hairsalon.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import hairsalon.entity.BoardDto;
import hairsalon.entity.CustomerDto;

@Repository("customerDao")
public class CustomerDao_Oracle implements CustomerDao {
	@Autowired
	private SqlSession sqlSession;
	
	public int insertSelf(CustomerDto customerDto) {
		return sqlSession.insert("db_customer.insert_self", customerDto);
	}
	
	public int insertByAdmin(CustomerDto customerDto) {
		return sqlSession.insert("db_customer.insert_byadmin", customerDto);
	}
	
	public CustomerDto login(CustomerDto customerDto) {
		return sqlSession.selectOne("db_customer.login", customerDto);
	}
	
	public int mailConfirm(int no) {
		return sqlSession.update("db_customer.mailconfirm", no);
	}
	
	public int existByEmail(String email) {
		return sqlSession.selectOne("db_customer.existByEmail", email);
	}
	
	public CustomerDto getOne(int no) {
		return sqlSession.selectOne("db_customer.getone",no);
	}
	
	public CustomerDto getOneByName(String name) {
		return sqlSession.selectOne("db_customer.getonebyname",name);
	}
	
	public CustomerDto getOneByEmail(String email) {
		return sqlSession.selectOne("db_customer.getonebyemail",email);
	}

	public List<CustomerDto> getAllList() {
		return sqlSession.selectList("db_customer.alllist");
	}
	
	public List<CustomerDto> findId(CustomerDto customerDto) {
		return sqlSession.selectList("db_customer.findid", customerDto);
	}
	
	public int countSearch(CustomerDto customerDto) {
		if(customerDto.getSearch().equals("designer")) return sqlSession.selectOne("db_customer.count_search_designer", customerDto);
		return sqlSession.selectOne("db_customer.count_search", customerDto);
	}
	
	public List<CustomerDto> getSearchList(int start, int count, CustomerDto customerDto) {
		if(customerDto.getSearch().equals("no")) {
			int intno;
			try {
				intno = Integer.parseInt(customerDto.getKeyword());
				customerDto.setNo(intno);
				return sqlSession.selectList("db_customer.list_one",customerDto);
			} catch(Exception e) {
				return null;
			}
		}
		customerDto.setListstart(start);
		customerDto.setListcount(count);
		if(customerDto.getSearch().equals("designer")) return sqlSession.selectList("db_customer.list_search_designer",customerDto);
		return sqlSession.selectList("db_customer.list_search",customerDto);
	}
	
	public List<CustomerDto> searchInSchedule(CustomerDto customerDto) {
		return sqlSession.selectList("db_customer.search_schedule", customerDto);
	}
	
	public int delete(int no) {
		return sqlSession.delete("db_customer.delete",no);
	}
	
	public int modifyByAdmin(CustomerDto customerDto) {
		return sqlSession.update("db_customer.modifyByAdmin",customerDto);
	}
	
	public int modifyByCustomer(CustomerDto customerDto) {
		return sqlSession.update("db_customer.modifyByCustomer",customerDto);
	}
	
	public int modifyPw(CustomerDto customerDto) {
		return sqlSession.update("db_customer.modifyPw",customerDto);
	}
	
	public int checkPw(CustomerDto customerDto) {
		return sqlSession.selectOne("db_customer.checkpw", customerDto);
	}
	
	public int mileageUse(CustomerDto customerDto) {
		return sqlSession.update("db_customer.mileageuse",customerDto);
	}
	
	public int mileageCharge(CustomerDto customerDto) {
		return sqlSession.update("db_customer.mileagecharge",customerDto);
	}
	
	public int visitcount(int no) {
		return sqlSession.update("db_customer.visitcount", no);
	}
	
	public int loginDeleteDelay(int no) {
		return sqlSession.update("db_customer.logindeletedelay", no);
	}
	
	public int confirmCheck(CustomerDto customerDto) {
		return sqlSession.selectOne("db_customer.checkconfirm", customerDto);
	}
	
	public void dayover() {
		sqlSession.delete("db_customer.dayover");
	}
	
	public void notConfirmOver() {
		sqlSession.delete("db_customer.notconfirmover");
	}
	
	public List<CustomerDto> warningList() {
		return sqlSession.selectList("db_customer.warninglist");
	}
}
