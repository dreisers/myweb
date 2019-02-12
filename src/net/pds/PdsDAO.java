package net.pds;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import net.pds.PdsDTO;
import net.utility.DBClose;
import net.utility.DBOpen;
import net.utility.Utility;

public class PdsDAO {
	private DBOpen dbopen = null;
	private DBClose dbclose = null;

	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private StringBuilder sql = null;

	public PdsDAO() {
		dbopen = new DBOpen();
		dbclose = new DBClose();
	}

	public boolean insert(PdsDTO dto) { // 글쓰기

		boolean flag = false;
		int res = 0;
		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" INSERT INTO tb_pds(pdsno, wname, subject, passwd, filename, filesize, regdate)");
			sql.append(" VALUES((SELECT nvl(max(pdsno),0)+1 FROM tb_pds)");
			sql.append(" ,?,?,?,?,?,sysdate)");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getPasswd());
			pstmt.setString(4, dto.getFilename());
			pstmt.setLong(5, dto.getFilesize());
			res = pstmt.executeUpdate();
			if (res == 1)
				flag = true;
		} catch (Exception e) {
			System.out.println("추가실패 : " + e);
		} finally {
			dbclose.close(con, pstmt);
		} // try end
		return flag;
	}// insert end

	public synchronized ArrayList<PdsDTO> list() { // 글 목록 (회원)

		ArrayList<PdsDTO> list = null;
		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" SELECT pdsno, subject, wname, regdate, readcnt, filename");
			sql.append(" FROM tb_pds");
			sql.append(" ORDER BY regdate DESC");
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			if (rs.next()) { // 자료가 존재하느냐? cursor가 존재하느냐?
				list = new ArrayList<PdsDTO>();
				do {
					PdsDTO dto = new PdsDTO();
					dto.setPdsno(rs.getInt("pdsno"));
					dto.setSubject(rs.getString("subject"));
					dto.setWname(rs.getString("wname"));
					dto.setReadcnt(rs.getInt("readcnt"));
					dto.setFilename(rs.getString("filename"));
					dto.setRegdate(rs.getString("regdate"));
					list.add(dto);
				} while (rs.next());
			}

		} catch (Exception e) {
			System.out.println(e);

		} finally {
			dbclose.close(con, pstmt, rs);
		}

		return list;
	}

	
	 public ArrayList<PdsDTO> list(String col, String word, int nowPage, int recordPerPage) { 
		 	 ArrayList<PdsDTO> list = null;   // 글 목록 (관리자페이지)

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
		        sql.append(" SELECT pdsno, wname, subject, regdate, readcnt, filename, r");
		        sql.append(" FROM(");
		        sql.append("      SELECT pdsno, wname, subject, regdate, readcnt, filename, rownum as r");
		        sql.append("      FROM (");
		        sql.append("           SELECT pdsno, wname, subject, regdate, readcnt, filename");
		        sql.append("           FROM tb_pds ");
		        sql.append("           ORDER BY pdsno DESC");
		        sql.append("      )");
		        sql.append(" )     ");
		        sql.append(" WHERE r >= "+startRow+" AND r <= "+endRow);
		        
		        pstmt = con.prepareStatement(sql.toString());
		        
		      }
		      else{ // 검색을 하는 경우
		        sql.append(" SELECT pdsno, wname, subject, regdate, readcnt, filename, r");
		        sql.append(" FROM(");
		        sql.append("      SELECT pdsno, wname, subject, regdate, readcnt, filename, rownum as r");
		        sql.append("      FROM (");
		        sql.append("           SELECT pdsno, wname, subject, regdate, readcnt, filename");
		        sql.append("           FROM tb_pds ");
		               
		        //검색
		        if(word.length()>=1){
		          String search=" WHERE "+col+" LIKE '%"+word+"%'";
		          sql.append(search);
		        } 
		        
		        sql.append("           ORDER BY pdsno DESC");
		        sql.append("      )");
		        sql.append(" )     ");
		        sql.append(" WHERE r >= "+startRow+" AND r <= "+endRow);
		        
		        pstmt = con.prepareStatement(sql.toString());

		      }
		      
		      rs=pstmt.executeQuery();
		      if(rs.next()) {
		        list=new ArrayList<PdsDTO>();
		        PdsDTO dto=null; //레코드 1개보관
		        do {
		        	
		          dto= new PdsDTO();
		          dto.setPdsno(rs.getInt("pdsno"));
		          dto.setSubject(rs.getString("subject"));
		          dto.setWname(rs.getString("wname"));
		          dto.setRegdate(rs.getString("regdate"));
		          dto.setReadcnt(rs.getInt("readcnt"));
		          dto.setFilename(rs.getString("filename"));
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
	
	 public int count(String col, String word) { //글 갯수 
		 int cnt = 0;
		 try {
			 con=dbopen.getConnection();
			 sql=new StringBuilder();
			 sql.append(" SELECT COUNT(*) as cnt ");
			 sql.append(" FROM tb_pds ");
			 
			 if(word.length()>=1) {
				 String search = "";
				 if(col.equals("wname")) {
					search += " WHERE wname LIke '%" + word + "%'";
			 }else if(col.equals("subject")) {
				 	search += " WHERE subject LIke '%" + word + "%'";
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
			 dbclose.close(con, pstmt, rs);;
		 }
		 return cnt;
	 }//count end
	 
	 
	
	public PdsDTO read(int Pdsno) {  // 글 상세보기
		PdsDTO dto = null;

		try {
			increment(Pdsno); // 조회수 증가
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" SELECT  wname, subject, regdate, passwd, readcnt, filename, filesize ");
			sql.append(" FROM tb_pds ");
			sql.append(" WHERE pdsno=? ");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, Pdsno);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new PdsDTO();
				dto.setWname(rs.getString("wname"));
				dto.setSubject(rs.getString("subject"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setReadcnt(rs.getInt("readcnt"));
				dto.setFilename(rs.getString("filename"));
				dto.setFilesize(rs.getLong("filesize"));
			}
		} catch (Exception e) {
			System.out.println("상세보기 에러");
		} finally {
			dbclose.close(con, pstmt, rs);
		}
		return dto;
	}

	public void increment(int pdsno) {  // 조회수 증가

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" UPDATE tb_pds");
			sql.append(" SET readcnt=readcnt+1");
			sql.append(" WHERE pdsno=?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, pdsno);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("조회수 에러");
		} finally {
			dbclose.close(con, pstmt);
		}
	}// increment end

	public int delete(int pdsno, String saveDir) {
		int res = 0;
		try {
			// 파일삭제하려는 파일명을 가져온다
			String filename = "";
			PdsDTO oldDTO = read(pdsno);
			if (oldDTO != null) {
				filename = oldDTO.getFilename();
			} // if end

			con = dbopen.getConnection();
			sql = new StringBuilder();

			sql.append(" DELETE FROM tb_pds");
			sql.append(" WHERE pdsno=?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, pdsno);
			res = pstmt.executeUpdate();
			if (res == 1) {
				// 테이블에서 레코드가 성공적으로 삭제가 되면
				// 첨부된 파일도 삭제
				Utility.deleteFile(saveDir, filename);
			}
		} catch (Exception e) {
			System.out.println("삭제실패 : " + e);
		} finally {
			dbclose.close(con, pstmt);
		}
		return res;

	}// delete end	
	
	
	public int delete(int pdsno, String passwd, String saveDir) {
		int res = 0;
		try {
			// 파일삭제하려는 파일명을 가져온다
			String filename = "";
			PdsDTO oldDTO = read(pdsno);
			if (oldDTO != null) {
				filename = oldDTO.getFilename();
			} // if end

			con = dbopen.getConnection();
			sql = new StringBuilder();

			sql.append(" DELETE FROM tb_pds");
			sql.append(" WHERE pdsno=? AND passwd=?");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, pdsno);
			pstmt.setString(2, passwd);
			res = pstmt.executeUpdate();
			if (res == 1) {
				// 테이블에서 레코드가 성공적으로 삭제가 되면
				// 첨부된 파일도 삭제
				Utility.deleteFile(saveDir, filename);
			}
		} catch (Exception e) {
			System.out.println("삭제실패 : " + e);
		} finally {
			dbclose.close(con, pstmt);
		}
		return res;

	}// delete end

	public PdsDTO updateform(PdsDTO dto) {  // 글 수정

		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" SELECT subject, wname, passwd, filename");
			sql.append(" FROM tb_pds");
			sql.append(" WHERE passwd=? AND pdsno=?");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getPasswd());
			pstmt.setInt(2, dto.getPdsno());

			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new PdsDTO();

				dto.setSubject(rs.getString("subject"));
				dto.setWname(rs.getString("wname"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setFilename(rs.getString("filename"));
			} else {
				dto = null;
			}

		} catch (Exception e) {
			System.out.println("글 수정 실패 : " + e);
		} finally {
			dbclose.close(con, pstmt, rs);
		} // try end
		return dto;

	}// updateform end

	public int updateproc(PdsDTO dto, String saveDir) { // 파일 있을때
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = null;
		int res = 0;

		try {
			String filename = "";
			PdsDTO oldDTO = read(dto.getPdsno());
			if (oldDTO != null) {
				filename = oldDTO.getFilename();
			} // if end

			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" UPDATE tb_pds");
			sql.append(" SET wname=?, subject=?, passwd=?, filename=?, filesize=?");
			sql.append(" WHERE pdsno=?");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getPasswd());
			pstmt.setString(4, dto.getFilename());
			pstmt.setLong(5, dto.getFilesize());
			pstmt.setInt(6, dto.getPdsno());
			res = pstmt.executeUpdate();

			if (res != 0) {
				Utility.deleteFile(saveDir, filename);
			}
		} catch (Exception e) {
			System.out.println(" 실패 : " + e);
		} finally {
			dbclose.close(con, pstmt);
		} // try end
		return res;
	}// updateproc end

	public int updateproc(PdsDTO dto) { // 파일 없을때
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = null;
		int res = 0;
		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" UPDATE tb_pds");
			sql.append(" SET wname=?, subject=?, passwd=?");
			sql.append(" WHERE pdsno=?");

			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getPasswd());
			pstmt.setInt(4, dto.getPdsno());
			res = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(" 실패 : " + e);
		} finally {
			dbclose.close(con, pstmt);
		} // try end
		return res;
	}// updateproc end

}// PdsDAO end
