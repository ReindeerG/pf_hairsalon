package hairsalon.repository;

import java.text.ParseException;
import java.util.List;

import hairsalon.entity.CustomerDto;
import hairsalon.entity.DesignerDto;
import hairsalon.entity.ReservationDto;

public interface ReservationDao {
	boolean offdaysCheck(ReservationDto reservationDto) throws ParseException;
	boolean isOverlapped(ReservationDto reservationDto);
	int insert(ReservationDto reservationDto) throws ParseException;
	int insertForce(ReservationDto reservationDto);
	int delete(int no);
	int modify(ReservationDto reservationDto) throws ParseException;
	int modifyForce(ReservationDto reservationDto);
	List<ReservationDto> getAllList();
	List<ReservationDto> getCustomerList(int customer);
	List<ReservationDto> getListInDate(String whatday);
	ReservationDto getOne(int no);
	List<ReservationDto> getListToday0();
	List<ReservationDto> getListToday1();
	int receptionTo0(int no);
	int receptionTo1(int no);
	int dayover();
}
