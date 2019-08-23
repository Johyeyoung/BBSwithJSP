package User;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
   
   private Connection conn;
   private PreparedStatement pstmt;
   private ResultSet rs;
   
   public UserDAO() {  //실제로 데이터베이스에 접근하게 하는 부분 -생성자
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
   
   
   public int login(String userID, String userPassword) { ///실제로 로그인을 담당하게 하는 부분
      String SQL="SELECT userPassword FROM USER WHERE userID=?";
      try {
         pstmt=conn.prepareStatement(SQL);
         pstmt.setString(1, userID);
         rs=pstmt.executeQuery();
         if(rs.next()) {
            if(rs.getString(1).equals(userPassword)) 
               return 1; //로그인 성공
            else
               return 0; // 비밀번호 불일치
            }
         return -1;    // 아이디 없음
      }catch(Exception e) {
         e.printStackTrace();
      }
      return -2;
   }
   
   
   public int join(User user) {
	   String SQL= "INSERT INTO USER VALUE (?, ?, ?, ?, ?)";
	   try {
		   pstmt = conn.prepareStatement(SQL);
		   pstmt.setString(1, user.getUserID());
		   pstmt.setString(2, user.getUserPassword());
		   pstmt.setString(3, user.getUserName());
		   pstmt.setString(4, user.getUserGender());
		   pstmt.setString(5, user.getUserEmail());
		   return pstmt.executeUpdate(); // 성공하면 0이상의 수가 나오므로 -1이면 무조건 실패인거임
	   }catch(Exception e) {
		   e.printStackTrace();
	   }
	   return -1;//데이터베이스 오류
   }
   
   
   
}