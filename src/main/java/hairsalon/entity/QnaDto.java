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
public class QnaDto {
	private int no;
	private int customer;
	private String customer_name;
	private String customer_gender;
	private String customer_phone;
	private String customer_birth;
	private String question;
	private String title;
	private Date time_q;
	private String time_q_str;
	private String answer;
	private Date time_a;
	private String time_a_str;
	/**
	 * 검색 및 정렬
	 */
	private String search;
	private String keyword;
	private int liststart;
	private int listcount;
}