package net.notice;

import java.sql.*;
import java.util.ArrayList;

import net.notice.NoticeDTO;
import net.utility.*;

public class NoticeDAO {


	private DBOpen dbopen = null;
	private DBClose dbclose = null;
	
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private StringBuilder sql = null;
	
	public NoticeDAO() {
	dbopen = new DBOpen();
	dbclose = new DBClose();
	}
	
		
	public int insert(NoticeDTO dto) {
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = null;
		int res = 0;
		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" INSERT INTO tb_notice (noticeno, subject, content) ");
		    sql.append(" VALUES((SELECT nvl(max(noticeno),0)+1 FROM tb_notice),?,?)");
		   
		    pstmt = con.prepareStatement(sql.toString());
		    pstmt.setString(1, dto.getSubject());
		    pstmt.setString(2, dto.getContent());
		    
		    res = pstmt.executeUpdate();
		    
		}catch (Exception e) {
			System.out.println("추가실패 : " + e);
		}finally {
			dbclose.close(con, pstmt);
		}//try end
			return res;
	}//insert end
	
	 public synchronized ArrayList<NoticeDTO> list() { //Ins
		    Connection con=null;
		    PreparedStatement pstmt=null;    
		    ResultSet rs=null;
		    StringBuffer sql=null;
		    ArrayList<NoticeDTO> list=null;
		    try {
		      con=dbopen.getConnection();
		      sql=new StringBuffer();
		      sql.append(" SELECT noticeno, subject, content, regdt, readcnt");
		      sql.append(" FROM tb_notice");
		      sql.append(" ORDER BY noticeno DESC");
		      pstmt=con.prepareStatement(sql.toString());
		      rs=pstmt.executeQuery();
		      if(rs.next()){ //자료가 존재하느냐? cursor가 존재하느냐?
		        list=new ArrayList<NoticeDTO>();
		        do{
		          NoticeDTO dto=new NoticeDTO();
		          dto.setNoticeno(rs.getInt("noticeno"));
		          dto.setSubject(rs.getString("subject"));
		          dto.setContent(rs.getString("content"));
		          dto.setReadcnt(rs.getInt("readcnt"));
		          dto.setRegdt(rs.getString("regdt"));

		          list.add(dto);
		        }while(rs.next());
		      }
		      
		    }catch(Exception e){
		      System.out.println(e);
		    }finally{
		      dbclose.close(con, pstmt, rs);
		    }
		    
		    return list;
		  }
	
	 public NoticeDTO read(int noticeno){
		    Connection con=null;
		    PreparedStatement pstmt=null;    
		    ResultSet rs=null;
		    StringBuffer sql=null;
		    NoticeDTO dto=null;
		    
		    try {
		      increment(noticeno); //조회수 증가
		      con=dbopen.getConnection();
		      sql=new StringBuffer();
		      sql.append(" SELECT noticeno, subject, content, regdt, readcnt");
		      sql.append(" FROM tb_notice ");
		      sql.append(" WHERE noticeno=? ");
		      pstmt=con.prepareStatement(sql.toString());
		      pstmt.setInt(1, noticeno);
		      rs=pstmt.executeQuery();
		      if(rs.next()){
		        dto=new NoticeDTO();
		        dto.setSubject(rs.getString("subject"));
		        dto.setContent(rs.getString("content"));
		        dto.setRegdt(rs.getString("regdt"));
		        dto.setReadcnt(rs.getInt("readcnt"));
		      }
		    }catch(Exception e){
		      System.out.println(e);
		    }finally{
		      dbclose.close(con, pstmt, rs);
		    }
		    return dto;
		  }

	 public void increment(int noticeno){
		    Connection con=null;
		    PreparedStatement pstmt=null;    
		    StringBuffer sql=null;
		    
		    try {
		      con=dbopen.getConnection();
		      sql=new StringBuffer();
		      sql.append(" UPDATE tb_notice");
		      sql.append(" SET readcnt=readcnt+1");
		      sql.append(" WHERE noticeno=?");
		      pstmt=con.prepareStatement(sql.toString());
		      pstmt.setInt(1, noticeno);
		      pstmt.executeUpdate();
		    }catch(Exception e){
		      System.out.println(e);
		    }finally{
		      dbclose.close(con, pstmt);
		    }      
		  }
	 

	 public int delete(NoticeDTO dto) {
			Connection con = null;
			PreparedStatement pstmt = null;
			StringBuilder sql = null;
			int res = 0;
			try {
				con = dbopen.getConnection();
				sql = new StringBuilder();
				sql.append(" DELETE FROM tb_notice ");
				sql.append(" WHERE noticeno = ? ");
				
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setInt(1, dto.getNoticeno());
				res = pstmt.executeUpdate();
				
			}catch (Exception e) {
				System.out.println("삭제 실패 : " + e);
			}finally {
				dbclose.close(con, pstmt);
			}//try end
			return res;
		}//delete end
	 
	 public NoticeDTO updateform(NoticeDTO dto) {
			
			try {
				con = dbopen.getConnection();
				sql = new StringBuilder();
				sql.append(" SELECT subject, content");
				sql.append(" FROM tb_notice ");
				sql.append(" WHERE noticeno = ? ");
				
				pstmt=con.prepareStatement(sql.toString());
				pstmt.setInt(1, dto.getNoticeno());
				
				rs=pstmt.executeQuery();
			    if(rs.next()){
			        dto=new NoticeDTO();
			        dto.setSubject(rs.getString("subject"));
			        dto.setContent(rs.getString("content"));
			      }else {
			    	  dto= null;
			      }
				
			}catch (Exception e) {
				System.out.println("글 수정 실패 : " + e);
			}finally {
				dbclose.close(con, pstmt, rs);
			}//try end
			return dto;
					
		}//updateform end
	
	 public int updateproc(NoticeDTO dto) {
			Connection con = null;
			PreparedStatement pstmt = null;
			StringBuilder sql = null;
			int res = 0;
			try {
				con = dbopen.getConnection();
				sql = new StringBuilder();
				sql.append(" UPDATE tb_notice ");
				sql.append(" SET subject=?, content=?");
				sql.append(" WHERE noticeno= ? ");
				
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, dto.getSubject());
				pstmt.setString(2, dto.getContent());
		        pstmt.setInt(3, dto.getNoticeno());
		        res = pstmt.executeUpdate();
			}catch (Exception e) {
				System.out.println(" 실패 : " + e);
			}finally {
				dbclose.close(con, pstmt);
			}//try end
			return res;
		}//updateproc end
		      
	 public int count(String col, String word) {
		 int cnt = 0;
		 try {
			 con=dbopen.getConnection();
			 sql=new StringBuilder();
			 sql.append(" SELECT COUNT(*) as cnt ");
			 sql.append(" FROM tb_notice ");
			 
			 if(word.length()>=1) {
				 String search = "";
				 if(col.equals("subject")) {
					search += " WHERE subject LIke '%" + word + "%'";
			 }else if(col.equals("content")) {
				 	search += " WHERE content LIke '%" + word + "%'";
	 		 }else if(col.equals("subject_content")) {
		 		 	search += " WHERE subject LIKE '%" + word + "%'"; 
		 		 	search += " OR content LIKE '%" + word + "%'";
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
	 

	  public ArrayList<NoticeDTO> list(String col, String word, int nowPage, int recordPerPage) {
		    ArrayList<NoticeDTO> list = null;

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
		        sql.append(" SELECT noticeno, subject, content, readcnt, regdt, r");
		        sql.append(" FROM(");
		        sql.append("      SELECT noticeno, subject, content, readcnt, regdt, rownum as r");
		        sql.append("      FROM (");
		        sql.append("           SELECT noticeno, subject, content, readcnt, regdt");
		        sql.append("           FROM tb_notice");
		        sql.append("           ORDER BY noticeno DESC");
		        sql.append("      )");
		        sql.append(" )     ");
		        sql.append(" WHERE r >= "+startRow+" AND r <= "+endRow);
		        
		        pstmt = con.prepareStatement(sql.toString());
		        
		      }else{ // 검색을 하는 경우
		        sql.append(" SELECT noticeno, subject, content, readcnt, regdt, r");
		        sql.append(" FROM(");
		        sql.append("      SELECT noticeno, subject, content, readcnt, regdt, rownum as r");
		        sql.append("      FROM (");
		        sql.append("           SELECT noticeno, subject, content, readcnt, regdt");
		        sql.append("           FROM tb_notice");
		               
		        //검색
		        if(word.length()>=1){
		          String search=" WHERE "+col+" LIKE '%"+word+"%'";
		          sql.append(search);
		        } 
		        
		        sql.append("           ORDER BY noticeno DESC");
		        sql.append("      )");
		        sql.append(" )     ");
		        sql.append(" WHERE r >= "+startRow+" AND r <= "+endRow);
		        
		        pstmt = con.prepareStatement(sql.toString());

		      }
		      
		      rs=pstmt.executeQuery();
		      if(rs.next()) {
		        list=new ArrayList<NoticeDTO>();
		        NoticeDTO dto=null; //레코드 1개보관
		        do {
		        	
		          dto=new NoticeDTO();
		          dto.setNoticeno(rs.getInt("noticeno"));
		          dto.setSubject(rs.getString("subject"));
		          dto.setContent(rs.getString("content"));
		          dto.setReadcnt(rs.getInt("readcnt"));
		          dto.setRegdt(rs.getString("regdt"));
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
		  	
}
