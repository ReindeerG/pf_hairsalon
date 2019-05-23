package hairsalon.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import hairsalon.entity.BoardDto;
import hairsalon.service.BoardService;
import hairsalon.service.ControlServicePC;
import hairsalon.service.CustomerService;

@Controller
public class HomeController {
	@Autowired
	private ControlServicePC controlServicePC;
	
	@RequestMapping("/home")
	public String home() {
		return "redirect:/pc/home";
	}
	
	@RequestMapping("/error")
	public String error(HttpServletRequest request) throws UnsupportedEncodingException {
		return "redirect:/alert?msg="+URLEncoder.encode("존재하지 않는 페이지입니다. 재시도 후에도 안되면 관리자에 문의하세요.","UTF-8")+"&tordr=/pc/home";
	}
	
	@RequestMapping("/alert")
	public String alert(@RequestParam String msg, @RequestParam String tordr, HttpServletRequest request) {
		return "alert";
	}
	
	@PostMapping("/ajax/signin/emailcheck")
	public String emailcheck(@RequestParam String email, HttpServletResponse response) throws IOException {
		boolean check = controlServicePC.customerExistByEmail(email);
		String result;
		if(check) {
			result = "Y";
		} else {
			result = "N";
		}
		response.setContentType("text/plain; charset=UTF-8");
		response.getWriter().print(result);
		return null;
	}
	
	@RequestMapping(value="/download")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> download(@RequestParam int no, @RequestParam int fileno, HttpServletRequest request, HttpServletResponse response) throws IOException {
		BoardDto boardDto = controlServicePC.boardGetOne(no);
		if(boardDto==null) {	// 없으면 404에러
			return ResponseEntity.notFound().build();
		}
		ServletContext context = request.getServletContext();
		String file_path = "";
		String file_name = "";
		long file_size = 0;
		switch(fileno) {
		case 1: file_path=boardDto.getFile1_path(); file_size=boardDto.getFile1_size(); file_name=boardDto.getFile1_name(); break;
		case 2: file_path=boardDto.getFile2_path(); file_size=boardDto.getFile2_size(); file_name=boardDto.getFile2_name(); break;
		}
		
		File target = new File(context.getRealPath("/uploadfiles"), file_path);
		
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		return ResponseEntity.ok()
								.header("Content-Type", "application/octet-stream")
								.contentType(MediaType.APPLICATION_OCTET_STREAM)
								.contentLength(file_size)
								.header(HttpHeaders.CONTENT_DISPOSITION,"attachment; filename=\""+URLEncoder.encode(file_name,"UTF-8")+"\"")
								.body(resource);
	}
	
	
}
