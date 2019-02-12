package net.bbs;

import java.sql.*;
import java.util.ArrayList;

import net.utility.*;

public class BbsDAO {

	private DBOpen dbopen = null;
	private DBClose dbclose = null;
	
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private StringBuilder sql = null;
	
	public BbsDAO() {
	dbopen = new DBOpen();
	dbclose = new DBClose();
	}
	
	public int insert(BbsDTO dto) { //bbsIns 
		Connection con = null;
		PreparedStatement pstmt = null;
		StringBuilder sql = null;
		int res = 0;
		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" INSERT INTO tb_bbs(bbsno, wname, subject, content, passwd, grpno, ip) ");
		    sql.append(" VALUES( (SELECT NVL(max(bbsno),0)+1 FROM tb_bbs), ?, ?, ?, ?, (SELECT NVL(max(bbsno),0)+1 FROM tb_bbs), ?)");
		   
		    pstmt = con.prepareStatement(sql.toString());
		    pstmt.setString(1, dto.getWname());
		    pstmt.setString(2, dto.getSubject());
		    pstmt.setString(3, dto.getContent());
		    pstmt.setString(4, dto.getPasswd());
		    pstmt.setString(5, dto.getIp());
		    
		    res = pstmt.executeUpdate();
		    
		}catch (Exception e) {
			System.out.println("추가실패 : " + e);
		}finally {
			dbclose.close(con, pstmt);
		}//try end
			return res;
	}//insert end
	
	 public synchronized ArrayList<BbsDTO> list() {
		    Connection con=null;
		    PreparedStatement pstmt=null;    
		    ResultSet rs=null;
		    StringBuffer sql=null;
		    ArrayList<BbsDTO> list=null;
		    try {
		      con=dbopen.getConnection();
		      sql=new StringBuffer();
		      sql.append(" SELECT bbsno, wname, subject, regdt, readcnt, indent, ip");
		      sql.append(" FROM tb_bbs");
		      sql.append(" ORDER BY grpno DESC,ansnum ASC");
		      pstmt=con.prepareStatement(sql.toString());
		      rs=pstmt.executeQuery();
		      if(rs.next()){ //자료가 존재하느냐? cursor가 존재하느냐?
		        list=new ArrayList<BbsDTO>();
		        do{
		          BbsDTO dto=new BbsDTO();
		          dto.setBbsno(rs.getInt("bbsno"));
		          dto.setWname(rs.getString("wname"));
		          dto.setSubject(rs.getString("subject"));
		          dto.setRegdt(rs.getString("regdt"));
		          dto.setReadcnt(rs.getInt("readcnt"));
		          dto.setIndent(rs.getInt("Indent"));
			      dto.setIp(rs.getString("ip"));        

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
	
	 public BbsDTO read(int bbsno){
		    Connection con=null;
		    PreparedStatement pstmt=null;    
		    ResultSet rs=null;
		    StringBuffer sql=null;
		    BbsDTO dto=null;
		    
		    try {
		      increment(bbsno); //조회수 증가
		      con=dbopen.getConnection();
		      sql=new StringBuffer();
		      sql.append(" SELECT bbsno, subject, content, wname, regdt, readcnt, ip ");
		      sql.append(" FROM tb_bbs ");
		      sql.append(" WHERE bbsno=? ");
		      pstmt=con.prepareStatement(sql.toString());
		      pstmt.setInt(1, bbsno);
		      rs=pstmt.executeQuery();
		      if(rs.next()){
		        dto=new BbsDTO();
		        dto.setSubject(rs.getString("subject"));
		        dto.setContent(rs.getString("content"));
		        dto.setWname(rs.getString("wname"));
		        dto.setRegdt(rs.getString("regdt"));
		        dto.setReadcnt(rs.getInt("readcnt"));
		        dto.setIp(rs.getString("ip"));        
		      }
		    }catch(Exception e){
		      System.out.println(e);
		    }finally{
		      dbclose.close(con, pstmt, rs);
		    }
		    return dto;
		  }

	 public void increment(int bbsno){
		    Connection con=null;
		    PreparedStatement pstmt=null;    
		    StringBuffer sql=null;
		    
		    try {
		      con=dbopen.getConnection();
		      sql=new StringBuffer();
		      sql.append(" UPDATE tb_bbs");
		      sql.append(" SET readcnt=readcnt+1");
		      sql.append(" WHERE bbsno=?");
		      pstmt=con.prepareStatement(sql.toString());
		      pstmt.setInt(1, bbsno);
		      pstmt.executeUpdate();
		    }catch(Exception e){
		      System.out.println(e);
		    }finally{
		      dbclose.close(con, pstmt);
		    }      
		  }
	 
	 public int reply(BbsDTO dto) {
		 int res = 0;
		 try {
			 con = dbopen.getConnection();
			 sql = new StringBuilder();
			 
			 // 1) 부모글정보 가져오기(그룹번호,들여쓰기,글순서)
			 int grpno = 0, indent = 0, ansnum = 0;
			 sql.append("SELECT grpno, indent, ansnum ");
			 sql.append("FROM tb_bbs ");
			 sql.append("WHERE bbsno = ? ");
			 pstmt = con.prepareStatement(sql.toString());
			 pstmt.setInt(1, dto.getBbsno());
			 rs = pstmt.executeQuery();
			 if(rs.next()) {
				 grpno = rs.getInt("grpno");
				 indent = rs.getInt("indent")+1;
				 ansnum = rs.getInt("ansnum")+1;
			 }//if end

			 //2)글순서 재조정
			 //1)에서 사용했던 sql문 삭제
			 sql.delete(0, sql.length());
			 sql.append(" UPDATE tb_bbs ");
			 sql.append(" SET ansnum = ansnum+1 ");
			 sql.append(" WHERE grpno = ? AND ansnum >= ? ");
			 pstmt = con.prepareStatement(sql.toString());
			 pstmt.setInt(1, grpno);
			 pstmt.setInt(2, ansnum);
			 pstmt.executeUpdate();
			 
			 //3) 답변글 추가
			 sql.delete(0, sql.length());
			 sql.append("INSERT INTO tb_bbs(bbsno, wname, subject, content, passwd, ip, grpno, indent, ansnum) ");
			 sql.append(" VALUES((SELECT NVL(MAX(bbsno),0)+1 FROM tb_bbs) ");
			 sql.append(" , ?, ?, ?, ?, ?, ?, ?, ?)");
			 pstmt = con.prepareStatement(sql.toString());
			 pstmt.setString(1, dto.getWname());
			 pstmt.setString(2, dto.getSubject());
			 pstmt.setString(3, dto.getContent());
			 pstmt.setString(4, dto.getPasswd());
			 pstmt.setString(5, dto.getIp());
			 pstmt.setInt(6, grpno);
			 pstmt.setInt(7, indent);
			 pstmt.setInt(8, ansnum);
			 res = pstmt.executeUpdate();
		 }catch(Exception e){
			      System.out.println("답변실패 : " +e);
			    }finally{
			      dbclose.close(con, pstmt, rs);
			    }
		 return res;
		 }

/*
	 public int replycnt(BbsDTO dto) {
		 int res = 0;
		 try {
			 con = dbopen.getConnection();
			 sql = new StringBuilder();
			 
			 // 1) 부모글정보 가져오기(그룹번호,들여쓰기,글순서)
			 int grpno = 0, indent = 0, ansnum = 0;
			 sql.append("SELECT grpno, indent, ansnum ");
			 sql.append("FROM tb_bbs ");
			 sql.append("WHERE bbsno = ? ");
			 pstmt = con.prepareStatement(sql.toString());
			 pstmt.setInt(1, dto.getBbsno());
			 rs = pstmt.executeQuery();
			 
			 if(rs.next()) {
				 grpno = rs.getInt("grpno");
				 indent = rs.getInt("indent");
				 ansnum = rs.getInt("ansnum");
			 }
			 sql.delete(0, sql.length());
			 sql.append("SELECT count(*) as cnt ");
			 sql.append("FROM tb_bbs ");
			 sql.append("WHERE grpno = ? and indent > ? ");
			 
			 pstmt = con.prepareStatement(sql.toString());
			 pstmt.setInt(1, dto.getGrpno());
			 pstmt.setInt(2, dto.getIndent());
			 
		 }catch(Exception e){
		      System.out.println("답글 개수확인 실패 : " +e);
		    }finally{
		      dbclose.close(con, pstmt, rs);
		    }
	 return res;
	 }
*/ 
	 public int delete(BbsDTO dto) { // 게시글 삭제(회원)
			Connection con = null;
			PreparedStatement pstmt = null;
			StringBuilder sql = null;
			int res = 0;
			try {
				con = dbopen.getConnection();
				sql = new StringBuilder();
				sql.append(" DELETE FROM tb_bbs ");
				sql.append(" WHERE passwd = ? and bbsno = ? ");
				
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, dto.getPasswd());
				pstmt.setInt(2, dto.getBbsno());
				res = pstmt.executeUpdate();
				
			}catch (Exception e) {
				System.out.println("삭제 실패 : " + e);
			}finally {
				dbclose.close(con, pstmt);
			}//try end
			return res;
		}//delete end

	 public int delete(int bbsno) { // 게시글 삭제 (관리자)
			Connection con = null;
			PreparedStatement pstmt = null;
			StringBuilder sql = null;
			int res = 0;
			try {
				con = dbopen.getConnection();
				sql = new StringBuilder();
				sql.append(" DELETE FROM tb_bbs ");
				sql.append(" WHERE bbsno = ? ");
				
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setInt(1, bbsno);
				res = pstmt.executeUpdate();
				
			}catch (Exception e) {
				System.out.println("삭제 실패 : " + e);
			}finally {
				dbclose.close(con, pstmt);
			}//try end
			return res;
		}//delete end
	 public BbsDTO updateform(BbsDTO dto) {

			
			try {
				con = dbopen.getConnection();
				sql = new StringBuilder();
				sql.append(" SELECT wname, subject, content, passwd, ip");
				sql.append(" FROM tb_bbs ");
				sql.append(" WHERE passwd = ? and bbsno = ? ");
				
				pstmt=con.prepareStatement(sql.toString());
				pstmt.setString(1, dto.getPasswd());
				pstmt.setInt(2, dto.getBbsno());
				
				rs=pstmt.executeQuery();
			    if(rs.next()){
			        dto=new BbsDTO();
			        dto.setWname(rs.getString("wname"));
			        dto.setSubject(rs.getString("subject"));
			        dto.setContent(rs.getString("content"));
			        dto.setPasswd(rs.getString("passwd"));
			        dto.setIp(rs.getString("ip"));        
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
	
	 public int updateproc(BbsDTO dto) {
			Connection con = null;
			PreparedStatement pstmt = null;
			StringBuilder sql = null;
			int res = 0;
			try {
				con = dbopen.getConnection();
				sql = new StringBuilder();
				sql.append(" UPDATE tb_bbs ");
				sql.append(" SET wname=?, subject=?, content=?, passwd=?, ip=? ");
				sql.append(" WHERE bbsno= ? ");
				
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, dto.getWname());
				pstmt.setString(2, dto.getSubject());
				pstmt.setString(3, dto.getContent());
				pstmt.setString(4, dto.getPasswd());
		        pstmt.setString(5, dto.getIp());
		        pstmt.setInt(6, dto.getBbsno());
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
			 sql.append(" FROM tb_bbs ");
			 
			 if(word.length()>=1) {
				 String search = "";
				 if(col.equals("wname")) {
					search += " WHERE wname LIke '%" + word + "%'";
			 }else if(col.equals("subject")) {
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
	 
	 public synchronized ArrayList<BbsDTO> list(String col, String word) {
		    StringBuffer sql=null;
		    ArrayList<BbsDTO> list=null;
		    try {
		      con=dbopen.getConnection();
		      sql=new StringBuffer();
		      sql.append(" SELECT bbsno, wname, subject, regdt, readcnt, indent, ip");
		      sql.append(" FROM tb_bbs");
		      if(word.length()>=1) {
					 String search = "";
					 if(col.equals("wname")) {
						search += " WHERE wname LIke '%" + word + "%'";
				 }else if(col.equals("subject")) {
					 	search += " WHERE subject LIke '%" + word + "%'";
			 	 }else if(col.equals("content")) {
			 		 	search += " WHERE content LIke '%" + word + "%'";
		 		 }else if(col.equals("subject_content")) {
			 		 	search += " WHERE subject LIKE '%" + word + "%'"; 
			 		 	search += " OR content LIKE '%" + word + "%'";
		 		 }
				 sql.append(search);
				 }
		      sql.append(" ORDER BY grpno DESC,ansnum ASC");
		      pstmt=con.prepareStatement(sql.toString());
		      rs=pstmt.executeQuery();
		      if(rs.next()){ //자료가 존재하느냐? cursor가 존재하느냐?
		        list=new ArrayList<BbsDTO>();
		        do{
		          BbsDTO dto=new BbsDTO();
		          dto.setBbsno(rs.getInt("bbsno"));
		          dto.setWname(rs.getString("wname"));
		          dto.setSubject(rs.getString("subject"));
		          dto.setRegdt(rs.getString("regdt"));
		          dto.setReadcnt(rs.getInt("readcnt"));
		          dto.setIndent(rs.getInt("Indent"));
			      dto.setIp(rs.getString("ip"));        

		          list.add(dto);
		        }while(rs.next());
		      }
		      
		    }catch(Exception e){
		      System.out.println("검색 목록 실패 : " + e);
		    }finally{
		      dbclose.close(con, pstmt, rs);
		    }
		    
		    return list;
		  }
	 
	  public ArrayList<BbsDTO> list(String col, String word, int nowPage, int recordPerPage) {
		    Connection con = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    ArrayList<BbsDTO> list = null;

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
		        sql.append(" SELECT bbsno, wname, subject, readcnt, regdt, grpno, indent, ansnum, r");
		        sql.append(" FROM(");
		        sql.append("      SELECT bbsno, wname, subject, readcnt, regdt, grpno, indent, ansnum, rownum as r");
		        sql.append("      FROM (");
		        sql.append("           SELECT bbsno, wname, subject, readcnt, regdt, grpno, indent, ansnum");
		        sql.append("           FROM tb_bbs ");
		        sql.append("           ORDER BY grpno DESC, ansnum ASC");
		        sql.append("      )");
		        sql.append(" )     ");
		        sql.append(" WHERE r >= "+startRow+" AND r <= "+endRow);
		        
		        pstmt = con.prepareStatement(sql.toString());
		        
		      }
		      else{ // 검색을 하는 경우
		        sql.append(" SELECT bbsno, wname, subject, readcnt, regdt, grpno, indent, ansnum, r");
		        sql.append(" FROM(");
		        sql.append("      SELECT bbsno, wname, subject, readcnt, regdt, grpno, indent, ansnum, rownum as r");
		        sql.append("      FROM (");
		        sql.append("           SELECT bbsno, wname, subject, readcnt, regdt, grpno, indent, ansnum");
		        sql.append("           FROM tb_bbs ");
		               
		        //검색
		        if(word.length()>=1){
		          String search=" WHERE "+col+" LIKE '%"+word+"%'";
		          sql.append(search);
		        } 
		        
		        sql.append("           ORDER BY grpno DESC, ansnum ASC");
		        sql.append("      )");
		        sql.append(" )     ");
		        sql.append(" WHERE r >= "+startRow+" AND r <= "+endRow+" AND indent=0");
		        
		        pstmt = con.prepareStatement(sql.toString());

		      }
		      
		      rs=pstmt.executeQuery();
		      if(rs.next()) {
		        list=new ArrayList<BbsDTO>();
		        BbsDTO dto=null; //레코드 1개보관
		        do {
		        	
		          dto=new BbsDTO();
		          dto.setBbsno(rs.getInt("bbsno"));
		          dto.setSubject(rs.getString("subject"));
		          dto.setReadcnt(rs.getInt("readcnt"));
		          dto.setWname(rs.getString("wname"));
		          dto.setRegdt(rs.getString("regdt"));
		          dto.setGrpno(rs.getInt("grpno"));
		          dto.setIndent(rs.getInt("indent"));
		          dto.setAnsnum(rs.getInt("ansnum"));
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
	
	  public ArrayList<BbsDTO> comment(String col, String word, int nowPage, int recordPerPage) {
		    ArrayList<BbsDTO> list = null;

		    // 10: 페이지당 출력할 레코드 갯수
		    int startRow = ((nowPage-1) * recordPerPage) + 1; // (0 * 10) + 1 = 1, 11, 21
		    int endRow = nowPage * recordPerPage;             // 1 * 10 = 10, 20, 30
		    
		    try {
		      con = dbopen.getConnection();
		      StringBuffer sql = new StringBuffer();
		      
		      word = word.trim(); // 문자열 좌우 공백 제거
		      
		      if (word.length() == 0){ // 검색을 안하는 경우
		    	  sql.append(" SELECT bbsno, subject, wname, readcnt, regdt, grpno, cnt, rnum ");
		    	  sql.append(" FROM ( ");
		    	  sql.append(" 	  SELECT bbsno, subject, wname, readcnt, regdt, grpno, cnt, rownum AS rnum ");
		    	  sql.append(" 	  FROM ( ");
		    	  sql.append(" 	  		SELECT BB.bbsno, BB.subject, BB.wname, BB.readcnt, BB.regdt, AA.grpno, AA.cnt  ");
		    	  sql.append(" 	  		FROM ( ");
		    	  sql.append("  	  			  SELECT grpno, count(grpno)-1 AS cnt ");
		    	  sql.append(" 	  			  FROM tb_bbs ");
		    	  sql.append(" 	  		 	  GROUP BY grpno ");
		    	  sql.append(" 	  			  ) AA JOIN tb_bbs BB ");
		    	  sql.append(" 	  		ON AA.grpno = BB.grpno ");
		    	  sql.append(" 	  		WHERE BB.indent = 0 ");
		    	  sql.append("	  		ORDER BY grpno DESC ");
		    	  sql.append("	  	) ");
		    	  sql.append("	  ) ");
		    	  
		    	  
		    	  
		        sql.append(" WHERE rnum >= "+startRow+" AND rnum <= "+endRow+"AND cnt!=0");
		        
		        
		      }
		      else{ // 검색을 하는 경우
		    	  sql.append(" SELECT bbsno, subject, wname, readcnt, regdt, grpno, cnt, r ");
		          sql.append(" from ( ");
		          sql.append("       select bbsno, subject, wname, readcnt, regdt, grpno, cnt, rownum as r ");
		          sql.append("       from( ");
		          sql.append("            select BB.bbsno, BB.subject, BB.wname, BB.readcnt, BB.regdt, AA.grpno, AA.cnt ");
		          sql.append("            from ( ");
		          sql.append("                  select grpno, count(grpno)-1 as cnt ");
		          sql.append("                  from tb_bbs ");
		          sql.append("                  group by grpno ");
		          sql.append("                 ) AA join tb_bbs BB ");
		          sql.append("           on AA.grpno = BB.grpno ");
		          
		        //검색
		          String search="";
		          if(col.equals("wname")) {
		            search += " WHERE BB.indent = 0 AND wname LIKE '%" + word + "%'";
		          } else if(col.equals("subject")) {
		            search += " WHERE BB.indent = 0 AND subject LIKE '%" + word + "%'";
		          } else if(col.equals("content")) {
		            search += " WHERE BB.indent = 0 AND content LIKE '%" + word + "%'";
		          } else if(col.equals("subject_content")) {
		            search += " WHERE BB.indent = 0 AND (subject LIKE '%" + word + "%'";
		            search += " OR content LIKE '%" + word + "%')";
		          }
		          
		          sql.append(search);        
		          
		          sql.append("           order by grpno DESC ");
		          sql.append("     ) ");
		          sql.append(" ) ");
		          sql.append(" WHERE r>=" + startRow + " AND r<=" + endRow) ;
		        }//if end
		      pstmt=con.prepareStatement(sql.toString());
		      rs=pstmt.executeQuery();
		      if(rs.next()) {
		        list=new ArrayList<BbsDTO>();
		        BbsDTO dto=null; //레코드 1개보관
		        do {
		          dto=new BbsDTO();
		          dto.setBbsno(rs.getInt("bbsno"));
		          dto.setSubject(rs.getString("subject"));
		          dto.setWname(rs.getString("wname"));
		          dto.setReadcnt(rs.getInt("readcnt"));
		          dto.setRegdt(rs.getString("regdt"));
		          dto.setGrpno(rs.getInt("grpno"));
		          dto.setComment(rs.getInt("cnt"));
		          list.add(dto);
		        }while(rs.next());
		      }

		    } catch (Exception e) {
		      System.out.println(e.toString());
		    } finally {
		      dbclose.close(con, pstmt, rs);
		    }
		    return list;
		  } // comment end
	  
}//class end