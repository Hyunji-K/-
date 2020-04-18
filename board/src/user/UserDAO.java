package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	private Connection conn;
	
	public UserDAO(Connection conn) {
		this.conn = conn;
	}
	
	private PreparedStatement  pstmt;
	private ResultSet rs;
	
	public UserDAO() {
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
	
	public int login(String userID, String userPassword) {
		
		String SQL = "SELECT userPassword FROM USER WHERE userID=?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID); //보안을 위해 이렇게 해줌
			rs = pstmt.executeQuery(); //실행
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; //로그인 성공
				}
				else
					return 0; //비밀번호 틀림
			}
			return -1; //아이디가 없음
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; //데이터베이스 오류
	}
	
	public int join(User user) { //insert는 반드시 0이상의 숫자가 반환 됨.
		
		String SQL = "INSERT INTO USER VALUSE (?,?,?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
}
