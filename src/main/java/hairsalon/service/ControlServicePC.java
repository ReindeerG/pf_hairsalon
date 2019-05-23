package hairsalon.service;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import hairsalon.entity.BoardDto;
import hairsalon.entity.CurrentDate;
import hairsalon.entity.CustomerDto;
import hairsalon.entity.DesignDto;
import hairsalon.entity.DesignerDto;
import hairsalon.entity.HairorderDto;
import hairsalon.entity.QnaDto;
import hairsalon.entity.ReservationDto;
import hairsalon.entity.VacationDto;

@Service
public class ControlServicePC implements ControlService {
	@Autowired
	private CustomerService customerService;
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private DesignerService designerService;
	
	@Autowired
	private DesignService designService;
	
	@Autowired
	private ReservationService reservationService;
	
	@Autowired
	private HairorderService hairorderService;
	
	@Autowired
	private QnaService qnaService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private UploadimageService uploadimageService;
	
	@Autowired
	private VacationService vacationService;
	
	@Autowired
	private EmailService emailService;
	
	public int customerLogin(String email, String pw, HttpSession session) throws NoSuchAlgorithmException {
		return customerService.login(email, pw, session);
	}
	
	public int customerExpr(HttpSession session) {
		return customerService.expr_customer(session);
	}
	
	public CustomerDto customerGetOne(int no) {
		return customerService.getOne(no);
	}
	
	public CustomerDto customerGetOneByName(String name) {
		return customerService.getOneByName(name);
	}
	
	public CustomerDto customerGetOneByEmail(String email) {
		return customerService.getOneByEmail(email);
	}
	
	public int customerSigninSelf(CustomerDto customerDto) throws NoSuchAlgorithmException {
		return customerService.signinSelf(customerDto);
	}
	
	public int customerSigninByAdmin(CustomerDto customerDto) throws NoSuchAlgorithmException {
		return customerService.signinByAdmin(customerDto);
	}
	
	public int adminLogin(String email, String pw, HttpSession session) throws NoSuchAlgorithmException {
		return adminService.login(email, pw, session);
	}
	
	public int adminExpr(HttpSession session) {
		return adminService.expr_admin(session);
	}
	
	public boolean customerExistByEmail(String email) {
		return customerService.existByEmail(email);
	}
	
	public int customerMailConfirm(int no) {
		return customerService.mailConfirm(no);
	}
	
	public int customerMileageCharge(CustomerDto customerDto) {
		return customerService.mileageCharge(customerDto);
	}
	
	public List<CustomerDto> customerGetAllList() {
		return customerService.getAllList();
	}
	
	public List<CustomerDto> customerFindId(CustomerDto customerDto) {
		return customerService.findId(customerDto);
	}
	
	public int customerSendTempPw(int no) throws NoSuchAlgorithmException, MessagingException {
		return customerService.tempPw(no);
	}
	
	public List<CustomerDto> customerGetSearchList(int no, CustomerDto customerDto) {
		return customerService.getSearchList(no, customerDto);
	}
	public int customerGetTotalPagenation(CustomerDto customerDto) { return customerService.getTotalPagenation(customerDto); }
	public int customerGetMinPagenation(int no) { return customerService.getMinPagenation(no); }
	public int customerGetMaxPagenation(int no, CustomerDto customerDto) { return customerService.getMaxPagenation(no,customerDto); }
	public int customerGetPrevPagenation(int no) { return customerService.getPrevPagenation(no); }
	public int customerGetNextPagenation(int no, CustomerDto customerDto) { return customerService.getNextPagenation(no,customerDto); }
	
	public List<DesignerDto> designerGetAllList() {
		return designerService.getAllList();
	}
	
	public List<DesignerDto> designerGetSearchList(DesignerDto designerDto) {
		return designerService.getSearchList(designerDto);
	}
	
	public List<DesignerDto> designerGetOnList() {
		return designerService.getOnList();
	}
	
	public List<DesignDto> designGetAllList() {
		return designService.getAllList();
	}
	
	public List<DesignDto> designGetSearchList(DesignDto designDto) {
		return designService.getSearchList(designDto);
	}
	
	public List<DesignDto> designGetOnList() {
		return designService.getOnList();
	}
	
	public List<DesignDto> designGetListForPage() {
		return designService.getListForPage();
	}
	
	public DesignerDto designerGetOne(int no) {
		return designerService.getOne(no);
	}
	
	public DesignDto designGetOne(int no) {
		return designService.getOne(no);
	}
	
