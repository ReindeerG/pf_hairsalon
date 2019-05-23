package hairsalon.service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class SHA512Service implements EncryptService {
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	public String encrypt_ndbg(String origin) throws NoSuchAlgorithmException {
		MessageDigest digest = MessageDigest.getInstance("SHA-512");
		digest.update(origin.getBytes());
		byte[] data = digest.digest();
		StringBuffer buffer = new StringBuffer();
		for(int i=0;i<data.length;i++) {
			int value = (data[i] & 0xFF) + 0x100;
			buffer.append(Integer.toString(value, 16).substring(1));
		}
		return buffer.toString();
	}
	
	public String encrypt(String origin) throws NoSuchAlgorithmException {
//		log.debug("Origin String: {}", origin);

		MessageDigest digest = MessageDigest.getInstance("SHA-512");
		digest.update(origin.getBytes());
		byte[] data = digest.digest();
		
		StringBuffer buffer = new StringBuffer();
		for(int i=0;i<data.length;i++) {
			int value = (data[i] & 0xFF) + 0x100;
			buffer.append(Integer.toString(value, 16).substring(1));
		}
		String change = buffer.toString();
//		log.debug("Encrypted String: {}", change);
		
		return change;
	}
	
	public String encrypt(String origin, int count) throws NoSuchAlgorithmException {
		String str = origin;
//		log.debug("Origin String: {}", str);
		for(int i=1;i<=count;i++) {
			str = this.encrypt_ndbg(str);
//			log.debug("Encrypted({}/{}) String: {}",i,count,str);
		}
//		log.debug("Encrypted String: {}", str);
		return str;
	}
}
