package com.curry.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import com.curry.dbcp.DBConnectionMgr;

public class MemberDAO {
	//1. 데이터베이스 연결(: 커넥션 풀에서 Connection 객체를 얻는다.)
	//2. 데이터를 처리(SQL문을 처리: PreparedStatement, 결괏값은 ResultSet 객체가 처리)
	
	//클래스 영역에서 클래스형으로 레퍼런스 변수 선언을 하면 "의존성 주입(반드시 주입)"의 대상이 된다.
	//인스턴스 변수는 초기화 하지 않는다. "가비지컬렉션"이 자동으로 회수한다.
	private DBConnectionMgr pool;
	
	//주입하는 방법은 자바에서 두 가지로 제공한다. 생성자를 사용하는 방법과 setters 메서드를 사용하는 방법이다.
	//의존성 주입은 생성자를 사용하여 주입한다.
	public MemberDAO() {
		//데이터베이스 연결 객체를 얻는 코드는 필수적으로 예외처리를 한다.
		try { pool = DBConnectionMgr.getInstance(); }
		catch(Exception e) { e.printStackTrace(); }
	}

	public boolean insertMember(MemberVO vo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		
		//데이터베이스 연결과 데이터 처리는 예외처리를 해야한다.
		try {
			con = pool.getConnection(); //커넥션 풀에서 커넥션 객체 하나를 얻는다.
			sql = "insert into tblMember (id,pwd,name,gender,birth,email,zipcode,addr,marketing,path,regdate)"
					+ "values (?,?,?,?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			//쿼리실행객체(pstmt)의 setXxx( )로 쿼리문의 위치홀더(?)에 VO의 속성 값을 설정한다.
			pstmt.setString(1, vo.getId());
			pstmt.setString(2, vo.getPwd());
			pstmt.setString(3, vo.getName());
			pstmt.setString(4, vo.getGender());
			pstmt.setString(5, vo.getBirth());
			pstmt.setString(6, vo.getEmail());
			pstmt.setString(7, vo.getZipcode());
			pstmt.setString(8, vo.getAddr());
			
			//데이터베이스 컬럼의 셀은 여러 개의 값을 저장할 수 없으므로 하나의 값으로 변환하는 작업을 한다.
			//체크를 했으면 1을 넣고 체크를 안했으면 0을 넣어서 하나의 값으로 만든다.
			//사용자가 인터넷과 게임을 체크하면 '10100'로 하나의 결과 값을 만든다.
			String[] marketing = vo.getMarketing(); //체크한 취미를 얻는다.
			String[] list = {"인터넷", "SNS", "문자", "우편", "없음"};
			char[] hb = {'0','0','0','0','0'};
			
			//hobby 배열의 원소 하나와 모든 list 배열의 원소들을 비교하여 같은 원소가 있으면 1, 없으면 0으로 처리한다.
			for(int i=0; i < marketing.length; i++) {
				for(int j=0; j < list.length; j++) {
					if(marketing[i].equals(list[j])) { hb[j] = '1'; }
					//만약 사용자가 선택한 취미와 같은 취미가 있으면 배열 hb에 1을 넣는다.
				}
			}
			
			pstmt.setString(9, new String(hb));
			//hb는 char형 배열이므로 문자열(문자 배열)로 객체화하여 9번째 위치홀더에 설정한다.
			pstmt.setString(10, vo.getPath());
			
			//쿼리문 수행은 executeQuery()와 executeUpdate()가 있다.
			//executeQuery()는 SELECT문을 수행할 때 사용하고 executeUpdate()는 INSERT, UPDATE, DLELTE문을 수행할 때 사용한다. executeQuery()는 결괏 값을 ResultSet 객체에 반환하고 executeUpdate()는 성공하면 1, 실패하면 0을 반환한다.
			if(pstmt.executeUpdate() == 1) flag = true;
		}
		catch(Exception e) { e.printStackTrace(); }
		finally { pool.freeConnection(con, pstmt); } //사용한 객체를 커넥션 풀로 반납한다.
		
		return flag; //insertMember()를 호출한 곳으로 반환한다.
	}
	
	public boolean checkId(String id) { //아이디 중복 체크
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "select id from tblMember where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			flag = pstmt.executeQuery().next();
			//next()는 다음 행으로 커서를 옮기며, 다음 행이 있으면 true, 없으면 false를 반환한다.
		}
		catch(Exception e) { e.printStackTrace(); }
		finally { pool.freeConnection(con, pstmt); }
		
