package hairsalon.repository;

import java.util.List;

import hairsalon.entity.BoardDto;
import hairsalon.entity.CustomerDto;

public interface CustomerDao {
	int insertSelf(CustomerDto customerDto);
	int insertByAdmin(CustomerDto customerDto);
	CustomerDto login(CustomerDto customerDto);
	int mailConfirm(int no);
	int existByEmail(String email);
	List<CustomerDto> getAllList();
	List<CustomerDto> findId(CustomerDto customerDto);
	int countSearch(CustomerDto customerDto);
	List<CustomerDto> getSearchList(int start, int count, CustomerDto customerDto);
	List<CustomerDto> searchInSchedule(CustomerDto customerDto);
	int delete(int no);
	int modifyByAdmin(CustomerDto customerDto);
	int modifyByCustomer(CustomerDto customerDto);
	int modifyPw(CustomerDto customerDto);
	int checkPw(CustomerDto customerDto);
	CustomerDto getOne(int no);
	CustomerDto getOneByName(String name);
	CustomerDto getOneByEmail(String email);
	int mileageUse(CustomerDto customerDto);
	int mileageCharge(CustomerDto customerDto);
	int visitcount(int no);
	int loginDeleteDelay(int no);
	int confirmCheck(CustomerDto customerDto);
	void dayover();
	void notConfirmOver();
	List<CustomerDto> warningList();
}
