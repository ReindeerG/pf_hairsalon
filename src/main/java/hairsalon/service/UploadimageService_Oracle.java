package hairsalon.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import hairsalon.entity.UploadimageDto;
import hairsalon.repository.UploadimageDao;

@Service("uploadimageService")
public class UploadimageService_Oracle implements UploadimageService {
	@Autowired
	private UploadimageDao uploadimageDao;
	
	@Autowired
	private RandomStringService randomStringService;
	
	public void precheck(int no, String content, MultipartHttpServletRequest mRequest) {
		if(content==null) return;
		List<String> list = new ArrayList<>();
		while(content.contains("<img src=\"/hairsalon/uploadimages/")) {
			content = content.substring(content.indexOf("<img src=\"/hairsalon/uploadimages/")+34, content.length());
			String tempstr = content.substring(0, content.indexOf("\""));
			list.add(tempstr);
			content = content.substring(content.indexOf(tempstr)+tempstr.length(), content.length());
		}
		if(list.isEmpty()) {
			List<String> notUsedList = uploadimageDao.listBoardno(no);
			if(!notUsedList.isEmpty()) {
				ServletContext context = mRequest.getServletContext();
				String savepath = context.getRealPath("/uploadimages");
				File folder = new File(savepath);
				folder.mkdirs();
				for(String str : notUsedList) {
					File target = new File(folder, str);
					if(target.exists()) target.delete();
				}
			}
			uploadimageDao.delete_board(no);
			return;
		} else {
			UploadimageDto uploadimageDto = UploadimageDto.builder().board_no(no).prechecklist(list).build();
			List<String> notUsedList = uploadimageDao.precheckSelect(uploadimageDto);
			if(!notUsedList.isEmpty()) {
				ServletContext context = mRequest.getServletContext();
				String savepath = context.getRealPath("/uploadimages");
				File folder = new File(savepath);
				folder.mkdirs();
				for(String str : notUsedList) {
					File target = new File(folder, str);
					if(target.exists()) target.delete();
				}
				uploadimageDto.setPrechecklist(notUsedList);
				uploadimageDao.precheckDelete(uploadimageDto);
			}
		}
	}
	
	public String insert(MultipartFile mFile, int board_no, HttpServletRequest request) {
		ServletContext context = request.getServletContext();
		String savepath = context.getRealPath("/uploadimages");
		File folder = new File(savepath);
		folder.mkdirs();
		String file_name = mFile.getOriginalFilename();
		String file_type = mFile.getContentType();
		long file_size = mFile.getSize();
		String file_path = String.valueOf(System.currentTimeMillis())+randomStringService.getRandomString(6)+file_name;
		File target = new File(folder, file_path);
		try {
			mFile.transferTo(target);
			UploadimageDto uploadimageDto = UploadimageDto.builder().board_no(board_no).file_name(file_name).file_type(file_type).file_size(file_size).file_path(file_path).build();
			uploadimageDao.insert(uploadimageDto);
			return file_path;
		} catch(Exception e) {
			return null;
		}
	}
	
	public UploadimageDto getOne(int no) {
		return uploadimageDao.getOne(no);
	}
	
	public int delete(int no) {
		return uploadimageDao.delete(no);
	}
	
	public int delete_path(String file_path) {
		return uploadimageDao.delete_path(file_path);
	}
	
	public int delete_board(int board_no, HttpServletRequest request) {
		List<String> notUsedList = uploadimageDao.listBoardno(board_no);
		if(!notUsedList.isEmpty()) {
			ServletContext context = request.getServletContext();
			String savepath = context.getRealPath("/uploadimages");
			File folder = new File(savepath);
			folder.mkdirs();
			for(String str : notUsedList) {
				File target = new File(folder, str);
				if(target.exists()) target.delete();
			}
		}
		return uploadimageDao.delete_board(board_no);
	}
}