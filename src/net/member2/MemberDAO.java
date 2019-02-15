package net.member2;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import net.utility.DBClose;
import net.utility.DBOpen;

public class MemberDAO {

	private DBOpen dbopen = null;
	private DBClose dbclose = null;

	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private StringBuilder sql = null;

	public MemberDAO() {
		dbopen = new DBOpen();
		dbclose = new DBClose();
	}

	// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 로그인 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	public int login(String id, String passwd) throws Exception {

		int res = 0;
		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();

			sql.append(" SELECT count(id) as cnt");
			sql.append(" FROM MEMBER");
			sql.append(" WHERE id = ? AND passwd = ?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			rs = pstmt.executeQuery();

			if (rs.next() == true) {
				res = rs.getInt("cnt");
			}
		} catch (Exception e) {
			System.out.println("중복 확인 실패 : " + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		} // try end
		return res;
	}// login end

	// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 회원가입 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//

	public int createmem(MemberDTO dto) {
		int res = 0;
		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" INSERT INTO MEMBER(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate) ");
			sql.append(" VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, 'D1', sysdate)");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPasswd());
			pstmt.setString(3, dto.getMname());
			pstmt.setString(4, dto.getTel());
			pstmt.setString(5, dto.getEmail());
			pstmt.setString(6, dto.getZipcode());
			pstmt.setString(7, dto.getAddress1());
			pstmt.setString(8, dto.getAddress2());
			pstmt.setString(9, dto.getJob());

			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("추가실패 : " + e);
		} finally {
			dbclose.close(con, pstmt);
		} // try end
		return res;
	}// insert end

	// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 아이디중복확인 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//

	public int duplecateID(String id) {

		int cnt = 0;
		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();

			sql.append(" SELECT count(id) as cnt");
			sql.append(" FROM MEMBER");
			sql.append(" WHERE id = ?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				cnt = rs.getInt("cnt");
			}
		} catch (Exception e) {
			System.out.println("중복 확인 실패 : " + e);
		} finally {
			dbclose.close(con, pstmt);
		} // try end
		return cnt;
	}// duplecateID end

	// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 이메일중복확인 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//

	public int duplecateEmail(String email) {
		ResultSet rs = null;

		int cnt = 0;
		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();

			sql.append(" SELECT count(email) as cnt");
			sql.append(" FROM MEMBER");
			sql.append(" WHERE email = ?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				cnt = rs.getInt("cnt");
			}
		} catch (Exception e) {
			System.out.println("중복 확인 실패 : " + e);
		} finally {
			dbclose.close(con, pstmt);
		} // try end
		return cnt;
	}// duplecateID end

	// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 회원 정보수정 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//

	public MemberDTO modify(String id) {
		MemberDTO dto = new MemberDTO();
		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" SELECT id, passwd, mname, tel, email, zipcode, address1, address2, job");
			sql.append(" FROM MEMBER");
			sql.append(" WHERE id=?");
			pstmt= con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setMname(rs.getString("mname"));
				dto.setTel(rs.getString("tel"));
				dto.setEmail(rs.getString("email"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setAddress1(rs.getString("address1"));
				dto.setAddress2(rs.getString("address2"));
				dto.setJob(rs.getString("job"));
			}
		} catch (Exception e) {
			System.out.println("실패" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		} //try end

		return dto;
	}//modify end
	
	public int modifyproc(MemberDTO dto) {
		int res = 0;

		try {
			con = dbopen.getConnection();
			
			sql = new StringBuilder();
			sql.append(" UPDATE MEMBER");
			sql.append(" SET passwd=? ,mname=?, tel=?, email=?, zipcode=?, address1=?, address2=?, job=?");
			sql.append(" WHERE id=? AND passwd=?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getPasswd());
			pstmt.setString(2, dto.getMname());
			pstmt.setString(3, dto.getTel());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getZipcode());
			pstmt.setString(6, dto.getAddress1());
			pstmt.setString(7, dto.getAddress2());
			pstmt.setString(8, dto.getJob());
			pstmt.setString(9, dto.getId());
			pstmt.setString(10, dto.getPasswd());
			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("회원정보 변경 실패 : " + e);
			System.out.println(res); // 0 
		} finally {
			dbclose.close(con, pstmt);
		} //try end
		return res;
	}//modifyproc end
	
	
	// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 아이디 찾기 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//

	public String find_id(String mname, String email) {
		String id = null;
		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" SELECT id");
			sql.append(" FROM MEMBER");
			sql.append(" WHERE mname=? and email=?");
			pstmt= con.prepareStatement(sql.toString());
			pstmt.setString(1, mname);
			pstmt.setString(2, email);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				id = rs.getString("id");
			}
			else {
			}
		} catch (Exception e) {
			System.out.println("찾기 실패" + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		} //try end

		return id;
	}//findid end
	
	
	// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 임시비번 발송 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	
	 private static String randomPassword () {  
	        int index = 0;  
	        char[] charSet = new char[] {  
	                '0','1','2','3','4','5','6','7','8','9'  
	                ,'A','B','C','D','E','F','G','H','I','J','K','L','M'  
	                ,'N','O','P','Q','R','S','T','U','V','W','X','Y','Z'  
	                ,'a','b','c','d','e','f','g','h','i','j','k','l','m'  
	                ,'n','o','p','q','r','s','t','u','v','w','x','y','z'};  
	          
	        StringBuffer sb = new StringBuffer();  
	        for (int i=0; i<6; i++) {  
	            index =  (int) (charSet.length * Math.random());  
	            sb.append(charSet[index]);  
	        }  
	          
	        return sb.toString();  
	          
	    }//randomPassword end

	// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 비밀번호 찾기 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ// 
	
	public MemberDTO find_pw(MemberDTO dto) {
		
		int res = 0;
		//1) 임시비밀번호
		String random = randomPassword();
		//2) sql문 실행
		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" UPDATE MEMBER");
			sql.append(" SET passwd=?");
			sql.append(" WHERE mname=? AND tel=? AND email=? AND id=?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, random);
			pstmt.setString(2, dto.getMname());
			pstmt.setString(3, dto.getTel());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getId());
			res = pstmt.executeUpdate();
			//3) sql 실행여부에 따라 임시비밀번호 반환
			if(res>0) {
				dto.setPasswd(random);
			} //if end
		} catch (Exception e) {
			System.out.println("찾기 실패" + e);
		} finally {
			dbclose.close(con, pstmt);
		} //try end
		return dto;
	}//find_pw end
	
	// ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 회 원 탈 퇴 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//

	public int delete(String id, String passwd) throws Exception {
		int res = 0;
		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" DELETE FROM MEMBER");
			sql.append(" WHERE id=? AND passwd=?");

			System.out.println(id + passwd);

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("삭제 실패 : " + e);
		} finally {
			dbclose.close(con, pstmt);
		} // try end
		return res;
	}// delete end

}// class end
