package hairsalon.service;

import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpSession;

import hairsalon.entity.CustomerDto;
import hairsalon.entity.DesignerDto;
import hairsalon.entity.ReservationDto;

public interface ReservationService {
	boolean isOverlapped(ReservationDto reservationDto);
	boolean offdaysCheck(ReservationDto reservationDto) throws ParseException;
	int regist(ReservationDto reservationDto) throws ParseException;
	int registForce(ReservationDto reservationDto);
	int delete(int no);
	int modify(ReservationDto reservationDto) throws ParseException;
	int modifyForce(ReservationDto reservationDto);
	int getErrorCount() throws ParseException;
	List<ReservationDto> getErrorList() throws ParseException;
	String getErrorCountForAjax() throws ParseException;
	public String getErrorPanelForAjax() throws ParseException;
	List<ReservationDto> getListInDate(String whatday);
	ReservationDto getOne(int no);
	List<ReservationDto> getListToday0();
	List<ReservationDto> getListToday1();
	List<ReservationDto> getCustomerList(int customer);
	int receptionTo0(int no);
	int receptionTo1(int no);
	int dayover();
}