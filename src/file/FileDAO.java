package file;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;



public class FileDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private static FileDAO fileDAO = new FileDAO();
	
	public static FileDAO getInstance() {
		return fileDAO;
	}
	
	public FileDAO() {
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
	
	public int insert(String username, int cbid, String content, String path, String date) {
		String sql = "INSERT INTO file(username, cbid, content, path, date) VALUES(?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, username);
			pstmt.setInt(2, cbid);
			pstmt.setString(3, content);
			pstmt.setString(4, path);
			pstmt.setString(5, date);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<File> loadAll(int cbid) {
		int fileid = 0;
		String username = "";
		String content = "";
		String path = "";
		String date = "";
        ArrayList<File> files = new ArrayList<File>();
        try {
            pstmt = conn.prepareStatement("select * from file where cbid = ? order by fileid asc");
            pstmt.setInt(1, cbid);
            rs= pstmt.executeQuery();
            while(rs.next()) {
            	fileid = rs.getInt("fileid");
            	username = rs.getString("username");
            	content = rs.getString("content");
            	path = rs.getString("path");
            	date = rs.getString("date");
            	files.add(new File(fileid, username, cbid, content, path, date));
            }
        } catch(Exception e) {
        	e.printStackTrace();
        }
        return files;
	}
	public int delete(int fileid) {
		String sql = "delete from file where fileid = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, fileid);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
