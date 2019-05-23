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
public class ReservationDto {
	private int no;
	private int reservation;
	private Date whatday;
	private String whatday_str;
	private int starttime;
	private String starttime_str;
	private int period;
	private String endtime_str;
	private int customer;
	private String customer_name;
	private String customer_gender;
	private String customer_phone;
	private String customer_birth_str;
	private int design;
	private String design_str;
	private int designer;
	private String designer_str;
	private int state;
	private long price;
}
