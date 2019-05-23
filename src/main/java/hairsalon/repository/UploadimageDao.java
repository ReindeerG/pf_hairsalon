package hairsalon.repository;

import java.util.List;

import org.springframework.stereotype.Repository;

import hairsalon.entity.UploadimageDto;

public interface UploadimageDao {
	List<String> listBoardno(int no);
	List<String> precheckSelect(UploadimageDto uploadimageDto);
	int precheckDelete(UploadimageDto uploadimageDto);
	int insert(UploadimageDto uploadimageDto);
	UploadimageDto getOne(int no);
	int delete(int no);
	int delete_path(String file_path);
	int delete_board(int board_no);
}