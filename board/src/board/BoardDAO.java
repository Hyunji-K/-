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
			String dbURL = "jdbc:mysql://localhost:3306/board?characterEncoding=UTF-8&serverTimezone=UTC"; //localhost:3306 은 로컬 컴퓨터에 있는 DB를 접근 할 수 있도록 함.
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.jdbc.Driver"); //mysql에 접속 할 수 있도록 하는 하나의 라이브러리 즉, 매개체 역할
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
//			접속을 완료하게 되면 conn  객체 안에 정보들이 이제 담기게 된다.
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
		return -1; // 데이터베이스 오류
		
	}
}
