package chat;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import clipboard.Clipboard;


public class ChatDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private static ChatDAO chatDAO = new ChatDAO();
	
	public static ChatDAO getInstance() {
		return chatDAO;
	}
	
	public ChatDAO() {
		try {
			InitialContext ctx= new InitialContext();
			DataSource ds= (DataSource) ctx.lookup("java:comp/env/jdbc/mysql");
			conn = ds.getConnection();
			
			/* 커넥션풀 안쓸때
			String dbURL = "jdbc:mysql://localhost:3306/indiv_pro?serverTimezone=UTC";
			String dbID = "owner";
			String dbPassword = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			*/
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int insert(String username, int cbid, String content, String date) {
		String sql = "INSERT INTO chat(username, cbid, content, date) VALUES(?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, username);
			pstmt.setInt(2, cbid);
			pstmt.setString(3, content);
			pstmt.setString(4,  date);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Chat> loadAll(int cbid) {
		int chatid = 0;
		String username = "";
		String content = "";
		String date = "";
        ArrayList<Chat> chats = new ArrayList<Chat>();
        try {
            pstmt = conn.prepareStatement("select * from chat where cbid = ? order by chatid asc");
            pstmt.setInt(1, cbid);
            rs= pstmt.executeQuery();
            while(rs.next()) {
            	chatid = rs.getInt("chatid");
            	username = rs.getString("username");
            	content = rs.getString("content");
            	date = rs.getString("date");
            	chats.add(new Chat(chatid, username, cbid, content, date));
            }
        } catch(Exception e) {
        	e.printStackTrace();
        }
        return chats;
	}
}
