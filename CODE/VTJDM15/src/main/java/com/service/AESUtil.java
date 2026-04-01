package com.service;

import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class AESUtil {

	private static final byte[] STATIC_KEY = "0123456789abcdef".getBytes(StandardCharsets.UTF_8); // 16 bytes


	private static final String TRANSFORMATION = "AES/CBC/PKCS5Padding";


	public static String encrypt(String plaintext) throws Exception {
	Cipher cipher = Cipher.getInstance(TRANSFORMATION);
	SecretKeySpec keySpec = new SecretKeySpec(STATIC_KEY, "AES");
	byte[] iv = new byte[16];
	new SecureRandom().nextBytes(iv);
	IvParameterSpec ivSpec = new IvParameterSpec(iv);
	cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivSpec);
	byte[] cipherBytes = cipher.doFinal(plaintext.getBytes(StandardCharsets.UTF_8));
	String ivB64 = Base64.getEncoder().encodeToString(iv);
	String ctB64 = Base64.getEncoder().encodeToString(cipherBytes);
	return ivB64 + ":" + ctB64; // store as iv:ciphertext
	}


	public static String decrypt(String packed) throws Exception {
	String[] parts = packed.split(":", 2);
	byte[] iv = Base64.getDecoder().decode(parts[0]);
	byte[] ct = Base64.getDecoder().decode(parts[1]);
	Cipher cipher = Cipher.getInstance(TRANSFORMATION);
	SecretKeySpec keySpec = new SecretKeySpec(STATIC_KEY, "AES");
	cipher.init(Cipher.DECRYPT_MODE, keySpec, new IvParameterSpec(iv));
	byte[] pt = cipher.doFinal(ct);
	return new String(pt, StandardCharsets.UTF_8);
	}
}
