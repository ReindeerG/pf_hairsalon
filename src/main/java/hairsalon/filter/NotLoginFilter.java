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

@Component("notLoginFilter")
public class NotLoginFilter implements Filter {
	//@Autowired
	//private ServletContext context;
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		HttpSession session = httpRequest.getSession();
		if(session.getAttribute("loginauth")!=null) {
			httpResponse.sendRedirect(httpRequest.getContextPath()+"/pc/home");
		} else {
			session.removeAttribute("loginno");
			session.removeAttribute("loginname");
			session.removeAttribute("loginauth");
			chain.doFilter(request, response);
		}
	}

}
