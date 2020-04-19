package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BoardDAO {
	
	private Connection conn;
	
	public BoardDAO(Connection conn) {
		this.conn = conn;
	}
	
	private PreparedStatement  pstmt;
	private ResultSet rs;
	
	public BoardDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/board?characterEncoding=UTF-8&serverTimezone=UTC"; //localhost:3306 �� ���� ��ǻ�Ϳ� �ִ� DB�� ���� �� �� �ֵ��� ��.
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.jdbc.Driver"); //mysql�� ���� �� �� �ֵ��� �ϴ� �ϳ��� ���̺귯�� ��, �Ű�ü ����
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
//			������ �Ϸ��ϰ� �Ǹ� conn  ��ü �ȿ� �������� ���� ���� �ȴ�.
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int write(Board board) {
		
		String SQL = "INSERT INTO BOARD VALUES (?,?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, board.getBoardID());
			pstmt.setString(2, board.getBoardTitle()); 
			pstmt.setString(3, board.getUserID());
			pstmt.setString(4, board.getBoardDate());
			pstmt.setString(5, board.getBoardContent());
			pstmt.setInt(6, board.getBoardAvailable());
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
		
	}
}
