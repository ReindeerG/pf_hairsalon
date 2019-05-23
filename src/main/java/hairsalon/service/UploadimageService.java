package hairsalon.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import hairsalon.entity.UploadimageDto;

public interface UploadimageService{
	void precheck(int no, String content, MultipartHttpServletRequest mRequest);
	String insert(MultipartFile mFile, int board_no, HttpServletRequest request);
	UploadimageDto getOne(int no);
	int delete(int no);
	int delete_path(String file_path);
	int delete_board(int board_no, HttpServletRequest request);
}