package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

   
      private Connection conn;
      private PreparedStatement pstmt;
      private ResultSet rs;
      
      
      
      public BbsDAO() {  //실제로 데이터베이스에 접근하게 하는 부분 -생성자
         try {
            String dbURL = "jdbc:mysql://localhost:3307/BBS?useSSL=false&serverTimezone=Asia/Seoul"; //mysql을 이용한다 호스트넘버 3307에 있는 BBS데이터베이스에 접근하겠다  
            String dbID="root";
            String dbPassword= "root";
            Class.forName("com.mysql.jdbc.Driver");
            conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
         } catch(Exception e) {
            e.printStackTrace();
         }
      }
      
      
      
      
      
      public String getDate() { //시간을 가져오는 함수
         String SQL = "SELECT NOW()";
         try {
            PreparedStatement pstmt= conn.prepareStatement(SQL); //연결객체를 통해 SQL문장을 실행준비단계로 만들고
            rs= pstmt.executeQuery();//실행결과를 가져옴
            if(rs.next()) {
               return rs.getString(1);//현재의 시간을 그대로 반환하게함
            }
         }catch(Exception e) {
            e.printStackTrace();
         }
         return "";//데이터베이스 오류
      }
      
       
      public int getNext() { //게시글의 번호는 그 전의 숫자에서 +1을 해주는 개념이으로 데이터베이스에서 값을 가져와서 +1
         String SQL = "SELECT bbsID FROM BBS  ORDER BY bbsID DESC";
    	  //String SQL =" SELECT COUNT(bbsID) FROM BBS WHERE bbsID >0 AND bbsAvailable =1";
         try {
            PreparedStatement pstmt= conn.prepareStatement(SQL); //연결객체를 통해 SQL문장을 실행준비단계로 만들고
            rs= pstmt.executeQuery();//실행결과를 가져옴
            if(rs.next()){
               return rs.getInt(1) + 1;//현재의 시간을 그대로 반환하게함
            }
            return 1; // 첫번째 게시물인 경우
         } catch(Exception e) {
            e.printStackTrace();
         }
         return -1;//데이터베이스 오류
      }
      
      
      public int write(String bbsTitle, String userID, String bbsContent) { //글을 작성하고 데이터베이스에 내용을 보내주는 함수
         String SQL = "INSERT INTO BBS VALUES(?,?,?,?,?,?)"; 
         try {
            PreparedStatement pstmt= conn.prepareStatement(SQL); //연결객체를 통해 SQL문장을 실행준비단계로 만들고
            pstmt.setInt(1, getNext());
            pstmt.setString(2, bbsTitle);
            pstmt.setString(3, userID);
            pstmt.setString(4, getDate());
            pstmt.setString(5, bbsContent);
            pstmt.setInt(6, 1);
            // rs= pstmt.executeQuery(); 값을 집어넣는 것이므로 실행결과를 가져올 필요가 없음 
            return pstmt.executeUpdate();//INSERT의 경우는 성공적일떄는 0이상의 수를 반환
         }catch(Exception e) {
            e.printStackTrace();
         }
         return -1;//데이터베이스 오류 (INSERT는 실패하는 경우 0보다 작은수)
      }
      
      
      public ArrayList<Bbs> getList(int pageNumber){ //글의 목록을 보여주는 함수
         String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable =1 ORDER BY bbsID DESC LIMIT 10";
         ArrayList<Bbs> list = new ArrayList<Bbs>();
         try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
            rs = pstmt.executeQuery();
            while (rs.next()) {
               Bbs bbs= new Bbs();
               bbs.setBbsID(rs.getInt(1));//데이터베이스에서 뽑아오는게 rs.getString(), rs.getInt() 이며 이값을 넣어주는게 setBbsInt()등등
               bbs.setBbsTitle(rs.getString(2));
               bbs.setUserID(rs.getString(3));
               bbs.setBbsDate(rs.getString(4));
               bbs.setBbsContent(rs.getString(5));
               bbs.setBbsAvailable(rs.getInt(6));
               list.add(bbs); //배열에 완성된 객체를 추가한다
            }
         } catch(Exception e) {
            e.printStackTrace();
         }
         return list;
      }
      
      
      public boolean nextPage(int pageNumber) { //목록 전체를 한번에 보여주지 않고 몇개단위로 끊어서 보여주는 함수
    	  String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ";
          try {  
             PreparedStatement pstmt = conn.prepareStatement(SQL);
             pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
             rs = pstmt.executeQuery();
             if (rs.next()) {
                return true;
             }
          } catch(Exception e) {
             e.printStackTrace();
          }
          return false;
      }
      
      
      
      public Bbs getBbs(int bbsID) {   //글 내용을 불러오는 함수
    	  String SQL = "SELECT * FROM BBS WHERE bbsID= ?";
    	  try {
    		  PreparedStatement pstmt = conn.prepareStatement(SQL);
  			  pstmt.setInt(1, bbsID);
    		  rs = pstmt.executeQuery();
    		  if(rs.next()) {
    			  Bbs bbs= new Bbs();
                  bbs.setBbsID(rs.getInt(1));//데이터베이스에서 뽑아오는게 rs.getString(), rs.getInt() 이며 이값을 넣어주는게 setBbsInt()등등
                  bbs.setBbsTitle(rs.getString(2));
                  bbs.setUserID(rs.getString(3));
                  bbs.setBbsDate(rs.getString(4));
                  bbs.setBbsContent(rs.getString(5));
                  bbs.setBbsAvailable(rs.getInt(6));
    			  return bbs;
    		  }
    	  } catch(Exception e) {
    		  e.printStackTrace();
    	  }
    	  return null;
      }
      
      
      
      public int update(int bbsID, String bbsTitle, String bbsContent) { //데이터를 뽑아오는것이 아니라 sql문을 이용하여 내용을 추가하는 것이므로 앞서 구현한 write함수와 비슷
    	  String SQL = "UPDATE BBS SET bbsTitle=?, bbsContent=? WHERE bbsID = ?";
    	  try {
    		  PreparedStatement pstmt = conn.prepareStatement(SQL);
    		  pstmt.setString(1, bbsTitle); //매개변수로 들어온 값들을 넣어준다
    		  pstmt.setString(2, bbsContent);
    		  pstmt.setInt(3, bbsID);
    		  return pstmt.executeUpdate(); //성공적으로 실행하면 0이상의 값을 반환
    	  } catch(Exception e){
    		  e.printStackTrace();
    	  }
    	  return -1;//데이터베이스 오류
      }
      
      
      public int delete(int bbsID) {
    	  String SQL = "UPDATE BBS SET bbsAvailable =0 WHERE bbsID = ?";
    	  try {
    		  PreparedStatement pstmt = conn.prepareStatement(SQL);
    		  pstmt.setInt(1, bbsID); //매개변수로 들어온 값들을 넣어준다
    		  return pstmt.executeUpdate(); //성공적으로 실행하면 0이상의 값을 반환
    	  } catch(Exception e){
    		  e.printStackTrace();
    	  }
    	  return -1;//데이터베이스 오류
      }
      
      
}