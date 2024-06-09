package clipboard;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import user.User;
import user.UserDAO;

public class ClipboardDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private static ClipboardDAO clipboardDAO = new ClipboardDAO();
	
	public static ClipboardDAO getInstance() {
		return clipboardDAO;
	}
	
	public ClipboardDAO() {
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
	
	public int create(String name, String involved, String manager) {
		String sql = "INSERT INTO clipboard(name, involved, manager) VALUES(?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, involved);
			pstmt.setString(3,  manager);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public ArrayList<Clipboard> loadAll(String userName) {
		int cbid = 0;
		String name = "";
		String involved = "";
		String manager = "";
        ArrayList<Clipboard> cbs = new ArrayList<Clipboard>();
        try {
            pstmt = conn.prepareStatement("select * from clipboard");
            rs= pstmt.executeQuery();
            while(rs.next()) {
            	cbid = rs.getInt("id");
            	name = rs.getString("name");
            	involved = rs.getString("involved");
            	manager = rs.getString("manager");
            	cbs.add(new Clipboard(cbid, name, involved, manager));
            }
        } catch(Exception e) {
        	e.printStackTrace();
        }
        return cbs;
	}
	public int inviteUser(int cbid, String userList) {
		String involved = "";
		String sql = "select * from clipboard where id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cbid);
	        rs= pstmt.executeQuery();
	        while(rs.next()) {
	        	involved = rs.getString("involved");
	        }
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		String sql2 = "update clipboard set involved = ? where id = ?";
		try {
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, involved+userList);
			pstmt.setInt(2, cbid);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public String getInvolvedExceptMe(int cbid, String me) {
		String involved = "";
		String sql = "select involved from clipboard where id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cbid);
	        rs= pstmt.executeQuery();
	        while(rs.next()) {
	        	involved = rs.getString("involved");
	        }
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		String[] involvedUsers = involved.split(",");
		String newInvolved = "";
		
		if(involvedUsers.length == 1) {
			
		} else {
			for (int i = 0; i < involvedUsers.length; i++) {
				if (!(involvedUsers[i].equals(me))) {
					newInvolved += involvedUsers[i];
					if (i != involvedUsers.length - 2 && i != involvedUsers.length - 1) {
						newInvolved += ",";
					} else if (i == involvedUsers.length - 2  && !(involvedUsers[involvedUsers.length - 1].equals(me))) {
						newInvolved += ",";
					}
				}
			}
		}
		return newInvolved;
	}
	public int exit(int cbid, String me) {
		String newInvolved = getInvolvedExceptMe(cbid, me);
		
		if(newInvolved.equals("")) {
			String sql = "delete from clipboard where id = ?";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, cbid);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			String sql = "update clipboard set involved = ? where id = ?";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, newInvolved);
				pstmt.setInt(2, cbid);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	public String getManager(int cbid) {
		String manager = "";
        try {
            pstmt = conn.prepareStatement("select manager from clipboard where id = ?");
            pstmt.setInt(1, cbid);
            rs= pstmt.executeQuery();
            while(rs.next()) {
            	manager = rs.getString("manager");
            }
        } catch(Exception e) {
        	e.printStackTrace();
        }
        return manager;
	}
	public String getInvolved(int cbid) {
		String involved = "";
        try {
            pstmt = conn.prepareStatement("select involved from clipboard where id = ?");
            pstmt.setInt(1, cbid);
            rs= pstmt.executeQuery();
            while(rs.next()) {
            	involved = rs.getString("involved");
            }
        } catch(Exception e) {
        	e.printStackTrace();
        }
        return involved;
	}
	public String getName(int cbid) {
		String name = "";
        try {
            pstmt = conn.prepareStatement("select name from clipboard where id = ?");
            pstmt.setInt(1, cbid);
            rs= pstmt.executeQuery();
            while(rs.next()) {
            	name = rs.getString("name");
            }
        } catch(Exception e) {
        	e.printStackTrace();
        }
        return name;
	}
	public int changeManager(int cbid, String nominee) {
		String sql = "update clipboard set manager = ? where id = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nominee);
			pstmt.setInt(2, cbid);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
