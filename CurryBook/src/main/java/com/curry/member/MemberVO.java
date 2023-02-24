package com.curry.member;

public class MemberVO {
	private String id;
	private String pwd;
	private String name;
	private String gender;
	private String birth;
	private String email;
	private String zipcode;
	private String addr;
	private String marketing[];
	//checkbox로 여러개의 데이터를 하나의 변수에 저장하여 전달하므로 '배열'을 선언하여 받는다.
	private String path;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String[] getMarketing() {
		return marketing;
	}
	public void setmarketing(String[] marketing) {
		this.marketing = marketing;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
}
