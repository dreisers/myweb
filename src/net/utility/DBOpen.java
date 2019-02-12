package net.utility;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBOpen { //�����ͺ��̽� ����
  
  public Connection getConnection() {
    //1) Oracle DB ����------------------------------
    String url      = "jdbc:oracle:thin:@localhost:1521:xe";
    String user     = "java1113";
    String password = "1234";
    String driver   = "oracle.jdbc.driver.OracleDriver";

    //2) MySQL DB ����-------------------------------
    /*
    String url      = "jdbc:mysql://localhost:3306/soldesk?useUnicode=true&characterEncoding=utf8";
    String user     = "root";
    String password = "1234";
    String driver   = "org.gjt.mm.mysql.Driver"; 
    */
    
    Connection con = null;
    
    try {

        Class.forName(driver);
        con = DriverManager.getConnection(url, user, password);

    }catch (Exception e) {
        System.out.println("DB���� ���� : " + e);
    }//try end   
    
    return con;
    
  }//end

}//class end
