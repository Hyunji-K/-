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
	
	public String getDate() { //���� �ð� �������� �Լ�
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery(); // ����
			if(rs.next()) { //����� �ִ� ���
				return rs.getString(1); //������ �ð� �״�� ��ȯ
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //�����ͺ��̽� ����
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
		return -1; // �����ͺ��̽� ����	
	}

	public int getNext() { //�Խñ� ��ȣ �Է� �Լ�
		
		String SQL = "SELECT boardID FROM BOARD ORDER BY boardID DESC"; //���� ������ ���� ��������
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //ù��° �Խù��� ��� 1��ȯ
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
	
	public ArrayList<Board> getList(int pageNumber){ //����¡ ó��
		
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
	
	public boolean nextPage(int pageNumber) { //10������ ������ �� ���� ������ ���ٴ� ó��
		
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
