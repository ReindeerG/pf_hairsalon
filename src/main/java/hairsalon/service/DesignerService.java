package hairsalon.service;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import hairsalon.entity.CustomerDto;
import hairsalon.entity.DesignerDto;

public interface DesignerService {
	int nextval();
	int regist(MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException;
	List<DesignerDto> getAllList();
	List<DesignerDto> getSearchList(DesignerDto designerDto);
	List<DesignerDto> getOnList();
	String getTodayOffs(String fulldate);
	DesignerDto getOne(int no);
	int modify(MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException;
	int picChange(DesignerDto designerDto);
	int delete(int no, HttpServletRequest request);
	int designcount(int no);
	int toVacation(int no);
	int toWorkAll();
	int restore();
}