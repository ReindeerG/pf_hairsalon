package hairsalon.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoardDto {
	private int no;
	private String title;
	private Date date_new;
	private String date_new_str;
	private Date date_mod;
	private String date_mod_str;
	private String content;
	private int viewcount;
	private String file1_path;
	private String file1_type;
	private String file1_name;
	private long file1_size;
	private String file1_size_str;
	private String file2_path;
	private String file2_type;
	private String file2_name;
	private long file2_size;
	private String file2_size_str;
	private int files;
	/**
	 * 검색 및 정렬
	 */
	private String sort;
	private String search;
	private String keyword;
	private int liststart;
	private int listcount;
}
