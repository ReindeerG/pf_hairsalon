package hairsalon.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
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

import hairsalon.entity.BoardDto;
import hairsalon.entity.CurrentDate;
import hairsalon.entity.CustomerDto;
import hairsalon.entity.DesignDto;
import hairsalon.entity.DesignerDto;
import hairsalon.entity.QnaDto;
import hairsalon.entity.ReservationDto;
import hairsalon.service.ControlServicePC;
import hairsalon.service.TaskService;

@Controller
@RequestMapping("/pc")
public class PCController {
	@Autowired
	private ControlServicePC controlServicePC;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@ExceptionHandler
	public String ehandle(Exception e) throws UnsupportedEncodingException {
		log.error("예외 발생", e);
		return "redirect:/alert?msg="+URLEncoder.encode("오류가 발생했습니다. 재시도 후에도 안되면 관리자에 문의하세요.","UTF-8")+"&tordr=/pc/home";
	}
	
	@RequestMapping("/home")
	public String home() {
		return "/pc/home";
	}
	
	@GetMapping("/designer")
	public String designer(HttpServletRequest request) {
		request.setAttribute("list", controlServicePC.designerGetOnList());
		return "/pc/designer";
	}
	
	@GetMapping("/menu")
	public String menu(HttpServletRequest request) {
		request.setAttribute("list", controlServicePC.designGetListForPage());
		return "/pc/menu";
	}
	
