package com.curry.poll;

public class PollItemVO {
	private int listnum; //투표 번호(tblPollList 테이블의 num 컬럼 값과 그룹화한다.)
	private int itemnum; //투표 항목(아이템) 번호
	private String[] item; //투표 항목(아이템)
	private int count; //투표 횟수
	
	public int getListnum() {
		return listnum;
	}
	public void setListnum(int listnum) {
		this.listnum = listnum;
	}
	public int getItemnum() {
		return itemnum;
	}
	public void setItemnum(int itemnum) {
		this.itemnum = itemnum;
	}
	public String[] getItem() {
		return item;
	}
	public void setItem(String[] item) {
		this.item = item;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
}
