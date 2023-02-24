package com.curry.poll;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import com.curry.dbcp.DBConnectionMgr;
import com.curry.member.MemberVO;

public class PollDAO {
	
	private DBConnectionMgr pool;
	
	public PollDAO() {
		try { pool = DBConnectionMgr.getInstance(); }
		catch(Exception e) { e.printStackTrace(); }
	}
	
	public int getMaxNum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxNum = 0;
		
		try {
			con = pool.getConnection();
			sql = "select max(num) from tblPollList";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			//select문이 수행이 완료되면 rs.next()는 true를 반환한다.
			if(rs.next()) {
				maxNum = rs.getInt(1);
			}
		}
		catch(Exception e) { e.printStackTrace(); }
		finally { pool.freeConnection(con, pstmt, rs); }
		
		return maxNum;
	}
	
	public boolean insertPoll(PollListVO pvo, PollItemVO ivo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "insert into tblPollList (question,sdate,edate,wdate,type)"
					+ "values (?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, pvo.getQuestion());
			pstmt.setString(2, pvo.getSdate());
			pstmt.setString(3, pvo.getEdate());
			pstmt.setInt(4, pvo.getType());
			
			if(pstmt.executeUpdate() == 1) {
				sql = "insert into tblPollItem values (?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				int listnum = getMaxNum();
				//tblPollList 테이블에서 가장 큰 순번을 가져와서 listnum 변수에 저장한다.
				//왜? tblPollList 테이블의 num 컬럼의 값과 tblPollItem 테이블의 listnum 컬럼의 값을 동일하게 설정하기 위함이다. tblPollList 테이블의 설문(question)에 해당하는 순번(num)에 tblPollItem 테이블 항목(item)의 순번(listnum)을 매칭시켜서 그룹화한다.(묶는다.)
				//1번 질문에 5개 아이템을 1번으로 그룹화한다.(아이템 투표에서 설문에 맞는 아이템을 불러오기 위해)
				//2번 질분에 3개 아이템을 2번으로 그룹화한다.
				//tblPollList 테이블의 num 컬럼의 값(하나)과 tblPollItem 테이블의 listnum 컬럼의 값(여러개)을 동일하게 설정한다.
				String[] item = ivo.getItem();
				int num = 0;
				//투표 아이템의 개수만큼 반복문으로 INSERT문을 수행한다.
				for(int i=0; i<item.length; i++) {
					if(item[i] == null || item[i].equals("")) break; //반복문을 벗어난다.
					pstmt.setInt(1, listnum); //입력폼에 입력X: 모든 아이템에 같은 listnum을 설정한다.
					pstmt.setInt(2, i); //입력폼에 입력X: 아이템에 다른 itemnum을 설정한다.(구분자)
					pstmt.setString(3, item[i]); //item 배열의 원소 값(사용자가 입력한 아이템)들을 순번에 맞게 얻어와서 설정한다.
					pstmt.setInt(4, 0); //투표 횟수를 0으로 설정한다.
					num = pstmt.executeUpdate(); //tblPollItem 테이블에 아이템마다 한 행에 저장한다.
				}
				
				if(num == 1) flag = true;
			}
		}
		catch(Exception e) { e.printStackTrace(); }
		finally { pool.freeConnection(con, pstmt); }
		
		return flag;
	}
	
	public Vector<PollListVO> getPollList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PollListVO> vlist = new Vector<PollListVO>();
		
		try {
			con = pool.getConnection();
			sql = "select * from tblPollList order by num desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				PollListVO pvo = new PollListVO();
				pvo.setNum(rs.getInt("num"));
				pvo.setQuestion(rs.getString("question"));
				pvo.setSdate(rs.getString("sdate"));
				pvo.setEdate(rs.getString("edate"));
				pvo.setActive(rs.getInt("active"));
				
				vlist.add(pvo);
			}
		}
		catch(Exception e) { e.printStackTrace(); }
		finally { pool.freeConnection(con, pstmt, rs); }
		
		return vlist;
	}
	
	public PollListVO getPoll(int num) { //투표번호에 해당하는 투표목록을 얻는다.
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		PollListVO pvo = new PollListVO();
		
		try {
			con = pool.getConnection();
			//num에 전달받은 값이 없으면 전체 투표목록을 가져오고 num에 전달받은 값이 있으면 num에 해당하는 투표 목록을 가져온다.
			if(num == 0) sql = "select * from tblPollList order by num desc";
			else sql = "select * from tblPollList where num=" + num;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { //rs.next()가 true면 num에 해당하는 투표목록이 있다는 것이다.
				pvo.setQuestion(rs.getString("question"));
				pvo.setType(rs.getInt("type"));
				pvo.setActive(rs.getInt("active"));
			}
		}
		catch(Exception e) { e.printStackTrace(); }
		finally { pool.freeConnection(con, pstmt, rs); }
		
		return pvo;
	}
	
	public Vector<String> getItem(int num) {
		//투표번호에 해당하는 아이템들(여러 행)을 아이템 번호로 구분해서 얻는다.
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<String> itemList = new Vector<String>();
		
		try {
			con = pool.getConnection();
			//num에 전달받은 값이 없으면 전체 투표목록을 가져오고 num에 전달받은 값이 있으면 num에 해당하는 투표 목록을 가져온다.
			sql = "select item from tblPollItem where listnum=" + num;
			pstmt = con.prepareStatement(sql);
			if(num > 0) rs = pstmt.executeQuery();
			
			while(rs.next()) { //rs.next()가 true면 num에 해당하는 투표항목(아이템)이 있다는 것이다.
				itemList.add(rs.getString(1));
			}
		}
		catch(Exception e) { e.printStackTrace(); }
		finally { pool.freeConnection(con, pstmt, rs); }
		
		return itemList;
	}
	
	public boolean updatePoll(int num, String[] itemnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "update tblPollItem set count=count+1 where listnum=? and itemnum=?";
			pstmt = con.prepareStatement(sql);
			
			for(int i=0; i<itemnum.length; i++) {
				//체크한 투표항목(아이템)이 없을 때 반복문을 벗어나서 쿼리문을 수행하지 않는다.
				if(itemnum[i] == null || itemnum[i].equals("")) break;
				pstmt.setInt(1,  num); //투표번호를 설정한다.
				pstmt.setInt(2,  Integer.parseInt(itemnum[i])); //체크한 투표항목만 설정한다.
				int result = pstmt.executeUpdate(); //체크한 투표항목만 투표횟수를 1 증가한다.
				if(result > 0) flag = true;
			}
		}
		catch(Exception e) { e.printStackTrace(); }
		finally { pool.freeConnection(con, pstmt); }
		
		return flag;
	}
	
	public int getPollCount(int num) { //두표번호(num)를 전달받는다.
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int total = 0;
		
		try {
			con = pool.getConnection();
			if(num == 0) sql = "select sum(count) from tblPollItem";
			else sql = "select sum(count) from tblPollItem where listnum=" + num;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) total = rs.getInt(1);
		}
		catch(Exception e) { e.printStackTrace(); }
		finally { pool.freeConnection(con, pstmt, rs); }
		
		return total;
	}
	
	public Vector<PollItemVO> getViewList(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PollItemVO> itemList = new Vector<PollItemVO>();
		
		try {
			con = pool.getConnection();
			if(num == 0) sql = "select item, count from tblPollItem";
			else sql = "select item, count from tblPollItem where listnum=" + num;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			//rs는 SQL문의 결과(테이블)을 저장한다. 따라서 rs에는 행과 열이 있다.
			//rs에서 행을 이동할 때 next()를 사용하고 열의 값을 얻을 때 getXxx("컬럼명 or 컬럼순번")를 사용한다. Xxx는 컬럼의 데이터형이다.
			
			while(rs.next()) {
				PollItemVO ivo = new PollItemVO();
				//tblPollItem 테이블에서 행에 해당하는 열의 값을 얻어와서 PollItemVO에 설정한다.
				String[] item = new String[1];
				item[0] = rs.getString(1);
				//PollItemVO의 item이 문자열 배열로 선언했으므로 tblPollItem 테이블에서 하나의 투표항목을 얻지만 배열형태로 얻어와서 PollItemVO의 item에 문자열 배열로 설정한다. 따라서 문자열 배열 item을 선언하고 item 투표항목 하나를 첫번째 배열 원소(인덱스번호:0)로 저장한다.
				ivo.setItem(item);
				ivo.setCount(rs.getInt(2));
				
				itemList.add(ivo);
			}
		}
		catch(Exception e) { e.printStackTrace(); }
		finally { pool.freeConnection(con, pstmt, rs); }
		
		return itemList;
	}
	
	
}










