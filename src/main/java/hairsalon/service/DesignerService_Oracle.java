package hairsalon.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import hairsalon.entity.DesignDto;
import hairsalon.entity.DesignerDto;
import hairsalon.repository.DesignerDao;

@Service("designerService")
public class DesignerService_Oracle implements DesignerService {
	@Autowired
	private DesignerDao designerDao;
	
	@Autowired
	private VacationService vacationService;
	
	private DesignerDto setString(DesignerDto designerDto) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		designerDto.setBirth_str(format.format(designerDto.getBirth()));
		designerDto.setSignindate_str(format.format(designerDto.getSignindate()));
		switch(designerDto.getGrade()) {
		case 0: designerDto.setGrade_str("실장"); break;
		case 1: designerDto.setGrade_str("팀장"); break;
		case 2: designerDto.setGrade_str("사원"); break;
		case 3: designerDto.setGrade_str("견습"); break;
		case 4: designerDto.setGrade_str("아르바이트"); break;
		}
		return designerDto;
	}
	
	private List<DesignerDto> setString(List<DesignerDto> list) {
		for(DesignerDto designerDto : list) {
			designerDto = this.setString(designerDto);
		}
		return list;
	}
	
	public int nextval() {
		return designerDao.nextval();
	}

	public int regist(MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException {
		int no = this.nextval();
		DesignerDto designerDto = DesignerDto.builder().no(no)
									.name(mRequest.getParameter("name"))
									.gender(mRequest.getParameter("gender"))
									.grade(Integer.parseInt(mRequest.getParameter("grade")))
									.offdays(mRequest.getParameter("offdays"))
									.isonoff(Integer.parseInt(mRequest.getParameter("isonoff")))
									.phone(mRequest.getParameter("phone"))
									.email(mRequest.getParameter("email"))
									.birth_str(mRequest.getParameter("birth_str"))
									.signindate_str(mRequest.getParameter("signindate_str"))
									.build();
		int result = designerDao.insert(designerDto);
		if(result==1) {
			MultipartFile file = mRequest.getFile("picture");
			if(file.getSize()>0) {
				if(file.getSize()>1024*250) return result;
				if(!file.getContentType().startsWith("image/")) return result;
				ServletContext context = mRequest.getServletContext();
				String savepath = context.getRealPath("/designerpics");
				File folder = new File(savepath);
				folder.mkdirs();
				String file_path = String.valueOf(System.currentTimeMillis())+file.getOriginalFilename();
				File target = new File(folder, file_path);
				file.transferTo(target);
				designerDto.setPicture(file_path);
				return this.picChange(designerDto);
			}
		}
		return result;
	}
	
	public List<DesignerDto> getAllList() {
		List<DesignerDto> list = designerDao.getAllList();
		return this.setString(list);
	}
	
	public List<DesignerDto> getSearchList(DesignerDto designerDto) {
		List<DesignerDto> list = designerDao.getSearchList(designerDto);
		return this.setString(list);
	}
	
	public List<DesignerDto> getOnList() {
		List<DesignerDto> list = designerDao.getOnList();
		return this.setString(list);
	}
	
	public String getTodayOffs(String fulldate) {
		String date = fulldate.substring(0, 10);
		int day = Integer.parseInt(fulldate.substring(11,12));
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
		List<DesignerDto> list = this.getOnList();
		StringBuilder builder = new StringBuilder();
		for(DesignerDto designerDto : list) {
			if(designerDto.getOffdays()!=null && designerDto.getOffdays().contains(day_str)) {
				builder.append(designerDto.getNo()+"/");
			} else if(vacationService.isVacation(designerDto.getNo(), date)>0) {
				builder.append(designerDto.getNo()+"/");
			}
		}
		return builder.toString();
	}
	
	
	public DesignerDto getOne(int no) {
		DesignerDto designerDto = designerDao.getOne(no);
		return this.setString(designerDto);
	}
	
	public int modify(MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException {
		int no = Integer.parseInt(mRequest.getParameter("no"));
		DesignerDto designerDto = DesignerDto.builder().no(no)
									.name(mRequest.getParameter("name"))
									.gender(mRequest.getParameter("gender"))
									.grade(Integer.parseInt(mRequest.getParameter("grade")))
									.offdays(mRequest.getParameter("offdays"))
									.isonoff(Integer.parseInt(mRequest.getParameter("isonoff")))
									.phone(mRequest.getParameter("phone"))
									.email(mRequest.getParameter("email"))
									.birth_str(mRequest.getParameter("birth_str"))
									.signindate_str(mRequest.getParameter("signindate_str"))
									.build();
		int result = designerDao.modify(designerDto);
		if(result==1) {
			MultipartFile file = mRequest.getFile("picture");
			if(file.getSize()>0) {
				if(file.getSize()>1024*250) return result;
				if(!file.getContentType().startsWith("image/")) return result;
				DesignerDto origin = this.getOne(no);
				ServletContext context = mRequest.getServletContext();
				String savepath = context.getRealPath("/designerpics");
				File folder = new File(savepath);
				folder.mkdirs();
				if(origin.getPicture()!=null) {
					File target_origin = new File(folder, origin.getPicture());
					if(target_origin.exists()) target_origin.delete();
				}
				String file_path = String.valueOf(System.currentTimeMillis())+file.getOriginalFilename();
				File target = new File(folder, file_path);
				file.transferTo(target);
				designerDto.setPicture(file_path);
				return this.picChange(designerDto);
			}
		}
		return result;
	}
	
	public int picChange(DesignerDto designerDto) {
		return designerDao.picChange(designerDto);
	}
	
	public int delete(int no, HttpServletRequest request) {
		DesignerDto designerDto = this.getOne(no);
		if(designerDto.getPicture()!=null) {
			ServletContext context = request.getServletContext();
			String savepath = context.getRealPath("/designerpics");
			File folder = new File(savepath);
			folder.mkdirs();
			File target_origin = new File(folder, designerDto.getPicture());
			if(target_origin.exists()) target_origin.delete();
		}
		return designerDao.delete(no);
	}
	
	public int designcount(int no) {
		return designerDao.designcount(no);
	}
	
	public int toVacation(int no) {
		return designerDao.toVacation(no);
	}
	
	public int toWorkAll() {
		return designerDao.toWorkAll();
	}
	
	public int restore() {
		return designerDao.restore();
	}
}
