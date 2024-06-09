package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private static UserDAO userDAO = new UserDAO();
	
	public static UserDAO getInstance() {
		return userDAO;
	}
	
	public UserDAO() {
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
	public int join(User user) {
		String sql = "INSERT INTO USER VALUES(?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			//pstmt.setInt(1, user.getUserUno());
			pstmt.setString(1, user.getUserId());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	/*
	public int newUno() {
		String sql = "SELECT userNewUno FROM MANAGE";
		int result = -1;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt("userNewUno");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public int newUnoPlus() {
		String sql = "UPDATE MANAGE SET userNewUno = MANAGE.userNewUno+1";
		try {
			pstmt = conn.prepareStatement(sql);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	*/
	public int userCheck(String id, String password) throws Exception {
        String dbpasswd = ""; //db에서 꺼내온 패스워드를 저장할 곳
        int x=-1;
        try {
            pstmt = conn.prepareStatement("select password from user where id = ?");
            pstmt.setString(1, id);
            rs= pstmt.executeQuery();

            if(rs.next()) { // 아이디에 해당하는 비밀번호가 있을 때
            	dbpasswd = rs.getString("password");
            	if(dbpasswd.equals(password))  //꺼내온 값과 매개변수로 입력된 password 값을 비교
            		x= 1;  //인증 성공
            	else
            		x= 0;  //비밀번호 틀림
            } else
            	x= -1;  //해당 아이디 없음
        } catch(Exception e) {
        	e.printStackTrace();
        }
        return x;
    }
	public User getUser(String id) {
		String password = "";
		String name = "";
        User user = null;
        try {
            pstmt = conn.prepareStatement("select * from user where id = ?");
            pstmt.setString(1, id);
            rs= pstmt.executeQuery();
            if(rs.next()) { 
            	password = rs.getString("password");
            	name = rs.getString("name");
            	user = new User(id, password, name);
            }
        } catch(Exception e) {
        	e.printStackTrace();
        }
        return user;
	}
	public int nameCheck(String name) throws Exception {
        int x = 0;
        try {
            pstmt = conn.prepareStatement("select * from user where name = ?");
            pstmt.setString(1, name);
            rs= pstmt.executeQuery();

            if(rs.next()) {
            	x = 1;
            } else
            	x = 0;
        } catch(Exception e) {
        	e.printStackTrace();
        }
        return x;
    }
}
