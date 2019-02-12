package net.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import net.utility.DBClose;
import net.utility.DBOpen;
import net.utility.Utility;

public class MemberDAO {
	private DBOpen dbopen = null;
	private DBClose dbclose = null;

	private Connection con = null;
	private PreparedStatement pstmt = null;
	private StringBuilder sql = null;

	public MemberDAO() {
		dbopen = new DBOpen();
		dbclose = new DBClose();
	}//MemberDAO end

	public int duplecateID(String id) {
		ResultSet rs = null;

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
		} //try end
		return cnt;
	}//duplecateID end

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
		} //try end
		return cnt;
	}//duplecateID end

	public int insert(MemberDTO dto) {
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
		} //try end
		return res;
	}//insert end

	public String loginProc(MemberDTO dto) {
		ResultSet rs = null;

		String mlevel = null;
		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();

			sql.append(" SELECT mlevel");
			sql.append(" FROM MEMBER");
			sql.append(" WHERE id = ? AND passwd=?");
			sql.append(" AND mlevel IN ('A1', 'B1', 'C1', 'D1')");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPasswd());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				mlevel = rs.getString("mlevel");
			}
		} catch (Exception e) {
			System.out.println("로그인 실패 : " + e);
		} finally {
			dbclose.close(con, pstmt);
		} //try end
		return mlevel;

	}// login end


	 public int count(String col, String word) { //글 갯수 
		 ResultSet rs = null;
		 int cnt = 0;
		 try {
			 con=dbopen.getConnection();
			 sql=new StringBuilder();
			 sql.append(" SELECT COUNT(*) as cnt ");
			 sql.append(" FROM member ");
			 
			 if(word.length()>=1) {
				 String search = "";
				 if(col.equals("id")) {
					search += " WHERE id LIke '%" + word + "%'";
			 }else if(col.equals("mname")) {
				 	search += " WHERE mname LIke '%" + word + "%'";
	 		 }else if(col.equals("email")) {
				 	search += " WHERE email LIke '%" + word + "%'";
	 		 }else if(col.equals("mlevel")) {
	 			 search += " WHERE mlevel LIke '%" + word + "%'";
	 		 }else if(col.equals("mdate")) {
	 			 search += " WHERE mdate LIke '%" + word + "%'";
	 		 }
			 sql.append(search);
			 } 
			 pstmt = con.prepareStatement(sql.toString());
			 rs = pstmt.executeQuery();
			 if(rs.next()) {
				 cnt = rs.getInt("cnt");
			 }
		 }catch(Exception e) {
			 System.out.println("글갯수 실패 : " + e); 
		 }finally {
			 dbclose.close(con, pstmt, rs);
		 }
		 return cnt;
	 }//count end

	public ArrayList<MemberDTO> list(String col) { // 정렬
		ResultSet rs = null;
		StringBuffer sql = null;
		ArrayList<MemberDTO> list = null;
		try {
			con = dbopen.getConnection();
			sql = new StringBuffer();
			sql.append(" SELECT id, passwd, mname, tel, email, mdate, mlevel");
			sql.append(" FROM member");

			if (col.equals("id") || col.equals("")) {
				sql.append(" ORDER BY id ASC");
			} else if (col.equals("mname")) {
				sql.append(" ORDER BY mname ASC");
			} else if (col.equals("mdate")) {
				sql.append(" ORDER BY mdate DESC");
			} else if (col.equals("mlevel")) {
				sql.append(" ORDER BY mlevel ASC");

			} //if end

			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			if (rs.next()) { //자료가 존재하느냐? cursor가 존재하느냐?
				list = new ArrayList<MemberDTO>();
				do {
					MemberDTO dto = new MemberDTO();
					dto.setId(rs.getString("id"));
					dto.setPasswd(rs.getString("passwd"));
					dto.setMname(rs.getString("mname"));
					dto.setTel(Utility.checkNull(rs.getString("tel")));
					dto.setEmail(rs.getString("email"));
					dto.setMdate(rs.getString("mdate"));
					dto.setMlevel(rs.getString("mlevel"));
					list.add(dto);

				} while (rs.next());
			} else {
				System.out.println("else");
			}

		} catch (Exception e) {
			System.out.println(e);
		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return list;
	}// list end
	
	
	 public ArrayList<MemberDTO> list(String col, String word, int nowPage, int recordPerPage) { 
	 	 ArrayList<MemberDTO> list = null;   // 회원목록 (관리자페이지)
	 	 ResultSet rs=null;
	    // 10: 페이지당 출력할 레코드 갯수
	    int startRow = ((nowPage-1) * recordPerPage) + 1; // (0 * 10) + 1 = 1, 11, 21
	    int endRow = nowPage * recordPerPage;             // 1 * 10 = 10, 20, 30
	    
	    /*
	     1 page: WHERE r >= 1 AND r <= 10;
	     2 page: WHERE r >= 11 AND r <= 20;
	     3 page: WHERE r >= 21 AND r <= 30;
	     */
	    
	    try {
	      con = dbopen.getConnection();
	      StringBuffer sql = new StringBuffer();
	      
	      word = word.trim(); // 문자열 좌우 공백 제거
	      
	      if (word.length() == 0){ // 검색을 안하는 경우
	        sql.append(" SELECT id, passwd, mname, email, tel, mlevel, mdate, r");
	        sql.append(" FROM(");
	        sql.append("      SELECT id, passwd, mname, email, tel, mlevel, mdate, rownum as r");
	        sql.append("      FROM (");
	        sql.append("           SELECT id, passwd, mname, email, tel, mlevel, mdate");
	        sql.append("           FROM member ");
	        sql.append("           ORDER BY id DESC");
	        sql.append("      )");
	        sql.append(" )     ");
	        sql.append(" WHERE r >= "+startRow+" AND r <= "+endRow);
	        
	        pstmt = con.prepareStatement(sql.toString());
	        
	      }
	      else{ // 검색을 하는 경우
	        sql.append(" SELECT id, passwd, mname, email, tel, mlevel, mdate, r");
	        sql.append(" FROM(");
	        sql.append("      SELECT id, passwd, mname, email, tel, mlevel, mdate, rownum as r");
	        sql.append("      FROM (");
	        sql.append("           SELECT id, passwd, mname, email, tel, mlevel, mdate");
	        sql.append("           FROM member ");
	               
	        //검색
	        if(word.length()>=1){
	          String search=" WHERE "+col+" LIKE '%"+word+"%'";
	          sql.append(search);
	        } 
	        
	        sql.append("           ORDER BY id DESC");
	        sql.append("      )");
	        sql.append(" )     ");
	        sql.append(" WHERE r >= "+startRow+" AND r <= "+endRow);
	        
	        pstmt = con.prepareStatement(sql.toString());

	      }
	      
	      rs=pstmt.executeQuery();
	      if(rs.next()) {
	        list=new ArrayList<MemberDTO>();
	        MemberDTO dto=null; //레코드 1개보관
	        do {
	        	
	          dto= new MemberDTO();
	          dto.setId(rs.getString("id"));
	          dto.setPasswd(rs.getString("passwd"));
	          dto.setMname(rs.getString("mname"));
	          dto.setTel(rs.getString("tel"));
	          dto.setEmail(rs.getString("email"));
	          dto.setMlevel(rs.getString("mlevel"));
	          dto.setMdate(rs.getString("mdate"));
	          list.add(dto);
	        }while(rs.next());
	      }

	    } catch (Exception e) {
	      System.out.println(e.toString());
	    } finally {
	      dbclose.close(con, pstmt, rs);
	    }

	    return list;
	    
	  } // list() end
	 
	 
	public int level(String id, String mlevel) {  //회원 등급 변경
		int res = 0;

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" UPDATE member");
			sql.append(" SET mlevel=?");
			sql.append(" WHERE id = ?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, mlevel);
			pstmt.setString(2, id);
			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("등급 변경 실패 : " + e);
		} finally {
			dbclose.close(con, pstmt);
		} //try end
		return res;
	}//level end
	
	public int delete(String id) { // 관리자페이지 - 회원 삭제
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = null;
		int res = 0;
		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" DELETE FROM member");
			sql.append(" WHERE id=?");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("삭제 실패 : " + e);
		} finally {
			dbclose.close(con, pstmt);
		} //try end
		return res;
	}//delete end


	
	public int delete(String id, String passwd) { // 회원탈퇴 
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = null;
		int res = 0;
		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" UPDATE MEMBER");
			sql.append(" SET mlevel='F1'");
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
		} //try end
		return res;
	}//delete end

	public int modifyproc(MemberDTO dto, String oldpasswd) {
		int res = 0;

		try {
			con = dbopen.getConnection();
			String pw = dto.getPasswd();
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
			pstmt.setString(10, oldpasswd);
			res = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("회원정보 변경 실패 : " + e);
			System.out.println(res); // 0 
		} finally {
			dbclose.close(con, pstmt);
		} //try end
		return res;
	}//modifyproc end

	public MemberDTO modify(String id) {
		ResultSet rs = null;
		MemberDTO dto = new MemberDTO();
		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" SELECT id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel");
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
	
	public String find_id(String mname, String email) {
		ResultSet rs= null;
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
}//clss end