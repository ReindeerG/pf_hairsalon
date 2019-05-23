package hairsalon.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import hairsalon.entity.BoardDto;
import hairsalon.entity.CurrentDate;
import hairsalon.entity.QnaDto;
import hairsalon.repository.BoardDao;

@Service("boardService")
@PropertySource({"classpath:/properties/page.properties"})
public class BoardService_Oracle implements BoardService {
	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private Environment env;
	
	@Autowired
	private UploadimageService uploadimageService;
	
	@Autowired
	private RandomStringService randomStringService;
	
	private BoardDto setString(BoardDto boardDto) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		boardDto.setDate_new_str(format.format(boardDto.getDate_new()));
		boardDto.setDate_mod_str(format.format(boardDto.getDate_mod()));
		if(boardDto.getFile1_size()>0) {
			boardDto.setFiles(boardDto.getFiles()+1);
			if(boardDto.getFile1_size()>1024*1024) {
				boardDto.setFile1_size_str(boardDto.getFile1_size()/(1024*1024)+" MB");
			} else if(boardDto.getFile1_size()>1024) {
				boardDto.setFile1_size_str(boardDto.getFile1_size()/1024+" KB");
			} else {
				boardDto.setFile1_size_str(boardDto.getFile1_size()+" Byte");
			}
		}
		if(boardDto.getFile2_size()>0) {
			boardDto.setFiles(boardDto.getFiles()+1);
			if(boardDto.getFile2_size()>1024*1024) {
				boardDto.setFile2_size_str(boardDto.getFile2_size()/(1024*1024)+" MB");
			} else if(boardDto.getFile2_size()>1024) {
				boardDto.setFile2_size_str(boardDto.getFile2_size()/1024+" KB");
			} else {
				boardDto.setFile2_size_str(boardDto.getFile2_size()+" Byte");
			}
		}
		return boardDto;
	}
	
	private List<BoardDto> setString(List<BoardDto> list) {
		for(BoardDto boardDto : list) {
			boardDto = this.setString(boardDto);
		}
		return list;
	}
	
	public int nextval(HttpServletRequest request) {
		int result =  boardDao.nextval();
		int isexist = boardDao.isexist(result-1);
		if(isexist==0) {
			uploadimageService.delete_board(result-1, request);
		}
		return result;
	}

	public int insert(MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException {
		int board_no = Integer.parseInt(mRequest.getParameter("no"));
		String title = mRequest.getParameter("title").trim();
		String content = mRequest.getParameter("content");
		uploadimageService.precheck(board_no, content, mRequest);
		BoardDto boardDto = BoardDto.builder().no(board_no).title(title).content(content).build();
		ServletContext context = mRequest.getServletContext();
		String savepath = context.getRealPath("/uploadfiles");
		File folder = new File(savepath);
		folder.mkdirs();
		MultipartFile file1 = mRequest.getFile("file1");
		MultipartFile file2 = mRequest.getFile("file2");
		if(file1.getSize()==0 && file2.getSize()>0) {
			file1=file2; file2=null;
		}
		if(file1.getSize()>0) {
			String file1_name = file1.getOriginalFilename();
			String file1_type = file1.getContentType();
			long file1_size = file1.getSize();
			String file1_path = String.valueOf(System.currentTimeMillis())+randomStringService.getRandomString(6)+file1_name;
			File target1 = new File(folder, file1_path);
			file1.transferTo(target1);
			boardDto.setFile1_path(file1_path);
			boardDto.setFile1_type(file1_type);
			boardDto.setFile1_name(file1_name);
			boardDto.setFile1_size(file1_size);
		} else {
			boardDto.setFile1_path("");
			boardDto.setFile1_type("");
			boardDto.setFile1_name("");
			boardDto.setFile1_size(0);
		}
		if(file2!=null && file2.getSize()>0) {
			String file2_name = file2.getOriginalFilename();
			String file2_type = file2.getContentType();
			long file2_size = file2.getSize();
			String file2_path = String.valueOf(System.currentTimeMillis())+randomStringService.getRandomString(6)+file2_name;
			File target2 = new File(folder, file2_path);
			file2.transferTo(target2);
			boardDto.setFile2_path(file2_path);
			boardDto.setFile2_type(file2_type);
			boardDto.setFile2_name(file2_name);
			boardDto.setFile2_size(file2_size);
		} else {
			boardDto.setFile2_path("");
			boardDto.setFile2_type("");
			boardDto.setFile2_name("");
			boardDto.setFile2_size(0);
		}
		return boardDao.insert(boardDto);
	}
	
	public List<BoardDto> getAllList() {
		List<BoardDto> list = boardDao.getAllList();
		return this.setString(list);
	}
	
	public List<BoardDto> getSomeList(int start, int count) {
		List<BoardDto> list = boardDao.getSomeList(start, count);
		return this.setString(list);
	}
	
	public BoardDto getOne(int no) {
		BoardDto boardDto =  boardDao.getOne(no);
		return this.setString(boardDto);
	}
	
	public int delete(int no, HttpServletRequest request) {
		BoardDto boardDto = boardDao.getOne(no);
		ServletContext context = request.getServletContext();
		String savepath = context.getRealPath("/uploadfiles");
		File folder = new File(savepath);
		if(boardDto.getFile1_size()>0) {
			File originTarget1 = new File(folder, boardDto.getFile1_path());
			originTarget1.delete();
		}
		if(boardDto.getFile2_size()>0) {
			File originTarget2 = new File(folder, boardDto.getFile2_path());
			originTarget2.delete();
		}
		uploadimageService.delete_board(no, request);
		return boardDao.delete(no);
	}
	
	public int modify(MultipartHttpServletRequest mRequest) throws IllegalStateException, IOException {
		int board_no = Integer.parseInt(mRequest.getParameter("no"));
		BoardDto originBoardDto = boardDao.getOne(board_no);
		String title = mRequest.getParameter("title").trim();
		String content = mRequest.getParameter("content");
		uploadimageService.precheck(board_no, content, mRequest);
		BoardDto boardDto = BoardDto.builder().no(board_no).title(title).content(content).build();
		ServletContext context = mRequest.getServletContext();
		String savepath = context.getRealPath("/uploadfiles");
		File folder = new File(savepath);
		folder.mkdirs();
		MultipartFile file1 = mRequest.getFile("file1");
		MultipartFile file2 = mRequest.getFile("file2");
		if(file1.getSize()>0) {
			if(originBoardDto.getFile1_size()>0) {
				File originTarget1 = new File(folder, originBoardDto.getFile1_path());
				originTarget1.delete();
			}
			String file1_name = file1.getOriginalFilename();
			String file1_type = file1.getContentType();
			long file1_size = file1.getSize();
			String file1_path = String.valueOf(System.currentTimeMillis())+randomStringService.getRandomString(6)+file1_name;
			File target1 = new File(folder, file1_path);
			file1.transferTo(target1);
			boardDto.setFile1_path(file1_path);
			boardDto.setFile1_type(file1_type);
			boardDto.setFile1_name(file1_name);
			boardDto.setFile1_size(file1_size);
		} else {
			if(originBoardDto.getFile1_size()>0) {
				boardDto.setFile1_path(originBoardDto.getFile1_path());
				boardDto.setFile1_type(originBoardDto.getFile1_type());
				boardDto.setFile1_name(originBoardDto.getFile1_name());
				boardDto.setFile1_size(originBoardDto.getFile1_size());
			} else {
				boardDto.setFile1_path("");
				boardDto.setFile1_type("");
				boardDto.setFile1_name("");
				boardDto.setFile1_size(0);
			}
		}
		if(file2.getSize()>0) {
			if(originBoardDto.getFile2_size()>0) {
				File originTarget2 = new File(folder, originBoardDto.getFile2_path());
				originTarget2.delete();
			}
			String file2_name = file2.getOriginalFilename();
			String file2_type = file2.getContentType();
			long file2_size = file2.getSize();
			String file2_path = String.valueOf(System.currentTimeMillis())+randomStringService.getRandomString(6)+file2_name;
			File target2 = new File(folder, file2_path);
			file2.transferTo(target2);
			boardDto.setFile2_path(file2_path);
			boardDto.setFile2_type(file2_type);
			boardDto.setFile2_name(file2_name);
			boardDto.setFile2_size(file2_size);
		} else {
			if(originBoardDto.getFile2_size()>0) {
				boardDto.setFile2_path(originBoardDto.getFile2_path());
				boardDto.setFile2_type(originBoardDto.getFile2_type());
				boardDto.setFile2_name(originBoardDto.getFile2_name());
				boardDto.setFile2_size(originBoardDto.getFile2_size());
			} else {
				boardDto.setFile2_path("");
				boardDto.setFile2_type("");
				boardDto.setFile2_name("");
				boardDto.setFile2_size(0);
			}
		}
		return boardDao.modify(boardDto);
	}
	
	public int del_attach(int no, int file_no, HttpServletRequest request) {
		ServletContext context = request.getServletContext();
		BoardDto boardDto = boardDao.getOne(no);
		String savepath = context.getRealPath("/uploadfiles");
		File folder = new File(savepath);
		if(file_no==1) {
			if(boardDto.getFile1_size()>0) {
				File originTarget1 = new File(folder, boardDto.getFile1_path());
				originTarget1.delete();
				if(boardDto.getFile2_size()>0) {
					boardDto.setFile1_path(boardDto.getFile2_path());
					boardDto.setFile1_type(boardDto.getFile2_type());
					boardDto.setFile1_name(boardDto.getFile2_name());
					boardDto.setFile1_size(boardDto.getFile2_size());
					boardDto.setFile2_path("");
					boardDto.setFile2_type("");
					boardDto.setFile2_name("");
					boardDto.setFile2_size(0);
					boardDao.delAttach(boardDto);
					return 3;
				} else {
					boardDto.setFile1_path("");
					boardDto.setFile1_type("");
					boardDto.setFile1_name("");
					boardDto.setFile1_size(0);
					boardDto.setFile2_path("");
					boardDto.setFile2_type("");
					boardDto.setFile2_name("");
					boardDto.setFile2_size(0);
					boardDao.delAttach(boardDto);
					return 1;
				}
			} else {
				return 0;
			}
		} else if(file_no==2) {
			if(boardDto.getFile2_size()>0) {
				File originTarget2 = new File(folder, boardDto.getFile2_path());
				originTarget2.delete();
				boardDto.setFile2_path("");
				boardDto.setFile2_type("");
				boardDto.setFile2_name("");
				boardDto.setFile2_size(0);
				boardDao.delAttach(boardDto);
				return 2;
			} else {
				return 0;
			}
		} else {
			return 0;
		}
	}
	
	public int viewCountUp(int no) {
		return boardDao.viewCountUp(no);
	}
	
	public int getTotalPagenation(BoardDto boardDto) {
		int total = boardDao.countSearch(boardDto);
		if(boardDto.getSearch().equals("no")) total=1;
		int perview = Integer.parseInt(env.getProperty("view.hairart"));
		int pagenation = total/perview;
		if(total%perview!=0) pagenation++;
		if(pagenation==0) pagenation=1;
		return pagenation;
	}
	
	public int getMinPagenation(int no) {
		int perpage = Integer.parseInt(env.getProperty("pages.hairart"));
		if(no%perpage==0) {
			return ((no/perpage-1)*perpage+1);
		} else return ((no/perpage)*perpage+1);
	}
	
	public int getMaxPagenation(int no, BoardDto boardDto) {
		int perpage = Integer.parseInt(env.getProperty("pages.hairart"));
		int result = 0;
		if(no%perpage==0) {
			result = no;
		} else result = (no/perpage+1)*perpage;
		if(result<this.getTotalPagenation(boardDto)) return result;
		else return this.getTotalPagenation(boardDto);
	}
	
	public int getPrevPagenation(int no) {
		if(no==1) return 0;
		else return this.getMinPagenation(no)-1;
	}
	
	public int getNextPagenation(int no, BoardDto boardDto) {
		if(this.getMaxPagenation(no, boardDto)==this.getTotalPagenation(boardDto)) return 0;
		else return this.getMaxPagenation(no, boardDto)+1;
	}
	
	public List<BoardDto> getSearchList(int no, BoardDto boardDto) {
		int perview = Integer.parseInt(env.getProperty("view.hairart"));
		List<BoardDto> list = boardDao.getSearchList((no-1)*perview+1, perview, boardDto);
		return this.setString(list);
	}
	
	public List<BoardDto> getListForPage(int no, BoardDto boardDto) {
		List<BoardDto> list = this.getSearchList(no, boardDto);
		CurrentDate cdate = new CurrentDate();
		for(BoardDto boardDtoInList : list) {
			if(boardDtoInList.getDate_mod_str().substring(0, 10).equals(cdate.getStr1())) {
				boardDtoInList.setDate_mod_str(boardDtoInList.getDate_mod_str().substring(11, 16));
			} else if(boardDtoInList.getDate_mod_str().substring(0, 4).equals(String.valueOf(cdate.getYear()))) {
				boardDtoInList.setDate_mod_str(boardDtoInList.getDate_mod_str().substring(5, 10));
			} else {
				boardDtoInList.setDate_mod_str(boardDtoInList.getDate_mod_str().substring(0, 10));
			}
		}
		return list;
	}
}
