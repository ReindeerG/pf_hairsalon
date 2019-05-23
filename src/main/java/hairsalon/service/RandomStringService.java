package hairsalon.service;

import java.util.ArrayList;
import java.util.Collections;

import org.springframework.stereotype.Service;

@Service("randomStringService")
public class RandomStringService {
	public String getRandomString(int size) {
		ArrayList<Character> list = new ArrayList<>();
		for(char c='a';c<='z';c++) {
			list.add(c);
		}
		for(char c='A';c<='Z';c++) {
			list.add(c);
		}
		for(char c='0';c<='9';c++) {
			list.add(c);
		}
		StringBuilder builder = new StringBuilder();
		for(int i=0;i<=size;i++) {
			Collections.shuffle(list);
			builder.append(list.get(0));
		}
		return builder.toString();
	}
}
