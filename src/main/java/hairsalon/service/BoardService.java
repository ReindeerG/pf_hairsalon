package hairsalon.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import hairsalon.entity.BoardDto;

public interface BoardService {
	int nextval(HttpServletRequest request);
	int insert(MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException;
	List<BoardDto> getAllList();
	List<BoardDto> getSomeList(int start, int count);
	BoardDto getOne(int no);
	int delete(int no, HttpServletRequest request);
	int modify(MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException;
	int del_attach(int no, int file_no, HttpServletRequest request);
	int viewCountUp(int no);
	List<BoardDto> getSearchList(int no, BoardDto boardDto);
	int getTotalPagenation(BoardDto boardDto);
	int getMinPagenation(int no);
	int getMaxPagenation(int no, BoardDto boardDto);
	int getPrevPagenation(int no);
	int getNextPagenation(int no, BoardDto boardDto);
	List<BoardDto> getListForPage(int no, BoardDto boardDto);
}