		return flag;
	}
	
	public Vector<ZipcodeVO> zipcodeRead(String area3) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ZipcodeVO> vlist = new Vector<ZipcodeVO>();
		
		try {
			con = pool.getConnection();
			sql = "select * from tblZipcode where area3 like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+area3+"%");
			rs = pstmt.executeQuery(); //rs 는 데이터베이스에서 얻어 온 데이터를 저장한다.
			//rs에 있는 데이터를 행 단위로 ZipcodeVO에 설정한다.
			while(rs.next()) { //테이블에 행이 있으면 반복 수행한다.
				ZipcodeVO zvo = new ZipcodeVO();
				zvo.setZipcode(rs.getString(1));
				zvo.setArea1(rs.getString(2));
				zvo.setArea2(rs.getString(3));
				zvo.setArea3(rs.getString(4));
				zvo.setArea4(rs.getString(5));
				
				vlist.add(zvo); //Vector에 ZipcodeVO를 추가한다. Vector는 가변적인 크기를 가진다.
			}
		}
		catch(Exception e) { e.printStackTrace(); }
		finally { pool.freeConnection(con, pstmt, rs); }
		
		return vlist;
	}
	
	public boolean loginCheck(String id, String pwd) { //로그인 처리
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "select id from tblMember where id=? and pwd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			flag = rs.next(); //사용자가 입력한 아이디, 비밀번호와 일치하는 값이 데이터베이스에 있으면 rs.next()는 true를 반환하다.
		}
		catch(Exception e) { e.printStackTrace(); }
		finally { pool.freeConnection(con, pstmt, rs); }
		
		return flag;
	}
	
	public MemberVO getMyInfo(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO vo = null;
		String sql = null;
		
		try {
			con = pool.getConnection();
			sql = "select * from tblMember where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo = new MemberVO();
				vo.setId(rs.getString("id"));
				vo.setPwd(rs.getString("pwd"));
				vo.setName(rs.getString("name"));
				vo.setGender(rs.getString("gender"));
				vo.setBirth(rs.getString("birth"));
				vo.setEmail(rs.getString("email"));
				vo.setZipcode(rs.getString("zipcode"));
				vo.setAddr(rs.getString("addr"));
				//취미 컬럼은 '10100' 값으로 저장되어있다. 체크한 취미는 '1', 체크 안한 취미는 '0'으로 저장했다.
				String[] marketings = new String[5];
				String marketing = rs.getString("marketing"); //'10100'
				
				for(int i=0; i<marketings.length; i++) {
					marketings[i] = marketing.substring(i, i+1);
					//문자열을 잘라서 반환하는 substring(시작 순번, 끝 순번)를 사용한다.
					//hobbys[0] = hobby.substring(0, 1); > '1'
					//hobbys[1] = hobby.substring(1, 2); > '0'
					//hobbys[2] = hobby.substring(2, 3); > '1'
					//hobbys[3] = hobby.substring(3, 4); > '0'
					//hobbys[4] = hobby.substring(4, 5); > '0'
				}
				vo.setmarketing(marketings);
				vo.setPath(rs.getString("path"));
			}
		}
		catch(Exception e) { e.printStackTrace(); }
		finally { pool.freeConnection(con, pstmt, rs); }
		
		return vo;
	}
	
	public boolean updateMember(MemberVO vo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "update tblMember set pwd=?,name=?,gender=?,birth=?,email=?,zipcode=?,addr=?,marketing=?,path=?"
						+"where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getPwd());
			pstmt.setString(2, vo.getName());
			pstmt.setString(3, vo.getGender());
			pstmt.setString(4, vo.getBirth());
			pstmt.setString(5, vo.getEmail());
			pstmt.setString(6, vo.getZipcode());
			pstmt.setString(7, vo.getAddr());
			
			String[] marketing = vo.getMarketing();
			String[] list = {"인터넷", "SNS", "문자", "우편", "없음"};
			char[] hb = {'0','0','0','0','0'};
			
			for(int i=0; i <marketing.length; i++) {
				for(int j=0; j < list.length; j++) {
					if(marketing[i].equals(list[j])) { hb[j] = '1'; }
				}
			}
			
			pstmt.setString(8, new String(hb));
			pstmt.setString(9, vo.getPath());
			pstmt.setString(10, vo.getId());
			
			if(pstmt.executeUpdate() == 1) flag = true;
		}
		catch(Exception e) { e.printStackTrace(); }
		finally { pool.freeConnection(con, pstmt); }
		
		return flag;
	}
	
	
	public boolean deleteMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			sql = "delete from tblMember where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			if(pstmt.executeUpdate() == 1) flag = true;
		}
		catch(Exception e) { e.printStackTrace(); }
		finally { pool.freeConnection(con, pstmt); }
		
		return flag;
	}
	
	public Vector<MemberVO> getMemberList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MemberVO> mlist = new Vector<MemberVO>();
		
		try {
			con = pool.getConnection();
			sql = "select * from tblMember";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberVO mvo = new MemberVO();
				mvo.setId(rs.getString(1));
				mvo.setPwd(rs.getString(2));
				mvo.setName(rs.getString(3));
				mvo.setGender(rs.getString(4));
				mvo.setBirth(rs.getString(5));
				mvo.setEmail(rs.getString(6));
				mvo.setZipcode(rs.getString(7));
				mvo.setAddr(rs.getString(8));
				
				String[] marketings = new String[5];
				String marketing = rs.getString(9);
				
				for(int i=0; i<marketings.length; i++) {
					marketings[i] = marketing.substring(i, i+1);
				}
				
				mvo.setmarketing(marketings);
				mvo.setPath(rs.getString(10));
				
				mlist.add(mvo);
			}
		}
		catch(Exception e) { e.printStackTrace(); }
		finally { pool.freeConnection(con, pstmt, rs); }
		
		return mlist;
	}
}









