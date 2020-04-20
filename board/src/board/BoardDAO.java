package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BoardDAO {
	
	private Connection conn;
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
	
	public String getDate() { //현재 시간 가져오는 함수
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery(); // 실행
			if(rs.next()) { //결과가 있는 경우
				return rs.getString(1); //현재의 시간 그대로 반환
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류
	}
	public int write(String boardTitle, String userID, String boardContent) {
		
		String SQL = "INSERT INTO BOARD VALUES (?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, boardTitle); 
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, boardContent);
			pstmt.setInt(6, 1);
			
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류	
	}

	public int getNext() { //게시글 번호 입력 함수
		
		String SQL = "SELECT boardID FROM BOARD ORDER BY boardID DESC"; //제일 마지막 숫자 가져오기
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //첫번째 게시물인 경우 1반환
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public ArrayList<Board> getList(int pageNumber){ //페이징 처리
		
		String SQL = "SELECT * FROM BOARD WHERE boardID < ? AND boardAvailable = 1 ORDER BY boardID DESC LIMIT 10";
		ArrayList<Board> list = new ArrayList<Board>();
		try {
			PreparedStatement pstmt =  conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1)*10);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Board board = new Board();
				board.setBoardID(rs.getInt(1));
				board.setBoardTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setBoardDate(rs.getString(4));
				board.setBoardContent(rs.getString(5));
				board.setBoardAvailable(rs.getInt(6));
				list.add(board);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) { //10단위로 끊켰을 때 다음 페이지 없다는 처리
		
		String SQL = "SELECT * FROM BOARD WHERE boardID < ? AND boardAvailable = 1"; 
		
		try {
			PreparedStatement pstmt =  conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1)*10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
