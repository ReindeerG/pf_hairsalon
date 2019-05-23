package hairsalon.service;

import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

import hairsalon.entity.CustomerDto;
import hairsalon.entity.HairorderDto;
import hairsalon.repository.CustomerDao;
import hairsalon.repository.HairorderDao;
import hairsalon.repository.ReservationDao;

@Service("hairorderService")
@PropertySource({"classpath:/properties/page.properties"})
public class HairorderService_Oracle implements HairorderService {
	@Autowired
	private HairorderDao hairorderDao;
	
	@Autowired
	private Environment env;
	
	@Autowired
	private ReservationService reservationService;
	
	@Autowired
	private CustomerService customerService;

	@Autowired
	private DesignerService designerService;
	
	@Autowired
	private DesignService designService;

	public int regist(HairorderDto hairorderDto) {
		if(hairorderDto.getPaytype().equals("마일리지")) {
			CustomerDto customerDto = CustomerDto.builder().no(hairorderDto.getCustomer()).mileage(hairorderDto.getFinalprice()).build();
			if(!customerService.mileageEnough(customerDto)) {
				return 0;
			}
		}
		designerService.designcount(hairorderDto.getDesigner());
		int result;
		if(hairorderDto.getCustomer()==0) {
			result = hairorderDao.insert_nonmember(hairorderDto);
		} else {
			result = hairorderDao.insert_member(hairorderDto);
			customerService.visitcount(hairorderDto.getCustomer());
		}
		if(result==1) {
			reservationService.delete(hairorderDto.getReservation());
			if(hairorderDto.getPaytype().equals("마일리지")) customerService.mileageUse(CustomerDto.builder().no(hairorderDto.getCustomer()).mileage(hairorderDto.getFinalprice()).build());
		}
		return result;
	}

	public List<HairorderDto> getAllList() {
		List<HairorderDto> list = hairorderDao.getAllList();
		this.setString(list);
		return list;
	}
	
	private List<HairorderDto> setString(List<HairorderDto> list) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		for(HairorderDto hairorderDto : list) {
			hairorderDto.setWhatday_str(format.format(hairorderDto.getWhatday()));
			if(hairorderDto.getDesigner()!=0) {
				hairorderDto.setDesigner_str(designerService.getOne(hairorderDto.getDesigner()).getName());
			}
			else hairorderDto.setDesigner_str("!");
			if(hairorderDto.getDesign()!=0) {
				hairorderDto.setDesign_str(designService.getOne(hairorderDto.getDesign()).getName());
			}
			else hairorderDto.setDesign_str("???");
		}
		return list;
	}
	
	public int getTotalPagenation(HairorderDto hairorderDto) {
		int total;
		if(hairorderDto.getSearch().equals("no")) total=1;
		else total = hairorderDao.countSearch(hairorderDto);
		int perview = Integer.parseInt(env.getProperty("view.reception"));
		int pagenation = total/perview;
		if(total%perview!=0) pagenation++;
		if(pagenation==0) pagenation=1;
		return pagenation;
	}
	
	public int getMinPagenation(int no) {
		int perpage = Integer.parseInt(env.getProperty("pages.reception"));
		if(no%perpage==0) {
			return ((no/perpage-1)*perpage+1);
		} else return ((no/perpage)*perpage+1);
	}
	
	public int getMaxPagenation(int no, HairorderDto hairorderDto) {
		int perpage = Integer.parseInt(env.getProperty("pages.reception"));
		int result = 0;
		if(no%perpage==0) {
			result = no;
		} else result = (no/perpage+1)*perpage;
		if(result<this.getTotalPagenation(hairorderDto)) return result;
		else return this.getTotalPagenation(hairorderDto);
	}
	
	public int getPrevPagenation(int no) {
		if(no==1) return 0;
		else return this.getMinPagenation(no)-1;
	}
	
	public int getNextPagenation(int no, HairorderDto hairorderDto) {
		if(this.getMaxPagenation(no, hairorderDto)==this.getTotalPagenation(hairorderDto)) return 0;
		else return this.getMaxPagenation(no, hairorderDto)+1;
	}
	
	public List<HairorderDto> getSearchList(int no, HairorderDto hairorderDto) {
		int perview = Integer.parseInt(env.getProperty("view.reception"));
		List<HairorderDto> list = hairorderDao.getSearchList((no-1)*perview+1, perview, hairorderDto);
		return this.setString(list);
	}
}