	@GetMapping("/hairart/list")
	public String hairart_list(@RequestParam(required=false) String page,
								@RequestParam(required=false) String sort,
								@RequestParam(required=false) String search,
								@RequestParam(required=false) String keyword,
								HttpServletRequest request) {
		if(page==null) return "redirect:/pc/hairart/list?page=1";
		try {
			int intpage = Integer.parseInt(page);
			if(intpage<=0) return "redirect:/pc/hairart/list?page=1";
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
				if(intpage>controlServicePC.boardGetTotalPagenation(boardDto)) return "redirect:/pc/hairart/list?page=1";
				request.setAttribute("list", controlServicePC.boardGetListForPage(intpage, boardDto));
				request.setAttribute("pagenationcurrent",intpage);
				request.setAttribute("pagenationmin",controlServicePC.boardGetMinPagenation(intpage));
				request.setAttribute("pagenationmax",controlServicePC.boardGetMaxPagenation(intpage, boardDto));
				request.setAttribute("pagenationprev",controlServicePC.boardGetPrevPagenation(intpage));
				request.setAttribute("pagenationnext",controlServicePC.boardGetNextPagenation(intpage, boardDto));
				return "/pc/hairart_list";
			}
		} catch(Exception e) {
			e.printStackTrace();
			return "redirect:/pc/hairart/list?page=1";
		}
	}
	
	@GetMapping("/hairart")
	public String hairart(@RequestParam(required=false) String no,
							@RequestParam(required=false) String page,
							@RequestParam(required=false) String sort,
							@RequestParam(required=false) String search,
							@RequestParam(required=false) String keyword,
							HttpServletRequest request) {
		if(no==null) return "redirect:/pc/hairart/list";
		try {
			int intno = Integer.parseInt(no);
			if(intno<=0) return "redirect:/pc/hairart/list";
			else {
				if(page==null) return "redirect:/pc/hairart/list";
				try {
					int intpage = Integer.parseInt(page);
					if(intpage<=0) return "redirect:/pc/hairart/list";
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
						if(intpage>controlServicePC.boardGetTotalPagenation(boardDto)) return "redirect:/pc/hairart/list";
						controlServicePC.boardViewcount(intno);
						request.setAttribute("board", controlServicePC.boardGetOne(intno));
						request.setAttribute("list", controlServicePC.boardGetListForPage(intpage, boardDto));
						request.setAttribute("pagenationcurrent",intpage);
						request.setAttribute("pagenationmin",controlServicePC.boardGetMinPagenation(intpage));
						request.setAttribute("pagenationmax",controlServicePC.boardGetMaxPagenation(intpage, boardDto));
						request.setAttribute("pagenationprev",controlServicePC.boardGetPrevPagenation(intpage));
						request.setAttribute("pagenationnext",controlServicePC.boardGetNextPagenation(intpage, boardDto));
						return "/pc/hairart_view";
					}
				} catch(Exception e) {
					e.printStackTrace();
					return "redirect:/pc/hairart/list";
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
			return "redirect:/pc/hairart/list";
		}
	}
	
	@GetMapping("/schedule")
	public String schedule(HttpServletRequest request) {
		request.setAttribute("designerlist", controlServicePC.designerGetOnList());
		request.setAttribute("designlist", controlServicePC.designGetOnList());
		request.setAttribute("currentdate", controlServicePC.getTodayInfo());
		String host = request.getHeader("Host");
		request.setAttribute("host", host);
		return "/pc/schedule";
	}
	
	@PostMapping("/schedule/ajax_offdays")
	public String schedule_offdays(@RequestParam String selecteddate, HttpServletResponse response) throws IOException {
		String result = controlServicePC.designerGetTodayOffs(selecteddate);
		response.setContentType("text/plain; charset=UTF-8");
		response.getWriter().print(result);
		return null;
	}
	
	@PostMapping("/schedule/ajax_list")
	public String schedule_list(@RequestParam String selecteddate, HttpServletResponse response, HttpSession session) throws IOException, ParseException {
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
			String myrsv = "";
			if(reservationDto.getCustomer()==(int)session.getAttribute("loginno")) myrsv = "myrsv";
			builder.append("<button class='btn btn-case font-nbgl fortimetable "+modplz+" "+myrsv+"' id='btn-res_n"+reservationDto.getNo()+"_d"+designer_str+"_s"+starttime_str+"_p"+period+"_t"+reservationDto.getState()+"'>");
			if(designDto==null) {
				builder.append("<p>예약<p>");
			} else {
				builder.append("<p>"+designDto.getName()+"<p>");
			}
			if(myrsv.equals("myrsv")) builder.append("<p>(나의예약)<p>");
			builder.append("</button>");
		}
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print(builder);
		return null;
	}
	
	@PostMapping("/schedule/ajax_new")
	public String schedule_new(
								@RequestParam String whatday_str,
								@RequestParam String customer_str,
								@RequestParam int designer,
								@RequestParam int design,
								@RequestParam int starttime,
								@RequestParam int force,
								HttpServletResponse response) throws IOException, ParseException {
		int customer = Integer.parseInt(customer_str);
		CustomerDto customerDto = controlServicePC.customerGetOne(customer);
		String customer_name = customerDto.getName();
		String customer_gender = customerDto.getGender();
		String customer_phone = customerDto.getPhone();
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
								@RequestParam int designer,
								@RequestParam int design,
								@RequestParam String whatday_str,
								@RequestParam int starttime,
								@RequestParam int force,
								HttpServletResponse response) throws IOException, ParseException {
		DesignDto designDto = controlServicePC.designGetOne(design);
		int period = designDto.getMaxtime_hour()*100;
		if(designDto.getMaxtime_min()==30) period+=50;
		ReservationDto reservationDto = ReservationDto.builder().no(no).whatday_str(whatday_str).designer(designer).design(design).starttime(starttime).period(period).build();
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
	
	@PostMapping("/schedule/ajax_get")
	public String schedule_get(@RequestParam int no, HttpServletResponse response) throws IOException {
		ReservationDto reservationDto = controlServicePC.reservationGetOne(no);
		StringBuilder builder = new StringBuilder();
		builder.append("_no"+reservationDto.getNo());
		builder.append("_designer"+reservationDto.getDesigner());
		builder.append("_menu"+reservationDto.getDesign());
		builder.append("_start"+reservationDto.getStarttime());
		builder.append("_period"+reservationDto.getPeriod());
		builder.append("_end");
		response.setContentType("text/plain; charset=UTF-8");
		response.getWriter().print(builder);
		return null;
	}
	
	@PostMapping("/schedule/ajax_time")
	public String schedule_get(HttpServletResponse response) throws IOException {
		response.setContentType("text/plain; charset=UTF-8");
		response.getWriter().print(controlServicePC.ajaxCurrentTime());
		return null;
	}
	
	@GetMapping("/login")
	public String login(HttpSession session) {
		return "/pc/login";
	}
	
	@PostMapping("/login")
	public String login(@RequestParam String email, @RequestParam String pw, @RequestParam(required=false) boolean remember, @RequestParam(required=false) boolean isadmin, HttpSession session, HttpServletResponse response) throws NoSuchAlgorithmException, UnsupportedEncodingException {
		if(isadmin==false) {
			int idNo = controlServicePC.customerLogin(email, pw, session);
			if(idNo==0) return "redirect:/alert?msg="+URLEncoder.encode("입력 정보와 일치하는 회원이 없습니다.","UTF-8")+"&tordr=/pc/login";
			if(idNo==-1) return "redirect:/pc/notmailconfirmed?email="+email;
			Cookie c = new Cookie("rememberemail", email);
			if(remember==true) {
				c.setMaxAge(60*60*24*30);
			} else {
				c.setMaxAge(0);
			}
			response.addCookie(c);
		} else {
			int idNo = controlServicePC.adminLogin(email, pw, session);
			if(idNo==0) return "redirect:/alert?msg="+URLEncoder.encode("매장 관리자 정보를 제대로 입력해주세요.","UTF-8")+"&tordr=/pc/login";
			Cookie c = new Cookie("rememberemail", email);
			if(remember==true) {
				c.setMaxAge(60*60*24*30);
			} else {
				c.setMaxAge(0);
			}
			response.addCookie(c);
			return "redirect:/admin/reception";
		}
		return "redirect:/pc/myreservations";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) throws UnsupportedEncodingException {
		session.removeAttribute("loginno");
		session.removeAttribute("loginname");
		session.removeAttribute("loginauth");
		return "redirect:/alert?msg="+URLEncoder.encode("로그아웃 되셨습니다.","UTF-8")+"&tordr=/pc/home";
	}
	
	@GetMapping("/signin")
	public String signin() {
		return "/pc/signin";
	}
	
	@PostMapping("/signin")
	public String signin(@ModelAttribute CustomerDto customerDto) throws NoSuchAlgorithmException {
		controlServicePC.customerSigninSelf(customerDto);
		return "redirect:/pc/signinok?email="+customerDto.getEmail();
	}
	
	@GetMapping("/signinok")
	public String signinok(@RequestParam String email, HttpServletRequest request) throws MessagingException {
		CustomerDto customerDto = controlServicePC.customerGetOneByEmail(email);
		if(customerDto==null) return "redirect:/pc/home";
		if(customerDto.getConfirmed()==1) return "redirect:/pc/login";
		controlServicePC.emailSendConfirm(email, request);
		return "/pc/signinok";
	}
	
	@GetMapping("/notmailconfirmed")
	public String notmailconfirmed(@RequestParam String email) {
		return "/pc/notmailconfirmed";
	}
	
	@GetMapping("/sendconfirm")
	public String sendconfirm(@RequestParam String email, HttpServletRequest request) throws MessagingException {
		CustomerDto customerDto = controlServicePC.customerGetOneByName(email);
		if(customerDto==null) return "redirect:/pc/home";
		if(customerDto.getConfirmed()==1) return "redirect:/pc/login";
		controlServicePC.emailSendConfirm(email, request);
		return "redirect:/pc/notmailconfirmed?email="+email;
	}
	
	@GetMapping("/confirm")
	public String confirm(@RequestParam String no, @RequestParam String confirmcode, HttpServletRequest request) {
		if(no==null) return "redirect:/pc/home";
		try {
			int intno = Integer.parseInt(no);
			if(intno<=0) return "redirect:/pc/home";
			else {
				if(controlServicePC.customerConfirm(intno, confirmcode)) {
					request.setAttribute("result", 1);
				} else {
					request.setAttribute("result", 0);
				}
				return "/pc/confirm";
			}
		} catch(Exception e) {
			e.printStackTrace();
			return "redirect:/pc/home";
		}
	}
	
	@GetMapping("/qna")
	public String qna(@RequestParam(required=false) String page,
						@RequestParam(required=false) String search,
						@RequestParam(required=false) String keyword,
						HttpSession session,
						HttpServletRequest request) {
		if(page==null) return "redirect:/pc/qna?page=1";
		try {
			int intpage = Integer.parseInt(page);
			if(intpage<=0) return "redirect:/pc/qna?page=1";
			else {
				QnaDto qnaDto = new QnaDto();
				if(search!=null && keyword!=null) {
					switch(search) {
					case "question":
					case "answer": qnaDto.setSearch(search); qnaDto.setKeyword(keyword); break;
					default: qnaDto.setSearch("question"); qnaDto.setKeyword(""); break;
					}
				} else {
					qnaDto.setSearch("question"); qnaDto.setKeyword("");
				}
				qnaDto.setCustomer((int)session.getAttribute("loginno"));
				if(intpage>controlServicePC.qnaGetTotalPagenationForCustomer(qnaDto)) return "redirect:/pc/qna?page=1";
				List<QnaDto> list = controlServicePC.qnaGetSearchListForCustomer(intpage, qnaDto);
				request.setAttribute("list", list);
				request.setAttribute("pagenationcurrent",intpage);
				request.setAttribute("pagenationmin",controlServicePC.qnaGetMinPagenation(intpage));
				request.setAttribute("pagenationmax",controlServicePC.qnaGetMaxPagenationForCustomer(intpage, qnaDto));
				request.setAttribute("pagenationprev",controlServicePC.qnaGetPrevPagenation(intpage));
				request.setAttribute("pagenationnext",controlServicePC.qnaGetNextPagenationForCustomer(intpage, qnaDto));
				return "/pc/qna";
			}
		} catch(Exception e) {
			e.printStackTrace();
			return "redirect:/pc/qna?page=1";
		}
	}
	
	@PostMapping("/qna")
	public String qna_new(@RequestParam int customer, @RequestParam String question) {
		QnaDto qnaDto = QnaDto.builder().customer(customer).question(question).build();
		int result = controlServicePC.qnaNew(qnaDto);
		return "redirect:/pc/qna?page=1";
	}
	
	@GetMapping("/myinfo")
	public String myinfo(HttpSession session, HttpServletRequest request) {
		request.setAttribute("me",controlServicePC.customerGetOne((int)session.getAttribute("loginno")));
		return "/pc/myinfo";
	}
	
	@PostMapping("/myinfo")
	public String myinfo_mod(@ModelAttribute CustomerDto customerDto) throws UnsupportedEncodingException {
		int result = controlServicePC.customerModifyByCustomer(customerDto);
		if(result==1) {
			return "redirect:/alert?msg="+URLEncoder.encode("회원정보가 변경되었습니다.","UTF-8")+"&tordr=/pc/myinfo";
		} else {
			return "redirect:/alert?msg="+URLEncoder.encode("내부 오류입니다!","UTF-8")+"&tordr=/pc/myinfo";
		}
	}
	
	@GetMapping("/changepw")
	public String changepw(HttpSession session, HttpServletRequest request) {
		request.setAttribute("me",controlServicePC.customerGetOne((int)session.getAttribute("loginno")));
		return "/pc/changepw";
	}
	
	@PostMapping("/changepw")
	public String changepw_mod(@RequestParam int no, @RequestParam String originpw, @RequestParam String pw) throws NoSuchAlgorithmException, UnsupportedEncodingException {
		int result = controlServicePC.customerModifyPw(no, originpw, pw);
		if(result==1) {
			return "redirect:/alert?msg="+URLEncoder.encode("비밀번호가 변경되었습니다.","UTF-8")+"&tordr=/pc/changepw";
		} else {
			return "redirect:/alert?msg="+URLEncoder.encode("기존 비밀번호가 틀렸습니다!","UTF-8")+"&tordr=/pc/changepw";
		}
	}
	
	@GetMapping("/imout")
	public String imout(@RequestParam int no, HttpSession session) throws UnsupportedEncodingException {
		controlServicePC.customerDelete(no);
		session.removeAttribute("loginno");
		session.removeAttribute("loginname");
		session.removeAttribute("loginauth");
		return "redirect:/alert?msg="+URLEncoder.encode("회원 탈퇴되었습니다. 그동안 감사했습니다.","UTF-8")+"&tordr=/pc/home";
	}
	
	@GetMapping("/myreservations")
	public String myreservations(HttpSession session, HttpServletRequest request) {
		request.setAttribute("list",controlServicePC.reservationGetCustomerList((int)session.getAttribute("loginno")));
		return "/pc/myreservations";
	}
	
	@GetMapping("/event")
	public String event() {
		return "/pc/event";
	}
	
	@GetMapping("/findid")
	public String findid() {
		return "/pc/findid";
	}
	
	@PostMapping("/findid")
	public String findid_result(@ModelAttribute CustomerDto customerDto, HttpServletRequest request) {
		request.setAttribute("list", controlServicePC.customerFindId(customerDto));
		return "/pc/findid_result";
	}
	
	@PostMapping("/temppw")
	public String temppw(@RequestParam int no) throws UnsupportedEncodingException, NoSuchAlgorithmException, MessagingException {
		controlServicePC.customerSendTempPw(no);
		return "redirect:/alert?msg="+URLEncoder.encode("임시암호가 발급되었습니다. 메일함을 확인해주세요.","UTF-8")+"&tordr=/pc/login";
	}
	
	@GetMapping("/expr_customer")
	public String expr_customer(HttpSession session) {
		controlServicePC.customerExpr(session);
		return "redirect:/pc/home";
	}
	
	@GetMapping("/expr_admin")
	public String expr_admin(HttpSession session) {
		controlServicePC.adminExpr(session);
		return "redirect:/admin/reception";
	}
}
