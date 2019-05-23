package hairsalon.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import hairsalon.entity.CustomerDto;
import hairsalon.entity.DesignDto;
import hairsalon.entity.DesignerDto;
import hairsalon.entity.ReservationDto;
import hairsalon.repository.CustomerDao;
import hairsalon.repository.DesignDao;
import hairsalon.repository.DesignerDao;
import hairsalon.repository.ReservationDao;

@Service("reservationService")
public class ReservationService_Oracle implements ReservationService {
	@Autowired
	private ReservationDao reservationDao;
	
	@Autowired
	private DesignerService designerService;
	
	@Autowired
	private DesignService designService;
	
	@Autowired
	private CustomerDao customerDao;
	
	public boolean offdaysCheck(ReservationDto reservationDto) throws ParseException {
		return reservationDao.offdaysCheck(reservationDto);
	}
	
	public boolean isOverlapped(ReservationDto reservationDto) {
		return reservationDao.isOverlapped(reservationDto);
	}
	
	public int regist(ReservationDto reservationDto) throws ParseException {
		return reservationDao.insert(reservationDto);
	}
	
	public int registForce(ReservationDto reservationDto) {
		return reservationDao.insertForce(reservationDto);
	}
	
	public int delete(int no) {
		return reservationDao.delete(no);
	}
	
	public int modify(ReservationDto reservationDto) throws ParseException {
		return reservationDao.modify(reservationDto);
	}
	
	public int modifyForce(ReservationDto reservationDto) {
		return reservationDao.modifyForce(reservationDto);
	}
	
	public List<ReservationDto> getListInDate(String whatday) {
		return reservationDao.getListInDate(whatday);
	}
	
	public ReservationDto getOne(int no) {
		return reservationDao.getOne(no);
	}
	
	public int receptionTo0(int no) {
		return reservationDao.receptionTo0(no);
	}
	
	public int receptionTo1(int no) {
		return reservationDao.receptionTo1(no);
	}
	
	public int getErrorCount() throws ParseException {
		List<ReservationDto> errorList = this.getErrorList();
		return errorList.size();
	}
	
	public List<ReservationDto> getErrorList() throws ParseException {
		List<ReservationDto> allList = reservationDao.getAllList();
		List<ReservationDto> result = new ArrayList<>();
		for(ReservationDto reservationDto : allList) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			reservationDto.setWhatday_str(format.format(reservationDto.getWhatday()));
			if(this.offdaysCheck(reservationDto)) result.add(reservationDto);
			else if(this.isOverlapped(reservationDto)) result.add(reservationDto);
		}
		result = this.setString(result);
		for(ReservationDto reservationDto : result) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy년 MM월 dd일(E)");
			reservationDto.setWhatday_str(format.format(reservationDto.getWhatday()));
		}
		return result;
	}
	
	public String getErrorCountForAjax() throws ParseException {
		int count = this.getErrorCount();
		if(count==0) {
			return "<span class='badge hidden' id='num_error'></span>";
		} else {
			return "<span class='badge' id='num_error'>"+count+"</span>";
		}
	}
	
	public String getErrorPanelForAjax() throws ParseException {
		List<ReservationDto> errorList = this.getErrorList();
		StringBuilder builder = new StringBuilder();
		if(errorList.size()==0) {
			builder.append("<div class='col-md-12 font-1.5rem hidden' id='notice'>");
		} else {
			builder.append("<div class='col-md-12 font-1.5rem' id='notice'>");
		}
		builder.append("<div class='panel panel-danger'>");
		builder.append("<div class='panel-heading'>");
		builder.append("<h3 class='panel-title'>"+errorList.size()+"개의 수정사항이 있습니다!</h3>");
		builder.append("</div>");
		builder.append("<div class='panel-body'>");
		for(ReservationDto reservationDto : errorList) {
			builder.append("<p>");
			builder.append(reservationDto.getWhatday_str()+" "+reservationDto.getCustomer_name()+"님의 "+reservationDto.getStarttime_str()+"~"+reservationDto.getEndtime_str()+" 예약이 수정되어야 합니다.");
			builder.append("</p>");
		}
		builder.append("</div>");
		builder.append("</div>");
		builder.append("</div>");
		return builder.toString();
	}
	
	public List<ReservationDto> getListToday0() {
		List<ReservationDto> list = reservationDao.getListToday0();
		return this.setString(list);
	}
	
	public List<ReservationDto> getListToday1() {
		List<ReservationDto> list = reservationDao.getListToday1();
		list = this.setString(list);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		for(ReservationDto reservationDto : list) {
			if(reservationDto.getDesign()!=0) {
				DesignDto designDto = designService.getOne(reservationDto.getDesign());
				reservationDto.setPrice(designDto.getPrice());
			}
			if(reservationDto.getCustomer()!=0) {
				CustomerDto customerDto = customerDao.getOne(reservationDto.getCustomer());
				reservationDto.setCustomer_birth_str(format.format(customerDto.getBirth()));
			} else {
				reservationDto.setCustomer_birth_str("(비회원)");
			}
		}
		return list;
	}
	
	public List<ReservationDto> getCustomerList(int customer) {
		List<ReservationDto> list = reservationDao.getCustomerList(customer);
		return this.setString(list);
	}
	
	private List<ReservationDto> setString(List<ReservationDto> list) {
		for(ReservationDto reservationDto : list) {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			reservationDto.setWhatday_str(format.format(reservationDto.getWhatday()));
			int time = reservationDto.getStarttime();
			String time_str;
			boolean am = false;
			if(time<1200) am=true;
			if(time>1250) time-=1200;
			if(time<1000) time_str = "0"+time;
			else time_str = String.valueOf(time);
			if(time_str.substring(2,4).equals("50")) time_str = time_str.substring(0,2)+"30";
			if(am==true) {
				time_str = "오전 "+time_str.substring(0,2)+":"+time_str.substring(2,4);
			} else {
				time_str = "오후 "+time_str.substring(0,2)+":"+time_str.substring(2,4);
			}
			reservationDto.setStarttime_str(time_str);
			
			time = reservationDto.getStarttime()+reservationDto.getPeriod();
			time_str = new String();
			if(time<1200) am=true;
			else am=false;
			if(time>1250) time-=1200;
			if(time<1000) time_str = "0"+time;
			else time_str = String.valueOf(time);
			if(time_str.substring(2,4).equals("50")) time_str = time_str.substring(0,2)+"30";
			if(am==true) {
				time_str = "오전 "+time_str.substring(0,2)+":"+time_str.substring(2,4);
			} else {
				time_str = "오후 "+time_str.substring(0,2)+":"+time_str.substring(2,4);
			}
			reservationDto.setEndtime_str(time_str);
			
			if(reservationDto.getDesigner()!=0) {
				DesignerDto designerDto = designerService.getOne(reservationDto.getDesigner());
				reservationDto.setDesigner_str(designerDto.getName());
			} else {
				reservationDto.setDesigner_str("수정필요!");
			}
			
			if(reservationDto.getDesign()!=0) {
				DesignDto designDto = designService.getOne(reservationDto.getDesign());
				reservationDto.setDesign_str(designDto.getName());
			} else {
				reservationDto.setDesign_str("???");
			}
		}
		return list;
	}
	
	public int dayover() {
		return reservationDao.dayover();
	}
}
