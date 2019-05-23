package hairsalon.filter;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("loginFilter")
public class LoginFilter implements Filter {
	//@Autowired
	//private ServletContext context;
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		HttpSession session = httpRequest.getSession();
		String contextPath = httpRequest.getContextPath();
		String rURI = httpRequest.getRequestURI();
		rURI = rURI.substring(rURI.indexOf(contextPath+"/pc/")+contextPath.length()+4, rURI.length());
		if(session.getAttribute("loginauth")==null) {
			session.removeAttribute("loginno");
			session.removeAttribute("loginname");
			session.removeAttribute("loginauth");
			String msg=URLEncoder.encode("로그인이 필요한 서비스입니다.","UTF-8");
			String tordr="/pc/login";
			httpResponse.sendRedirect(contextPath+"/alert?msg="+msg+"&tordr="+tordr);
		}
		else if(((String)session.getAttribute("loginauth")).equals("admin")) {
			String msg=URLEncoder.encode("관리자 페이지로 이동합니다.","UTF-8");
			String tordr="/admin/"+rURI;
			if(rURI.equalsIgnoreCase("myinfo")||rURI.equalsIgnoreCase("myreservations")||rURI.equalsIgnoreCase("imout")) {
				httpResponse.sendRedirect(contextPath+"/alert?msg="+msg+"&tordr=/admin/reception");
			} else {
				httpResponse.sendRedirect(contextPath+"/alert?msg="+msg+"&tordr="+tordr);
			}
		} else {
			chain.doFilter(request, response);
		}
	}
}
