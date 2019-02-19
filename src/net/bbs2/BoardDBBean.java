package net.bbs2;

	import java.sql.Connection;
	import java.sql.PreparedStatement;
	import java.sql.ResultSet;
	import java.sql.SQLException;
	import java.util.ArrayList;
	import java.util.List;

import javax.naming.Context;
	import javax.naming.InitialContext;
	import javax.sql.DataSource;

import net.bbs.BbsDTO;
import net.utility.DBClose;
	import net.utility.DBOpen;
import oracle.net.aso.a;

	public class BoardDBBean {
	 private DBOpen  dbopen =null;
	 private DBClose dbclose=null;

	 private Connection con = null;
	 private PreparedStatement pstmt = null;
	 private ResultSet rs = null;
	 private StringBuilder sql = null;

	  public BoardDBBean() {
	    dbopen =new DBOpen(); //데이터베이스 연결 객체 할당
	    dbclose=new DBClose();
	  }
	  
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 글쓰기 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//

	  public void insertArticle(BoardDataBean article) throws Exception {
		  
		  int num = article.getNum();
		  int ref = article.getRef();
		  int re_step = article.getRe_step();
		  int re_level = article.getRe_level();
		  int number = 0;
		  
		  try { 
			  con = dbopen.getConnection();  //DBOpen
			  sql = new StringBuilder();	
			  pstmt = con.prepareStatement("SELECT max(num) FROM board");
			  rs = pstmt.executeQuery();
			  
			  if(rs.next()) {
				  number = rs.getInt(1)+1;
			  }else {
				  number=1;
			  }//if end
			  
			  //답변쓰기에서 글순서 재조정
			  if(num!=0) {
				  
				  sql.delete(0, sql.length());
				  sql.append("UPDATE board SET re_step=re_step+1 WHERE ref=? AND re_step>?");
				  pstmt = con.prepareStatement(sql.toString());
				  pstmt.setInt(1, ref);
				  pstmt.setInt(2, re_step);
				  pstmt.executeUpdate();
				  
				  re_step=re_step+1;
				  re_level=re_level+1;
			  } else { 
				  ref=number;
				  re_step=0;
				  re_level=0;
				  
			  }//if end
			  
			  sql.delete(0, sql.length());
			  sql.append(" INSERT INTO board(num, writer, email, subject, passwd, reg_date, ref, re_step, re_level, content, ip) ");
			  sql.append(" VALUES ((select nvl(max(num),0)+1 from board ), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ");
			  
			  pstmt=con.prepareStatement(sql.toString());
			  pstmt.setString(1, article.getWriter());
			  pstmt.setString(2, article.getEmail());
			  pstmt.setString(3, article.getSubject());
			  pstmt.setString(4, article.getPasswd());
			  pstmt.setTimestamp(5, article.getReg_date());
			  pstmt.setInt(6, ref);
			  pstmt.setInt(7, re_step);
			  pstmt.setInt(8, re_level);
			  pstmt.setString(9, article.getContent());
			  pstmt.setString(10, article.getIp());
			  pstmt.executeUpdate();
				  
		  }catch (Exception e) {
			  e.printStackTrace();
		  }finally {
			  dbclose.close(con, pstmt, rs);
		  }

	  }//insertArticle end

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 글 갯수 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//

	  public int getArticleCount() throws Exception { 
		  int x =0;
		  try {
			  con = dbopen.getConnection();
			  pstmt=con.prepareStatement("SELECT count(*) FROM board");
			  rs=pstmt.executeQuery();
			  if(rs.next()) {
				  x=rs.getInt(1);
			  }
		  }catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try {rs.close();} catch (SQLException e) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException e) {}
			if(con!=null) try {con.close();} catch (SQLException e) {}
			
		}
		  return x;
		  
	  }//getArticleCount end
	  
	  
  //ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 글 목록 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//	  
	  
	  public List getArticles(int start, int end) throws Exception{
		  List articleList = null;
		  sql=new StringBuilder();
		  
		  sql.append(" SELECT AA.* ");
		  sql.append(" FROM ( ");
		  sql.append(" SELECT ROWNUM as RNUM, BB.* ");
		  sql.append(" FROM ( ");
		  sql.append(" SELECT num, writer, email, subject, passwd, reg_date, ref, re_step, re_level, content, ip, readcount ");
		  sql.append(" FROM board ORDER BY ref desc, re_step ASC ");
		  sql.append(" ) BB");
		  sql.append(" ) AA ");
		  sql.append(" WHERE AA.RNUM >=? AND AA.RNUM<=? ");
		  
		  try {
			  con=dbopen.getConnection();
			  pstmt=con.prepareStatement(sql.toString());
			  pstmt.setInt(1, start);
			  pstmt.setInt(2, end);
			  rs=pstmt.executeQuery();
			  
			  if(rs.next()) {
				  articleList=new ArrayList(end);
				  do {
					  BoardDataBean article = new BoardDataBean();
					  article.setNum(rs.getInt("num"));
					  article.setWriter(rs.getString("writer"));
					  article.setEmail(rs.getString("email"));
					  article.setSubject(rs.getString("subject"));
					  article.setPasswd(rs.getString("passwd"));
					  article.setReg_date(rs.getTimestamp("reg_date"));
					  article.setReadcount(rs.getInt("readcount"));
					  article.setRef(rs.getInt("ref"));
					  article.setRe_step(rs.getInt("re_step"));
					  article.setRe_level(rs.getInt("re_level"));
					  article.setContent(rs.getString("content"));
					  article.setIp(rs.getString("ip"));
					  
					  articleList.add(article);
					  
				  }while(rs.next());
			 }
		  }catch(Exception e) {
			  e.printStackTrace();
		  }finally {
			dbclose.close(con, pstmt, rs);
		}
		  return articleList;
		  
	  }//getArticles end
	  
	  
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 상세보기 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//	  
	  
	  public BoardDataBean getArticle(int num) throws Exception{
		  BoardDataBean article = null;
		  
		  try {
			  con = dbopen.getConnection();
			  StringBuilder sql = new StringBuilder();
			  sql.append(" UPDATE board SET readcount=readcount+1 WHERE num=? ");
			  pstmt=con.prepareStatement(sql.toString());
			  pstmt.setInt(1, num);
			  pstmt.executeUpdate();
			  
			  sql.delete(0, sql.length());
			  sql.append(" SELECT num, writer, email, subject, passwd, reg_date, ref, re_step, re_level, content, ip, readcount ");
			  sql.append(" FROM board WHERE num=? ");
			  pstmt = con.prepareStatement(sql.toString());
			  pstmt.setInt(1, num);
			  rs = pstmt.executeQuery();
			  if(rs.next()) {
				  article = new BoardDataBean();
				  article.setNum(rs.getInt("num"));
				  article.setWriter(rs.getString("writer"));
				  article.setEmail(rs.getString("email"));
				  article.setSubject(rs.getString("subject"));
				  article.setPasswd(rs.getString("passwd"));
				  article.setReg_date(rs.getTimestamp("reg_date"));
				  article.setReadcount(rs.getInt("readcount"));
				  article.setRef(rs.getInt("ref"));
				  article.setRe_step(rs.getInt("re_step"));
				  article.setRe_level(rs.getInt("re_level"));
				  article.setContent(rs.getString("content"));
				  article.setIp(rs.getString("ip"));
			  }//if end
			  
		  }catch (Exception e) {
			  e.printStackTrace();
		}finally {
			dbclose.close(con, pstmt, rs);
		}
		  
		  return article;
		  
	  }//getArticle end

	  
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 수 정 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//	  
	  
	  
	  public BoardDataBean updateform(BoardDataBean article) {
			try {
				con = dbopen.getConnection();
				sql = new StringBuilder();
				sql.append(" SELECT writer, email, subject, content, passwd"); 
				sql.append(" FROM BOARD");
				sql.append(" WHERE num=? AND passwd=?");
				
				pstmt=con.prepareStatement(sql.toString());
				pstmt.setInt(1, article.getNum());
				pstmt.setString(2, article.getPasswd());
				rs=pstmt.executeQuery();
			    if(rs.next()){
			    	//System.out.println("rs있음");
			        article = new BoardDataBean();
			        article.setWriter(rs.getString("writer"));
			        article.setEmail(rs.getString("email"));
			        article.setSubject(rs.getString("subject"));
			        article.setContent(rs.getString("content"));
			        article.setPasswd(rs.getString("passwd"));        
			      }else {
			    	  article=null;
			    	  //System.out.println("없음");	
			      }
			}catch (Exception e) {
				System.out.println("글 수정 실패 : " + e);
			}finally {
				dbclose.close(con, pstmt, rs);
			}//try end
			return article;
					
		}//updateform end
	
	 public int updateproc(BoardDataBean article) {
			int res = 0;
			try {
				con = dbopen.getConnection();
				sql = new StringBuilder();
				sql.append(" UPDATE BOARD ");
				sql.append(" SET writer=?, email=?, subject=?, content=?, passwd=? ");
				sql.append(" WHERE num= ? ");
				
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString(1, article.getWriter());
				pstmt.setString(2, article.getEmail());
				pstmt.setString(3, article.getSubject());
		        pstmt.setString(4, article.getContent());
		        pstmt.setString(5, article.getPasswd());
		        pstmt.setInt(6, article.getNum());
		        res = pstmt.executeUpdate();
			}catch (Exception e) {
				System.out.println(" 실패 : " + e);
			}finally {
				dbclose.close(con, pstmt);
			}//try end
			return res;
		}//updateproc end
	  
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 삭 제 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	 
	  public int delete(BoardDataBean article) throws Exception { // 
		  int res = 0;
		  	try {
				con = dbopen.getConnection();
				sql = new StringBuilder();
				sql.append(" DELETE FROM board ");
				sql.append(" WHERE passwd = ? and num = ? ");
				
				pstmt = con.prepareStatement(sql.toString());
				pstmt.setString (1, article.getPasswd());
				pstmt.setInt(2, article.getNum());
				res = pstmt.executeUpdate();
				
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				dbclose.close(con, pstmt);
			}//try end
			
		  	return res;
		}//delete end  	  
	  
	}//class end