	public int designerRegist(MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException {
		return designerService.regist(mRequest);
	}
	
	public int designRegist(DesignDto designDto) {
		return designService.regist(designDto);
	}
	
	public boolean reservationIsOverlapped(ReservationDto reservationDto) {
		return reservationService.isOverlapped(reservationDto);
	}
	
	public boolean reservationOffdaysCheck(ReservationDto reservationDto) throws ParseException {
		return reservationService.offdaysCheck(reservationDto);
	}
	
	public int reservationErrorCount() throws ParseException {
		return reservationService.getErrorCount();
	}
	
	public List<ReservationDto> reservationErrorList() throws ParseException {
		return reservationService.getErrorList();
	}
	
	public String reservationErrorCountForAjax() throws ParseException {
		return reservationService.getErrorCountForAjax();
	}
	
	public String reservationErrorPanelForAjax() throws ParseException {
		return reservationService.getErrorPanelForAjax();
	}
	
	public int reservationRegist(ReservationDto reservationDto) throws ParseException {
		return reservationService.regist(reservationDto);
	}
	
	public int reservationRegistForce(ReservationDto reservationDto) {
		return reservationService.registForce(reservationDto);
	}
	
	public int reservationDelete(int no) {
		return reservationService.delete(no);
	}
	
	public int reservationModify(ReservationDto reservationDto) throws ParseException {
		return reservationService.modify(reservationDto);
	}
	
	public int reservationModifyForce(ReservationDto reservationDto) {
		return reservationService.modifyForce(reservationDto);
	}
	
	public CurrentDate getTodayInfo() {
		return new CurrentDate();
	}
	
	public List<ReservationDto> reservationGetListInDate(String whatday) {
		return reservationService.getListInDate(whatday);
	}
	
	public List<ReservationDto> reservationGetListToday0() {
		return reservationService.getListToday0();
	}
	
	public List<ReservationDto> reservationGetListToday1() {
		return reservationService.getListToday1();
	}
	
	public List<ReservationDto> reservationGetCustomerList(int customer) {
		return reservationService.getCustomerList(customer);
	}
	
	public ReservationDto reservationGetOne(int no) {
		return reservationService.getOne(no);
	}
	
	public List<CustomerDto> customerSearchInSchedule(CustomerDto customerDto) {
		return customerService.searchInSchedule(customerDto);
	}
	
	public String designerGetTodayOffs(String fulldate) {
		return designerService.getTodayOffs(fulldate);
	}
	
	public int designerModify(MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException {
		return designerService.modify(mRequest);
	}
	
	public int designModify(DesignDto designDto) {
		return designService.modify(designDto);
	}
	
	public int customerModifyByAdmin(CustomerDto customerDto) {
		return customerService.modifyByAdmin(customerDto);
	}
	
	public int customerModifyByCustomer(CustomerDto customerDto) {
		return customerService.modifyByCustomer(customerDto);
	}
	
	public int customerModifyPw(int no, String originpw, String pw) throws NoSuchAlgorithmException {
		return customerService.modifyPw(no, originpw, pw);
	}
	
	public int designerDelete(int no, HttpServletRequest request) {
		return designerService.delete(no, request);
	}
	
	public int designDelete(int no) {
		return designService.delete(no);
	}
	
	public int customerDelete(int no) {
		return customerService.delete(no);
	}
	
	public int reservationReceptionTo0(int no) {
		return reservationService.receptionTo0(no);
	}
	
	public int reservationReceptionTo1(int no) {
		return reservationService.receptionTo1(no);
	}
	
	public int hairorderRegist(HairorderDto hairorderDto) {
		return hairorderService.regist(hairorderDto);
	}
	public List<HairorderDto> hairorderGetAllList() {
		return hairorderService.getAllList();
	}
	public List<HairorderDto> hairorderGetSearchList(int no, HairorderDto hairorderDto) {
		return hairorderService.getSearchList(no, hairorderDto);
	}
	public int hairorderGetTotalPagenation(HairorderDto hairorderDto) { return hairorderService.getTotalPagenation(hairorderDto); }
	public int hairorderGetMinPagenation(int no) { return hairorderService.getMinPagenation(no); }
	public int hairorderGetMaxPagenation(int no, HairorderDto hairorderDto) { return hairorderService.getMaxPagenation(no,hairorderDto); }
	public int hairorderGetPrevPagenation(int no) { return hairorderService.getPrevPagenation(no); }
	public int hairorderGetNextPagenation(int no, HairorderDto hairorderDto) { return hairorderService.getNextPagenation(no,hairorderDto); }
	
	public int qnaNew(QnaDto qnaDto) {
		return qnaService.question_new(qnaDto);
	}
	
	public int qnaAnswer(QnaDto qnaDto) {
		return qnaService.answer(qnaDto);
	}
	
	public int qnaCountNew() {
		return qnaService.countNew();
	}
	
	public List<QnaDto> qnaGetList(int no) {
		return qnaService.getListPagenated(no);
	}
	public int qnaGetTotalPagenation() { return qnaService.getTotalPagenation(); }
	public int qnaGetMinPagenation(int no) { return qnaService.getMinPagenation(no); }
	public int qnaGetMaxPagenation(int no) { return qnaService.getMaxPagenation(no); }
	public int qnaGetPrevPagenation(int no) { return qnaService.getPrevPagenation(no); }
	public int qnaGetNextPagenation(int no) { return qnaService.getNextPagenation(no); }
	public List<QnaDto> qnaGetSearchList(int no, QnaDto qnaDto) {
		return qnaService.getSearchList(no, qnaDto);
	}
	public int qnaGetTotalPagenation(QnaDto qnaDto) { return qnaService.getTotalPagenation(qnaDto); }
	public int qnaGetMaxPagenation(int no, QnaDto qnaDto) { return qnaService.getMaxPagenation(no,qnaDto); }
	public int qnaGetNextPagenation(int no, QnaDto qnaDto) { return qnaService.getNextPagenation(no,qnaDto); }
	public List<QnaDto> qnaGetSearchListForCustomer(int no, QnaDto qnaDto) {
		return qnaService.getSearchListForCustomer(no, qnaDto);
	}
	public int qnaGetTotalPagenationForCustomer(QnaDto qnaDto) { return qnaService.getTotalPagenationForCustomer(qnaDto); }
	public int qnaGetMaxPagenationForCustomer(int no, QnaDto qnaDto) { return qnaService.getMaxPagenationForCustomer(no,qnaDto); }
	public int qnaGetNextPagenationForCustomer(int no, QnaDto qnaDto) { return qnaService.getNextPagenationForCustomer(no,qnaDto); }
	public int boardNextval(HttpServletRequest request) {
		return boardService.nextval(request);
	}
	
	public List<BoardDto> boardGetAllList() {
		return boardService.getAllList();
	}
	
	public List<BoardDto> boardGetSearchList(int no, BoardDto boardDto) {
		return boardService.getSearchList(no, boardDto);
	}
	public int boardGetTotalPagenation(BoardDto boardDto) { return boardService.getTotalPagenation(boardDto); }
	public int boardGetMinPagenation(int no) { return boardService.getMinPagenation(no); }
	public int boardGetMaxPagenation(int no, BoardDto boardDto) { return boardService.getMaxPagenation(no,boardDto); }
	public int boardGetPrevPagenation(int no) { return boardService.getPrevPagenation(no); }
	public int boardGetNextPagenation(int no, BoardDto boardDto) { return boardService.getNextPagenation(no,boardDto); }
	public List<BoardDto> boardGetListForPage(int no, BoardDto boardDto) {
		return boardService.getListForPage(no, boardDto);
	}
	
	public BoardDto boardGetOne(int no) {
		return boardService.getOne(no);
	}
	
	public void boardViewcount(int no) {
		boardService.viewCountUp(no);
	}
	
	public int boardInsert(MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException {
		return boardService.insert(mRequest);
	}
	
	public int boardModify(MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException {
		return boardService.modify(mRequest);
	}
	
	public int boardDelAttach(int no, int file_no, HttpServletRequest request) {
		return boardService.del_attach(no, file_no, request);
	}
	
	public int boardDelete(int no, HttpServletRequest request) {
		return boardService.delete(no, request);
	}
	
	public String uploadimageInsert(MultipartFile mFile, int board_no, HttpServletRequest request) {
		return uploadimageService.insert(mFile, board_no, request);
	}
	
	public List<VacationDto> vacationGetAllList(int designer) {
		return vacationService.getAllList(designer);
	}
	
	public int vacationIsExist(int no, int designer, String vac_str) {
		return vacationService.isExist(no, designer, vac_str);
	}
	
	public int vacationInsert(VacationDto vacationDto) {
		return vacationService.insert(vacationDto);
	}
	
	public int vacationModify(VacationDto vacationDto) {
		return vacationService.modify(vacationDto);
	}
	
	public int vacationDelete(int no) {
		return vacationService.delete(no);
	}
	
	public void emailSendConfirm(String email, HttpServletRequest request) throws MessagingException {
		emailService.sendConfirmMail(email, request);
	}
	
	public boolean customerConfirm(int no, String confirmcode) {
		return customerService.confirm(no, confirmcode);
	}
	
	public String ajaxCurrentTime() {
		CurrentDate cdate = new CurrentDate();
		return "date_"+cdate.getStr1()+"time_"+cdate.getNumtime()+"end_";
	}
}