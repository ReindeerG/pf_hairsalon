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
public class HairorderDto {
	private int no;
	private int reservation;
	private Date whatday;
	private String whatday_str;
	private int starttime;
	private String time;
	private int customer;
	private String customer_name;
	private String customer_gender;
	private String customer_phone;
	private int designer;
	private String designer_str;
	private int design;
	private String design_str;
	private long price;
	private long plus;
	private long dc;
	private long finalprice;
	private String paytype;
	private String memo;
	/**
	 * 검색 및 정렬
	 */
	private String sort;
	private String search;
	private String keyword;
	private int liststart;
	private int listcount;
}
