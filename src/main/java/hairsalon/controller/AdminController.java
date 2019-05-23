package hairsalon.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import hairsalon.entity.BoardDto;
import hairsalon.entity.CurrentDate;
import hairsalon.entity.CustomerDto;
import hairsalon.entity.DesignDto;
import hairsalon.entity.DesignerDto;
import hairsalon.entity.HairorderDto;
import hairsalon.entity.QnaDto;
import hairsalon.entity.ReservationDto;
import hairsalon.entity.VacationDto;
import hairsalon.service.ControlService;
import hairsalon.service.ControlServicePC;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	private ControlServicePC controlServicePC;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@ExceptionHandler
	public String ehandle(Exception e) throws UnsupportedEncodingException {
		log.error("예외 발생", e);
		return "redirect:/alert?msg="+URLEncoder.encode("예외가 발생했습니다. 로그를 참조하세요.","UTF-8")+"&tordr=/admin/reception";
	}
	
	@RequestMapping("/sidebar")
	public String sidebar(HttpServletRequest request) throws ParseException {
		request.setAttribute("num_qna", controlServicePC.qnaCountNew());
		request.setAttribute("num_error", controlServicePC.reservationErrorCount());
		return "/admin/sidebar";
	}
	
	@GetMapping("/customer/mailconfirm")
	public String mailconfirm(@RequestParam(required=true) int no,
								@RequestParam(required=false) String page,
								@RequestParam(required=false) String sort,
								@RequestParam(required=false) String search,
								@RequestParam(required=false) String keyword) throws UnsupportedEncodingException {
		controlServicePC.customerMailConfirm(no);
		StringBuilder builder = new StringBuilder();
		if(page!=null) builder.append("&page="+page);
		if(sort!=null) builder.append("&sort="+sort);
		if(search!=null) builder.append("&search="+search);
		if(keyword!=null) builder.append("&keyword="+URLEncoder.encode(keyword,"UTF-8"));
		return "redirect:/admin/customer?"+builder.toString();
	}
	
	@PostMapping("/temppw")
	public String temppw(@RequestParam int no) throws UnsupportedEncodingException, NoSuchAlgorithmException, MessagingException {
		controlServicePC.customerSendTempPw(no);
		return "redirect:/alert?msg="+URLEncoder.encode("임시암호가 발급되었습니다.","UTF-8")+"&tordr=/admin/customer";
	}
	
	@GetMapping("/customer")
	public String customer(@RequestParam(required=false) String page,
							@RequestParam(required=false) String sort,
							@RequestParam(required=false) String search,
							@RequestParam(required=false) String keyword,
							HttpServletRequest request) {
		if(page==null) return "redirect:/admin/customer?page=1";
		try {
			int intpage = Integer.parseInt(page);
			if(intpage<=0) return "redirect:/admin/customer?page=1";
			else {
				CustomerDto customerDto = new CustomerDto();
				if(search!=null && keyword!=null) {
					switch(search) {
					case "name":
					case "phone":
					case "email":
					case "designer":
					case "no": customerDto.setSearch(search); customerDto.setKeyword(keyword); break;
					default: customerDto.setSearch("name"); customerDto.setKeyword(""); break;
					}
				} else {
					customerDto.setSearch("name"); customerDto.setKeyword("");
				}
				if(sort!=null) {
					switch(sort) {
					case "no":
					case "reg":
					case "visitcount":
					case "designer":
					case "latestdate":
					case "deletedate": customerDto.setSort(sort); break;
					default: customerDto.setSort("no"); break;
					}
				} else {
					customerDto.setSort("no");
				}
				if(intpage>controlServicePC.customerGetTotalPagenation(customerDto)) return "redirect:/admin/customer?page=1";
				request.setAttribute("num_qna", controlServicePC.qnaCountNew());
				request.setAttribute("num_error", controlServicePC.reservationErrorCount());
				request.setAttribute("list", controlServicePC.customerGetSearchList(intpage, customerDto));
				request.setAttribute("ondesignerlist", controlServicePC.designerGetOnList());
				request.setAttribute("pagenationcurrent",intpage);
				request.setAttribute("pagenationmin",controlServicePC.customerGetMinPagenation(intpage));
				request.setAttribute("pagenationmax",controlServicePC.customerGetMaxPagenation(intpage, customerDto));
				request.setAttribute("pagenationprev",controlServicePC.customerGetPrevPagenation(intpage));
				request.setAttribute("pagenationnext",controlServicePC.customerGetNextPagenation(intpage, customerDto));
				return "/admin/customer";
			}
		} catch(Exception e) {
			e.printStackTrace();
			return "redirect:/admin/customer?page=1";
		}
	}
	
	@PostMapping("/customer/new")
	public String customer_new(@ModelAttribute CustomerDto customerDto) throws NoSuchAlgorithmException {
		controlServicePC.customerSigninByAdmin(customerDto);
		return "redirect:/admin/customer";
	}
	
	@PostMapping("/customer/mod")
	public String customer_mod(@ModelAttribute CustomerDto customerDto) {
		controlServicePC.customerModifyByAdmin(customerDto);
		return "redirect:/admin/customer";
	}
	
	@GetMapping("/customer/del")
	public String customer_del(@RequestParam int no) {
		controlServicePC.customerDelete(no);
		return "redirect:/admin/customer";
	}
	
	@RequestMapping("/designer")
	public String designer(@RequestParam(required=false) String sort,
							@RequestParam(required=false) String search,
							@RequestParam(required=false) String keyword,
							HttpServletRequest request) throws ParseException {
		DesignerDto designerDto = new DesignerDto();
		if(search!=null && keyword!=null) {
			switch(search) {
			case "name":
			case "grade":
			case "offdays": designerDto.setSearch(search); designerDto.setKeyword(keyword); break;
			default: designerDto.setSearch("name"); designerDto.setKeyword(""); break;
			}
		} else {
			designerDto.setSearch("name"); designerDto.setKeyword("");
		}
		if(sort!=null) {
			switch(sort) {
			case "no":
			case "name":
			case "gender":
			case "grade":
			case "isvacation":
			case "isonoff":
			case "signindate":
			case "designcount": designerDto.setSort(sort); break;
			default: designerDto.setSort("no"); break;
			}
		} else {
			designerDto.setSort("no");
		}
		request.setAttribute("num_qna", controlServicePC.qnaCountNew());
		request.setAttribute("num_error", controlServicePC.reservationErrorCount());
		request.setAttribute("list", controlServicePC.designerGetSearchList(designerDto));
		return "/admin/designer";
	}
	
	@PostMapping("/designer/new")
	public String designer_new(MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException {
		controlServicePC.designerRegist(mRequest);
		return "redirect:/admin/designer";
	}
	
	@PostMapping("/designer/mod")
	public String designer_mod(MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException {
		controlServicePC.designerModify(mRequest);
		return "redirect:/admin/designer";
	}
	
	@GetMapping("/designer/del")
	public String designer_del(@RequestParam int no, HttpServletRequest request) {
		controlServicePC.designerDelete(no, request);
		return "redirect:/admin/designer";
	}
	
	@RequestMapping("/design")
	public String design(@RequestParam(required=false) String sort,
							@RequestParam(required=false) String search,
							@RequestParam(required=false) String keyword,
							HttpServletRequest request) throws ParseException {
		DesignDto designDto = new DesignDto();
		if(search!=null && keyword!=null) {
			switch(search) {
			case "name":
			case "type": designDto.setSearch(search); designDto.setKeyword(keyword); break;
			default: designDto.setSearch("name"); designDto.setKeyword(""); break;
			}
		} else {
			designDto.setSearch("name"); designDto.setKeyword("");
		}
		if(sort!=null) {
			switch(sort) {
			case "no":
			case "type":
			case "price":
			case "maxtime":
			case "isonoff": designDto.setSort(sort); break;
			default: designDto.setSort("no"); break;
			}
		} else {
			designDto.setSort("no");
		}
		request.setAttribute("num_qna", controlServicePC.qnaCountNew());
		request.setAttribute("num_error", controlServicePC.reservationErrorCount());
		request.setAttribute("list", controlServicePC.designGetSearchList(designDto));
		return "/admin/design";
	}
	
	@PostMapping("/design/new")
	public String design_new(@ModelAttribute DesignDto designDto) {
		controlServicePC.designRegist(designDto);
		return "redirect:/admin/design";
	}
	
	@GetMapping("/design/del")
	public String design_del(@RequestParam int no) {
		controlServicePC.designDelete(no);
		return "redirect:/admin/design";
	}
	
	@PostMapping("/design/mod")
	public String design_mod(@ModelAttribute DesignDto designDto) {
		controlServicePC.designModify(designDto);
		return "redirect:/admin/design";
	}
	
	@GetMapping("/schedule")
	public String schedule(@RequestParam(required=false) String set, HttpServletRequest request) throws ParseException {
		request.setAttribute("num_qna", controlServicePC.qnaCountNew());
		request.setAttribute("num_error", controlServicePC.reservationErrorCount());
		request.setAttribute("errorlist", controlServicePC.reservationErrorList());
		request.setAttribute("designerlist", controlServicePC.designerGetOnList());
		request.setAttribute("designlist", controlServicePC.designGetOnList());
		request.setAttribute("currentdate", controlServicePC.getTodayInfo());
		if(set!=null && set.equals("today")) {
			CurrentDate d = new CurrentDate();
			request.setAttribute("setToday", d.getStr2());
		}
		String host = request.getHeader("Host");
		request.setAttribute("host", host);
		return "/admin/schedule";
	}
	
	@PostMapping("/schedule/ajax_offdays")
	public String schedule_offdays(@RequestParam String selecteddate, HttpServletResponse response) throws IOException {
		String result = controlServicePC.designerGetTodayOffs(selecteddate);
		response.setContentType("text/plain; charset=UTF-8");
		response.getWriter().print(result);
		return null;
	}
	
	@PostMapping("/schedule/ajax_list")
	public String schedule_list(@RequestParam String selecteddate, HttpServletResponse response) throws IOException, ParseException {
		String whatday = selecteddate.substring(0,10);
		List<ReservationDto> list = controlServicePC.reservationGetListInDate(whatday);
		StringBuilder builder = new StringBuilder();
		for(ReservationDto reservationDto : list) {
			reservationDto.setWhatday_str(whatday);
			String modplz="";
			int starttime = reservationDto.getStarttime();
			String starttime_str;
			if(starttime<1000) starttime_str = "0"+starttime;
			else starttime_str = String.valueOf(starttime);
			int period = reservationDto.getPeriod()/50;
			DesignDto designDto = null;
			if(reservationDto.getDesign()!=0) {
				designDto = controlServicePC.designGetOne(reservationDto.getDesign());
			}
			int designer = reservationDto.getDesigner();
			String designer_str;
			if(designer==0) {
				designer_str = "z";
				modplz = "modplz";
			}else {
				designer_str = String.valueOf(designer);
				DesignerDto designerDto = controlServicePC.designerGetOne(designer);
				if(designerDto.getIsonoff()==0) modplz = "modplz";
				if(controlServicePC.reservationOffdaysCheck(reservationDto)) modplz = "modplz";
			}
			if(controlServicePC.reservationIsOverlapped(reservationDto)) modplz = "modplz";
			builder.append("<button class='btn btn-case font-nbgl fortimetable "+modplz+"' id='btn-res_n"+reservationDto.getNo()+"_d"+designer_str+"_s"+starttime_str+"_p"+period+"_t"+reservationDto.getState()+"'>");
			builder.append("<p>"+reservationDto.getCustomer_name()+"("+reservationDto.getCustomer_gender()+")<p>");
			String phone;
			if(reservationDto.getCustomer_phone()==null) phone="";
			else phone = reservationDto.getCustomer_phone();
			builder.append("<p>"+phone+"<p>");
			if(designDto==null) {
				builder.append("<p>???<p>");
			} else {
				builder.append("<p>"+designDto.getName()+"<p>");
			}
			builder.append("</button>");
		}
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print(builder);
		return null;
	}
	
	@PostMapping("/schedule/ajax_get")
	public String schedule_get(@RequestParam int no, HttpServletResponse response) throws IOException {
		ReservationDto reservationDto = controlServicePC.reservationGetOne(no);
		StringBuilder builder = new StringBuilder();
		builder.append("_no"+reservationDto.getNo());
		builder.append("_customer"+reservationDto.getCustomer());
		builder.append("_name"+reservationDto.getCustomer_name());
		builder.append("_gender"+reservationDto.getCustomer_gender());
		builder.append("_phone"+reservationDto.getCustomer_phone());
		builder.append("_designer"+reservationDto.getDesigner());
		builder.append("_menu"+reservationDto.getDesign());
		builder.append("_start"+reservationDto.getStarttime());
		builder.append("_period"+reservationDto.getPeriod());
		builder.append("_end");
		response.setContentType("text/plain; charset=UTF-8");
		response.getWriter().print(builder);
		return null;
	}
	
	@PostMapping("/schedule/ajax_new")
	public String schedule_new(
								@RequestParam String whatday_str,
								@RequestParam String customer_str,
								@RequestParam String customer_name,
								@RequestParam String customer_gender,
								@RequestParam String customer_phone,
								@RequestParam int designer,
								@RequestParam int design,
								@RequestParam int starttime,
								@RequestParam int force,
								HttpServletResponse response) throws IOException, ParseException {
		int customer = 0;
		if(!customer_str.equals("")) customer = Integer.parseInt(customer_str);
		DesignDto designDto = controlServicePC.designGetOne(design);
		int period = designDto.getMaxtime_hour()*100;
		if(designDto.getMaxtime_min()==30) period+=50;
		ReservationDto reservationDto = ReservationDto.builder().whatday_str(whatday_str).customer(customer).customer_name(customer_name).customer_gender(customer_gender).customer_phone(customer_phone).designer(designer).design(design).starttime(starttime).period(period).build();
		int result = 0;
		if(force==1) {
			result = controlServicePC.reservationRegistForce(reservationDto);
		} else {
			result = controlServicePC.reservationRegist(reservationDto);
		}
		response.setContentType("text/plain; charset=UTF-8");
		response.getWriter().print(result);
		return null;
	}
	
	@PostMapping("/schedule/ajax_del")
	public String schedule_del(
								@RequestParam int no,
								HttpServletResponse response) throws IOException {
		int result = controlServicePC.reservationDelete(no);
		String result_str;
		if(result==1) result_str="Y";
		else result_str="N";
		response.setContentType("text/plain; charset=UTF-8");
		response.getWriter().print(result_str);
		return null;
	}
	
	@PostMapping("/schedule/ajax_mod")
	public String schedule_mod(
								@RequestParam int no,
								@RequestParam String customer_str,
								@RequestParam String customer_name,
								@RequestParam String customer_gender,
								@RequestParam String customer_phone,
								@RequestParam int designer,
								@RequestParam int design,
								@RequestParam String whatday_str,
								@RequestParam int starttime,
								@RequestParam int force,
								HttpServletResponse response) throws IOException, ParseException {
		int customer = 0;
		if(!customer_str.equals("")) customer = Integer.parseInt(customer_str);
		DesignDto designDto = controlServicePC.designGetOne(design);
		int period = designDto.getMaxtime_hour()*100;
		if(designDto.getMaxtime_min()==30) period+=50;
		ReservationDto reservationDto = ReservationDto.builder().no(no).whatday_str(whatday_str).customer(customer).customer_name(customer_name).customer_gender(customer_gender).customer_phone(customer_phone).designer(designer).design(design).starttime(starttime).period(period).build();
		int result = 0;
		if(force==1) {
			result = controlServicePC.reservationModifyForce(reservationDto);
		} else {
			result = controlServicePC.reservationModify(reservationDto);
		}
		response.setContentType("text/plain; charset=UTF-8");
		response.getWriter().print(result);
		return null;
	}
	
	@PostMapping("/schedule/ajax_search")
	public String schedule_search(@RequestParam String name, @RequestParam String phone, HttpServletResponse response) throws IOException {
		CustomerDto customerDto = CustomerDto.builder().name(name).phone(phone).build();
		List<CustomerDto> list = controlServicePC.customerSearchInSchedule(customerDto);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		StringBuilder builder = new StringBuilder();
		builder.append("<table class='table table-striped table-bordered table-hover table-search'>");
		builder.append("<tr><th>이름</th><th>성</th><th>연락처</th><th>생일</th><th>담당</th></tr>");
		for(CustomerDto customer : list) {
			String designer;
			if(customer.getDesigner()!=0) {
				designer = controlServicePC.designerGetOne(customer.getDesigner()).getName();
			} else {
				designer = "-";
			}
			customer.setBirth_str(format.format(customer.getBirth()));
			builder.append("<tr class='tr_new' id='trsearch_no"+customer.getNo()+"_name"+customer.getName()+"_gender"+customer.getGender()+"_phone"+customer.getPhone()+"_designer"+customer.getDesigner()+"_end'>");
			builder.append("<td>"+customer.getName()+"</td>");
			if(customer.getGender().equals("남")) {
				builder.append("<td class='gender-m'>");
			} else {
				builder.append("<td class='gender-f'>");
			}
			builder.append(customer.getGender()+"</td>");
			builder.append("<td>"+customer.getPhone()+"</td>");
			builder.append("<td>"+customer.getBirth_str()+"</td>");
			builder.append("<td>"+designer+"</td>");
			builder.append("</tr>");
		}
		builder.append("</table>");
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print(builder);
		return null;
	}
	
	@PostMapping("/schedule/ajax_errorcount")
	public String schedule_ajax_count(HttpServletResponse response) throws ParseException, IOException {
		String result = controlServicePC.reservationErrorCountForAjax();
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print(result);
		return null;
	}
	
	@PostMapping("/schedule/ajax_errorpanel")
	public String schedule_ajax_panel(HttpServletResponse response) throws ParseException, IOException {
		String result = controlServicePC.reservationErrorPanelForAjax();
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print(result);
		return null;
	}
	
	@PostMapping("/schedule/ajax_time")
	public String schedule_get(HttpServletResponse response) throws IOException {
		response.setContentType("text/plain; charset=UTF-8");
		response.getWriter().print(controlServicePC.ajaxCurrentTime());
		return null;
	}
	
	@RequestMapping("/reception")
	public String reception(HttpServletRequest request) throws ParseException {
		request.setAttribute("num_qna", controlServicePC.qnaCountNew());
		request.setAttribute("num_error", controlServicePC.reservationErrorCount());
		CurrentDate d = new CurrentDate();
		request.setAttribute("todayinfo", d.getStr3());
		request.setAttribute("reservationList0",controlServicePC.reservationGetListToday0());
		request.setAttribute("reservationList1",controlServicePC.reservationGetListToday1());
		request.setAttribute("designerlist", controlServicePC.designerGetOnList());
		request.setAttribute("designlist", controlServicePC.designGetOnList());
		return "/admin/reception";
	}
	
	@RequestMapping("/reception/list")
	public String reception_list(@RequestParam(required=false) String page,
									@RequestParam(required=false) String sort,
									@RequestParam(required=false) String search,
									@RequestParam(required=false) String keyword,
									HttpServletRequest request) {
		if(page==null) return "redirect:/admin/reception/list?page=1";
		try {
			int intpage = Integer.parseInt(page);
			if(intpage<=0) return "redirect:/admin/reception/list?page=1";
			else {
				HairorderDto hairorderDto = new HairorderDto();
				if(search!=null && keyword!=null) {
					switch(search) {
					case "whatday":
					case "customer_name":
					case "customer_phone":
					case "designer":
					case "paytype":
					case "memo":
					case "design":
					case "customer_gender":
					case "customer":
					case "no": hairorderDto.setSearch(search); hairorderDto.setKeyword(keyword); break;
					default: hairorderDto.setSearch("paytype"); hairorderDto.setKeyword(""); break;
					}
				} else {
					hairorderDto.setSearch("paytype"); hairorderDto.setKeyword("");
				}
				if(sort!=null) {
					switch(sort) {
					case "no":
					case "whatday":
					case "customer":
					case "customer_gender":
					case "designer":
					case "design":
					case "price":
					case "finalprice":
					case "paytype": hairorderDto.setSort(sort); break;
					default: hairorderDto.setSort("no"); break;
					}
				} else {
					hairorderDto.setSort("no");
				}
				if(intpage>controlServicePC.hairorderGetTotalPagenation(hairorderDto)) return "redirect:/admin/customer?page=1";
				request.setAttribute("num_qna", controlServicePC.qnaCountNew());
				request.setAttribute("num_error", controlServicePC.reservationErrorCount());
				request.setAttribute("list", controlServicePC.hairorderGetSearchList(intpage, hairorderDto));
				request.setAttribute("pagenationcurrent",intpage);
				request.setAttribute("pagenationmin",controlServicePC.hairorderGetMinPagenation(intpage));
				request.setAttribute("pagenationmax",controlServicePC.hairorderGetMaxPagenation(intpage, hairorderDto));
				request.setAttribute("pagenationprev",controlServicePC.hairorderGetPrevPagenation(intpage));
				request.setAttribute("pagenationnext",controlServicePC.hairorderGetNextPagenation(intpage, hairorderDto));
				return "/admin/reception_list";
			}
		} catch(Exception e) {
			e.printStackTrace();
			return "redirect:/admin/reception/list?page=1";
		}
	}
	
	@PostMapping("/reception/to0")
	public String reception_to0(@RequestParam int no) {
		controlServicePC.reservationReceptionTo0(no);
		return "redirect:/admin/reception";
	}
	
	@PostMapping("/reception/to1")
	public String reception_to1(@RequestParam int no) {
		controlServicePC.reservationReceptionTo1(no);
		return "redirect:/admin/reception";
	}
	
	@PostMapping("/reception/ajax_mileage")
	public String reception_mileage(@RequestParam int no, HttpServletResponse response) throws IOException {
		CustomerDto customerDto = controlServicePC.customerGetOne(no);
		String result = "";
		if(customerDto==null) result = "(비회원)";
		else {
			result = String.valueOf(customerDto.getMileage());
		}
		response.setContentType("text/plain; charset=UTF-8");
		response.getWriter().print(result);
		return null;
	}
	
	@PostMapping("/reception/pay")
	public String reception_pay(@ModelAttribute HairorderDto hairorderDto) {
		int result = controlServicePC.hairorderRegist(hairorderDto);
		return "redirect:/admin/reception";
	}
	
	@GetMapping("/qna")
	public String qna(@RequestParam(required=false) String page,
						@RequestParam(required=false) String search,
						@RequestParam(required=false) String keyword,
						HttpServletRequest request) {
		if(page==null) return "redirect:/admin/qna?page=1";
		try {
			int intpage = Integer.parseInt(page);
			if(intpage<=0) return "redirect:/admin/qna?page=1";
			else {
				QnaDto qnaDto = new QnaDto();
				if(search!=null && keyword!=null) {
					switch(search) {
					case "question":
					case "customer_name":
					case "customer_no":
					case "answer":
					case "no": qnaDto.setSearch(search); qnaDto.setKeyword(keyword); break;
					default: qnaDto.setSearch("question"); qnaDto.setKeyword(""); break;
					}
					if(intpage>controlServicePC.qnaGetTotalPagenation(qnaDto)) return "redirect:/admin/qna?page=1";
					request.setAttribute("num_qna", controlServicePC.qnaCountNew());
					request.setAttribute("num_error", controlServicePC.reservationErrorCount());
					request.setAttribute("list", controlServicePC.qnaGetSearchList(intpage, qnaDto));
					request.setAttribute("pagenationcurrent",intpage);
					request.setAttribute("pagenationmin",controlServicePC.qnaGetMinPagenation(intpage));
					request.setAttribute("pagenationmax",controlServicePC.qnaGetMaxPagenation(intpage, qnaDto));
					request.setAttribute("pagenationprev",controlServicePC.qnaGetPrevPagenation(intpage));
					request.setAttribute("pagenationnext",controlServicePC.qnaGetNextPagenation(intpage, qnaDto));
				} else {
					if(intpage>controlServicePC.qnaGetTotalPagenation()) return "redirect:/admin/qna?page=1";
					request.setAttribute("num_qna", controlServicePC.qnaCountNew());
					request.setAttribute("num_error", controlServicePC.reservationErrorCount());
					request.setAttribute("list",controlServicePC.qnaGetList(intpage));
					request.setAttribute("pagenationcurrent",intpage);
					request.setAttribute("pagenationmin",controlServicePC.qnaGetMinPagenation(intpage));
					request.setAttribute("pagenationmax",controlServicePC.qnaGetMaxPagenation(intpage));
					request.setAttribute("pagenationprev",controlServicePC.qnaGetPrevPagenation(intpage));
					request.setAttribute("pagenationnext",controlServicePC.qnaGetNextPagenation(intpage));
				}
				return "/admin/qna";
			}
		} catch(Exception e) {
			e.printStackTrace();
			return "redirect:/admin/qna?page=1";
		}
	}
	
	@PostMapping("/qna")
	public String qna_answer(@RequestParam int no, @RequestParam int page, @RequestParam String search, @RequestParam String keyword, @RequestParam String answer) throws UnsupportedEncodingException {
		QnaDto qnaDto = QnaDto.builder().no(no).answer(answer).build();
		int result = controlServicePC.qnaAnswer(qnaDto);
		StringBuilder builder = new StringBuilder();
		if(search!=null) builder.append("&search="+search);
		if(keyword!=null) builder.append("&keyword="+URLEncoder.encode(keyword,"UTF-8"));
		return "redirect:/admin/qna?page="+page+builder;
	}
	
	@GetMapping("/hairart/list")
	public String hairart_list(@RequestParam(required=false) String page,
								@RequestParam(required=false) String sort,
								@RequestParam(required=false) String search,
								@RequestParam(required=false) String keyword,
								HttpServletRequest request) {
		if(page==null) return "redirect:/admin/hairart/list?page=1";
		try {
			int intpage = Integer.parseInt(page);
			if(intpage<=0) return "redirect:/admin/hairart/list?page=1";
			else {
				BoardDto boardDto = new BoardDto();
				if(search!=null && keyword!=null) {
					switch(search) {
					case "title":
					case "content":
					case "no": boardDto.setSearch(search); boardDto.setKeyword(keyword); break;
					default: boardDto.setSearch("title"); boardDto.setKeyword(""); break;
					}
				} else {
					boardDto.setSearch("title"); boardDto.setKeyword("");
				}
				if(sort!=null) {
					switch(sort) {
					case "no":
					case "viewcount":
					case "date_new":
					case "date_mod": boardDto.setSort(sort); break;
					default: boardDto.setSort("no"); break;
					}
				} else {
					boardDto.setSort("no");
				}
				if(intpage>controlServicePC.boardGetTotalPagenation(boardDto)) return "redirect:/admin/hairart/list?page=1";
				request.setAttribute("num_qna", controlServicePC.qnaCountNew());
				request.setAttribute("num_error", controlServicePC.reservationErrorCount());
				request.setAttribute("list", controlServicePC.boardGetSearchList(intpage, boardDto));
				request.setAttribute("pagenationcurrent",intpage);
				request.setAttribute("pagenationmin",controlServicePC.boardGetMinPagenation(intpage));
				request.setAttribute("pagenationmax",controlServicePC.boardGetMaxPagenation(intpage, boardDto));
				request.setAttribute("pagenationprev",controlServicePC.boardGetPrevPagenation(intpage));
				request.setAttribute("pagenationnext",controlServicePC.boardGetNextPagenation(intpage, boardDto));
				return "/admin/hairart_list";
			}
		} catch(Exception e) {
			e.printStackTrace();
			return "redirect:/admin/hairart/list?page=1";
		}
	}
	
	@GetMapping("/hairart")
	public String hairart(@RequestParam(required=false) String no,
							@RequestParam(required=false) String page,
							@RequestParam(required=false) String sort,
							@RequestParam(required=false) String search,
							@RequestParam(required=false) String keyword,
							HttpServletRequest request) {
		if(no==null) return "redirect:/admin/hairart/list";
		try {
			int intno = Integer.parseInt(no);
			if(intno<=0) return "redirect:/admin/hairart/list";
			else {
				if(page==null) return "redirect:/admin/hairart/list";
				try {
					int intpage = Integer.parseInt(page);
					if(intpage<=0) return "redirect:/admin/hairart/list";
					else {
						BoardDto boardDto = new BoardDto();
						if(search!=null && keyword!=null) {
							switch(search) {
							case "title":
							case "content":
							case "no": boardDto.setSearch(search); boardDto.setKeyword(keyword); break;
							default: boardDto.setSearch("title"); boardDto.setKeyword(""); break;
							}
						} else {
							boardDto.setSearch("title"); boardDto.setKeyword("");
						}
						if(sort!=null) {
							switch(sort) {
							case "no":
							case "viewcount":
							case "date_new":
							case "date_mod": boardDto.setSort(sort); break;
							default: boardDto.setSort("no"); break;
							}
						} else {
							boardDto.setSort("no");
						}
						if(intpage>controlServicePC.boardGetTotalPagenation(boardDto)) return "redirect:/admin/hairart/list";
						request.setAttribute("num_qna", controlServicePC.qnaCountNew());
						request.setAttribute("num_error", controlServicePC.reservationErrorCount());
						request.setAttribute("board", controlServicePC.boardGetOne(intno));
						request.setAttribute("list", controlServicePC.boardGetSearchList(intpage, boardDto));
						request.setAttribute("pagenationcurrent",intpage);
						request.setAttribute("pagenationmin",controlServicePC.boardGetMinPagenation(intpage));
						request.setAttribute("pagenationmax",controlServicePC.boardGetMaxPagenation(intpage, boardDto));
						request.setAttribute("pagenationprev",controlServicePC.boardGetPrevPagenation(intpage));
						request.setAttribute("pagenationnext",controlServicePC.boardGetNextPagenation(intpage, boardDto));
						return "/admin/hairart_view";
					}
				} catch(Exception e) {
					e.printStackTrace();
					return "redirect:/admin/hairart/list";
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
			return "redirect:/admin/hairart/list";
		}
	}
	
	@GetMapping("/hairart/write")
	public String hairart_write(HttpServletRequest request) throws ParseException {
		request.setAttribute("num_qna", controlServicePC.qnaCountNew());
		request.setAttribute("num_error", controlServicePC.reservationErrorCount());
		request.setAttribute("nextval", controlServicePC.boardNextval(request));
		return "/admin/hairart_write";
	}
	
	@PostMapping("/hairart/write")
	public String hairart_write_post(MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException {
		int result = controlServicePC.boardInsert(mRequest);
		return "redirect:/admin/hairart?no="+mRequest.getParameter("no")+"&page=1";
	}
	
	@PostMapping("/hairart/ajax_insertimage")
	public String hairart_ajax_insertimage(@RequestParam MultipartFile uploadFile, @RequestParam int board_no, HttpServletRequest request, HttpServletResponse response) {
		try {
			String filepath = controlServicePC.uploadimageInsert(uploadFile, board_no, request);
			response.setContentType("text/plain; charset=UTF-8");
			response.getWriter().print(filepath);
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
	}
	
	@GetMapping("/hairart/del")
	public String hairart_del(@RequestParam int no, HttpServletRequest request) {
		int result = controlServicePC.boardDelete(no, request);
		return "redirect:/admin/hairart";
	}
	
	@GetMapping("/hairart/mod")
	public String hairart_mod(@RequestParam int no, HttpServletRequest request) throws ParseException {
		request.setAttribute("num_qna", controlServicePC.qnaCountNew());
		request.setAttribute("num_error", controlServicePC.reservationErrorCount());
		request.setAttribute("boardDto", controlServicePC.boardGetOne(no));
		return "/admin/hairart_mod";
	}
	
	@PostMapping("/hairart/mod")
	public String hairart_mod_post(MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException {
		int result = controlServicePC.boardModify(mRequest);
		return "redirect:/admin/hairart?no="+mRequest.getParameter("no")+"&page=1";
	}
	
	@PostMapping("/hairart/mod/ajax_delattach")
	public String hairart_ajax_delattach(@RequestParam int no, @RequestParam int file_no, HttpServletRequest request, HttpServletResponse response) {
		try {
			int result = controlServicePC.boardDelAttach(no, file_no, request);
			response.setContentType("text/plain; charset=UTF-8");
			response.getWriter().print(result);
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
	}
	
	@GetMapping("/mileage")
	public String mileage(@RequestParam(required=false) String no, HttpServletRequest request) {
		if(no==null) return "redirect:/admin/customer?page=1";
		try {
			int intno = Integer.parseInt(no);
			if(intno<=0) return "redirect:/admin/customer?page=1";
			else {
				CustomerDto customerDto = controlServicePC.customerGetOne(intno);
				if(customerDto==null) return "redirect:/admin/customer?page=1";
				request.setAttribute("num_qna", controlServicePC.qnaCountNew());
				request.setAttribute("num_error", controlServicePC.reservationErrorCount());
				request.setAttribute("customerDto", customerDto);
				return "/admin/mileage";
			}
		} catch(Exception e) {
			e.printStackTrace();
			return "redirect:/admin/customer?page=1";
		}
	}
	
	@PostMapping("/mileage")
	public String mileage_post(@ModelAttribute CustomerDto customerDto, HttpServletRequest request) {
		controlServicePC.customerMileageCharge(customerDto);
		return "redirect:/admin/customer?page=1&search=no&keyword="+customerDto.getNo();
	}
	
	@GetMapping("/vacation")
	public String vacation(@RequestParam(required=false) String no, HttpServletRequest request) {
		if(no==null) return "redirect:/admin/designer?page=1";
		try {
			int intno = Integer.parseInt(no);
			if(intno<=0) return "redirect:/admin/designer?page=1";
			else {
				DesignerDto designerDto = controlServicePC.designerGetOne(intno);
				if(designerDto==null) return "redirect:/admin/designer?page=1";
				request.setAttribute("num_qna", controlServicePC.qnaCountNew());
				request.setAttribute("num_error", controlServicePC.reservationErrorCount());
				request.setAttribute("designerDto", designerDto);
				request.setAttribute("list", controlServicePC.vacationGetAllList(intno));
				return "/admin/vacation";
			}
		} catch(Exception e) {
			e.printStackTrace();
			return "redirect:/admin/designer?page=1";
		}
	}
	
	@PostMapping("/vacation/ajax_isexist")
	public String vacation_ajax_isexist(@RequestParam int no, @RequestParam int designer, @RequestParam String vac_str, HttpServletRequest request, HttpServletResponse response) {
		try {
			int result = controlServicePC.vacationIsExist(no, designer, vac_str);
			String result_str = "";
			if(result>0) result_str="Y";
			else result_str="N";
			response.setContentType("text/plain; charset=UTF-8");
			response.getWriter().print(result_str);
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
	}
	
	@PostMapping("/vacation/new")
	public String vacation_new(@ModelAttribute VacationDto vacationDto, HttpServletRequest request) {
		controlServicePC.vacationInsert(vacationDto);
		return "redirect:/admin/vacation?no="+vacationDto.getDesigner();
	}
	
	@PostMapping("/vacation/mod")
	public String vacation_mod(@ModelAttribute VacationDto vacationDto, HttpServletRequest request) {
		controlServicePC.vacationModify(vacationDto);
		return "redirect:/admin/vacation?no="+vacationDto.getDesigner();
	}
	
	@GetMapping("/vacation/del")
	public String vacation_del(@RequestParam int no, @RequestParam int designer, HttpServletRequest request) {
		controlServicePC.vacationDelete(no);
		return "redirect:/admin/vacation?no="+designer;
	}
}
