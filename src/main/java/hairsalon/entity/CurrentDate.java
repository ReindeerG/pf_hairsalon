package hairsalon.entity;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import lombok.Data;

@Data
public class CurrentDate {
	private int day;
	private int endday;
	private int year;
	private int month;
	private int date;
	private String str1;	// 2019-01-01
	private String str2;	// 2019-01-01-3
	private String str3;	// 2019년 1월 1일 화요일
	private int numtime;	//	1000, 1010, 1050, 1100, ...
	public CurrentDate() {
		Calendar c = Calendar.getInstance(Locale.KOREA);
		this.setDay(c.get(c.DAY_OF_WEEK));		// 일(1)-토(7)
		this.setYear(c.get(c.YEAR));
		this.setMonth(c.get(c.MONTH)+1);
		this.setDate(c.get(c.DATE));
		this.setEndday(c.getActualMaximum(c.DAY_OF_MONTH));
		
		String month_str = String.valueOf(month);
		String date_str = String.valueOf(date);
		if(month<10) month_str = "0"+month_str;
		if(date<10) date_str = "0"+date_str;
		this.setStr1(this.getYear()+"-"+month_str+"-"+date_str);
		this.setStr2(this.getStr1()+"-"+this.getDay());
		this.setStr3(this.getYear()+"년 "+this.getMonth()+"월 "+this.getDate()+"일 "+this.getDay_str(day)+"요일");
		Date d = new Date();
		SimpleDateFormat format1 = new SimpleDateFormat("hh");
		SimpleDateFormat format2 = new SimpleDateFormat("mm");
		String hour_str = format1.format(d);
		String min_str = format2.format(d);
		int hour = Integer.parseInt(hour_str)*100;
		float min_temp = Integer.parseInt(min_str)/60.0f;
		int min = Math.round(min_temp*100);
		this.setNumtime(hour+min);
	}
	
	private String getDay_str(int day) {
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
		return day_str;
	}
}

