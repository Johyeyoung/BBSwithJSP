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
      
      
      
      public BbsDAO() {  //������ �����ͺ��̽��� �����ϰ� �ϴ� �κ� -������
         try {
            String dbURL = "jdbc:mysql://localhost:3307/BBS?useSSL=false&serverTimezone=Asia/Seoul"; //mysql�� �̿��Ѵ� ȣ��Ʈ�ѹ� 3307�� �ִ� BBS�����ͺ��̽��� �����ϰڴ�  
            String dbID="root";
            String dbPassword= "root";
            Class.forName("com.mysql.jdbc.Driver");
            conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
         } catch(Exception e) {
            e.printStackTrace();
         }
      }
      
      
      
      
      
      public String getDate() { //�ð��� �������� �Լ�
         String SQL = "SELECT NOW()";
         try {
            PreparedStatement pstmt= conn.prepareStatement(SQL); //���ᰴü�� ���� SQL������ �����غ�ܰ�� �����
            rs= pstmt.executeQuery();//�������� ������
            if(rs.next()) {
               return rs.getString(1);//������ �ð��� �״�� ��ȯ�ϰ���
            }
         }catch(Exception e) {
            e.printStackTrace();
         }
         return "";//�����ͺ��̽� ����
      }
      
       
      public int getNext() { //�Խñ��� ��ȣ�� �� ���� ���ڿ��� +1�� ���ִ� ���������� �����ͺ��̽����� ���� �����ͼ� +1
         String SQL = "SELECT bbsID FROM BBS  ORDER BY bbsID DESC";
    	  //String SQL =" SELECT COUNT(bbsID) FROM BBS WHERE bbsID >0 AND bbsAvailable =1";
         try {
            PreparedStatement pstmt= conn.prepareStatement(SQL); //���ᰴü�� ���� SQL������ �����غ�ܰ�� �����
            rs= pstmt.executeQuery();//�������� ������
            if(rs.next()){
               return rs.getInt(1) + 1;//������ �ð��� �״�� ��ȯ�ϰ���
            }
            return 1; // ù��° �Խù��� ���
         } catch(Exception e) {
            e.printStackTrace();
         }
         return -1;//�����ͺ��̽� ����
      }
      
      
      public int write(String bbsTitle, String userID, String bbsContent) { //���� �ۼ��ϰ� �����ͺ��̽��� ������ �����ִ� �Լ�
         String SQL = "INSERT INTO BBS VALUES(?,?,?,?,?,?)"; 
         try {
            PreparedStatement pstmt= conn.prepareStatement(SQL); //���ᰴü�� ���� SQL������ �����غ�ܰ�� �����
            pstmt.setInt(1, getNext());
            pstmt.setString(2, bbsTitle);
            pstmt.setString(3, userID);
            pstmt.setString(4, getDate());
            pstmt.setString(5, bbsContent);
            pstmt.setInt(6, 1);
            // rs= pstmt.executeQuery(); ���� ����ִ� ���̹Ƿ� �������� ������ �ʿ䰡 ���� 
            return pstmt.executeUpdate();//INSERT�� ���� �������ϋ��� 0�̻��� ���� ��ȯ
         }catch(Exception e) {
            e.printStackTrace();
         }
         return -1;//�����ͺ��̽� ���� (INSERT�� �����ϴ� ��� 0���� ������)
      }
      
      
      public ArrayList<Bbs> getList(int pageNumber){ //���� ����� �����ִ� �Լ�
         String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable =1 ORDER BY bbsID DESC LIMIT 10";
         ArrayList<Bbs> list = new ArrayList<Bbs>();
         try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext() - (pageNumber -1) * 10);
            rs = pstmt.executeQuery();
            while (rs.next()) {
               Bbs bbs= new Bbs();
               bbs.setBbsID(rs.getInt(1));//�����ͺ��̽����� �̾ƿ��°� rs.getString(), rs.getInt() �̸� �̰��� �־��ִ°� setBbsInt()���
               bbs.setBbsTitle(rs.getString(2));
               bbs.setUserID(rs.getString(3));
               bbs.setBbsDate(rs.getString(4));
               bbs.setBbsContent(rs.getString(5));
               bbs.setBbsAvailable(rs.getInt(6));
               list.add(bbs); //�迭�� �ϼ��� ��ü�� �߰��Ѵ�
            }
         } catch(Exception e) {
            e.printStackTrace();
         }
         return list;
      }
      
      
      public boolean nextPage(int pageNumber) { //��� ��ü�� �ѹ��� �������� �ʰ� ������� ��� �����ִ� �Լ�
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
      
      
      
      public Bbs getBbs(int bbsID) {   //�� ������ �ҷ����� �Լ�
    	  String SQL = "SELECT * FROM BBS WHERE bbsID= ?";
    	  try {
    		  PreparedStatement pstmt = conn.prepareStatement(SQL);
  			  pstmt.setInt(1, bbsID);
    		  rs = pstmt.executeQuery();
    		  if(rs.next()) {
    			  Bbs bbs= new Bbs();
                  bbs.setBbsID(rs.getInt(1));//�����ͺ��̽����� �̾ƿ��°� rs.getString(), rs.getInt() �̸� �̰��� �־��ִ°� setBbsInt()���
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
      
      
      
      public int update(int bbsID, String bbsTitle, String bbsContent) { //�����͸� �̾ƿ��°��� �ƴ϶� sql���� �̿��Ͽ� ������ �߰��ϴ� ���̹Ƿ� �ռ� ������ write�Լ��� ���
    	  String SQL = "UPDATE BBS SET bbsTitle=?, bbsContent=? WHERE bbsID = ?";
    	  try {
    		  PreparedStatement pstmt = conn.prepareStatement(SQL);
    		  pstmt.setString(1, bbsTitle); //�Ű������� ���� ������ �־��ش�
    		  pstmt.setString(2, bbsContent);
    		  pstmt.setInt(3, bbsID);
    		  return pstmt.executeUpdate(); //���������� �����ϸ� 0�̻��� ���� ��ȯ
    	  } catch(Exception e){
    		  e.printStackTrace();
    	  }
    	  return -1;//�����ͺ��̽� ����
      }
      
      
      public int delete(int bbsID) {
    	  String SQL = "UPDATE BBS SET bbsAvailable =0 WHERE bbsID = ?";
    	  try {
    		  PreparedStatement pstmt = conn.prepareStatement(SQL);
    		  pstmt.setInt(1, bbsID); //�Ű������� ���� ������ �־��ش�
    		  return pstmt.executeUpdate(); //���������� �����ϸ� 0�̻��� ���� ��ȯ
    	  } catch(Exception e){
    		  e.printStackTrace();
    	  }
    	  return -1;//�����ͺ��̽� ����
      }
      
      
}