package hairsalon.repository;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import hairsalon.entity.CustomerDto;
import hairsalon.entity.DesignerDto;
import hairsalon.entity.ReservationDto;
import hairsalon.service.VacationService;

@Repository("reservationDao")
public class ReservationDao_Oracle implements ReservationDao {
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private DesignerDao designerDao;
	
	@Autowired
	private VacationService vacationService;
	
	public boolean offdaysCheck(ReservationDto reservationDto) throws ParseException {
		DesignerDto designerDto = designerDao.getOne(reservationDto.getDesigner());
		if(designerDto.getNo()==0) return true;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date d = reservationDto.getWhatday();
		String d_str;
		if(d==null) {
			d = format.parse(reservationDto.getWhatday_str());
			d_str = reservationDto.getWhatday_str();
		} else {
			d_str = format.format(d);
		}
		Calendar c = Calendar.getInstance();
		c.setTime(d);
		int day = c.get(Calendar.DAY_OF_WEEK);
		String day_str = "";
		switch(day) {
		case 1: day_str="일"; break;
		case 2: day_str="월"; break;
		case 3: day_str="화"; break;
		case 4: day_str="수"; break;
		case 5: day_str="목"; break;
		case 6: day_str="금"; break;
		case 7: day_str="토"; break;
		}
		if(designerDto.getOffdays()!=null && designerDto.getOffdays().contains(day_str)) return true;
		else if(vacationService.isVacation(designerDto.getNo(), d_str)>0) return true;
		else return false;
	}
	
	public boolean isOverlapped(ReservationDto reservationDto) {
		int timecheck1 = sqlSession.selectOne("db_reservation.timecheck1", reservationDto);
		int timecheck2 = sqlSession.selectOne("db_reservation.timecheck2", reservationDto);
		int timecheck3 = sqlSession.selectOne("db_reservation.timecheck3", reservationDto);
		int timecheck4 = sqlSession.selectOne("db_reservation.timecheck4", reservationDto);
		int timecheck5 = sqlSession.selectOne("db_reservation.timecheck5", reservationDto);
		if(timecheck1+timecheck2+timecheck3+timecheck4+timecheck5==0) return false;
		else return true;
	}
	
	/**
	 * 결과값
	 * 0: Oracle DB Internal Error.
	 * 1: 정상처리.
	 * 2: 시작시간(starttime)에 시술시간(period)을 더하면 영업종료시간인 10시를 넘겨버림.
	 * 3: 원하는 시간대에 이미 다른 예약이 자리하고 있음.
	 * 4: 해당 디자이너가 그 날 휴무임.
	 * @throws ParseException 
	 */
	public int insert(ReservationDto reservationDto) throws ParseException {
		if(reservationDto.getStarttime()+reservationDto.getPeriod()>2200) return 2;
		int timecheck1 = sqlSession.selectOne("db_reservation.timecheck1", reservationDto);
		int timecheck2 = sqlSession.selectOne("db_reservation.timecheck2", reservationDto);
		int timecheck3 = sqlSession.selectOne("db_reservation.timecheck3", reservationDto);
		int timecheck4 = sqlSession.selectOne("db_reservation.timecheck4", reservationDto);
		int timecheck5 = sqlSession.selectOne("db_reservation.timecheck5", reservationDto);
		if(timecheck1+timecheck2+timecheck3+timecheck4+timecheck5>0) return 3;
		if(this.offdaysCheck(reservationDto)) return 4;
		int result;
		if(reservationDto.getCustomer()==0) {
			result = sqlSession.insert("db_reservation.insert_nonmember", reservationDto);
		} else {
			result = sqlSession.insert("db_reservation.insert_member", reservationDto);
		}
		return result;
	}
	
	/**
	 * 결과값
	 * 0: Oracle DB Internal Error.
	 * 1: 정상처리.
	 */
	public int insertForce(ReservationDto reservationDto) {
		int result;
		if(reservationDto.getCustomer()==0) {
			result = sqlSession.insert("db_reservation.insert_nonmember", reservationDto);
		} else {
			result = sqlSession.insert("db_reservation.insert_member", reservationDto);
		}
		return result;
	}
	
	public int delete(int no) {
		return sqlSession.delete("db_reservation.delete", no);
	}
	
	/**
	 * 결과값
	 * 0: Oracle DB Internal Error.
	 * 1: 정상처리.
	 * 2: 시작시간(starttime)에 시술시간(period)을 더하면 영업종료시간인 10시를 넘겨버림.
	 * 3: 원하는 시간대에 이미 다른 예약이 자리하고 있음.
	 * 4: 해당 디자이너가 그 날 휴무임.
	 * @throws ParseException 
	 */
	public int modify(ReservationDto reservationDto) throws ParseException {
		if(reservationDto.getStarttime()+reservationDto.getPeriod()>2200) return 2;
		int timecheck1 = sqlSession.selectOne("db_reservation.timecheck1", reservationDto);
		int timecheck2 = sqlSession.selectOne("db_reservation.timecheck2", reservationDto);
		int timecheck3 = sqlSession.selectOne("db_reservation.timecheck3", reservationDto);
		int timecheck4 = sqlSession.selectOne("db_reservation.timecheck4", reservationDto);
		int timecheck5 = sqlSession.selectOne("db_reservation.timecheck5", reservationDto);
		if(timecheck1+timecheck2+timecheck3+timecheck4+timecheck5>0) return 3;
		if(this.offdaysCheck(reservationDto)) return 4;
		int result;
		if(reservationDto.getCustomer_name()==null) {
			result = sqlSession.update("db_reservation.modifybycustomer", reservationDto);
		} else {
			result = sqlSession.update("db_reservation.modify", reservationDto);
			
		}
		return result;
	}
	
	/**
	 * 결과값
	 * 0: Oracle DB Internal Error.
	 * 1: 정상처리.
	 */
	public int modifyForce(ReservationDto reservationDto) {
		return sqlSession.update("db_reservation.modify", reservationDto);
	}

	public List<ReservationDto> getAllList() {
		return sqlSession.selectList("db_reservation.alllist");
	}
	
	public List<ReservationDto> getCustomerList(int customer) {
		return sqlSession.selectList("db_reservation.customerlist", customer);
	}
	
	public List<ReservationDto> getListInDate(String whatday) {
		return sqlSession.selectList("db_reservation.listindate", whatday);
	}
	
	public List<ReservationDto> getListToday0() {
		return sqlSession.selectList("db_reservation.listtoday0");
	}
	
	public List<ReservationDto> getListToday1() {
		return sqlSession.selectList("db_reservation.listtoday1");
	}
	
	public ReservationDto getOne(int no) {
		return sqlSession.selectOne("db_reservation.getone", no);
	}
	
	public int receptionTo0(int no) {
		return sqlSession.update("db_reservation.receptionto0", no);
	}
	
	public int receptionTo1(int no) {
		return sqlSession.update("db_reservation.receptionto1", no);
	}
	
	public int dayover() {
		return sqlSession.delete("db_reservation.dayover");
	}
}