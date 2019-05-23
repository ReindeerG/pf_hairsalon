package hairsalon.service;

import java.security.NoSuchAlgorithmException;

import org.springframework.stereotype.Service;

@Service
public interface EncryptService {
	String encrypt_ndbg(String origin) throws NoSuchAlgorithmException;
	String encrypt(String origin) throws NoSuchAlgorithmException;
	String encrypt(String origin, int count) throws NoSuchAlgorithmException;
}
