package checklist;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;


public class ChecklistDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private static ChecklistDAO checklistDAO = new ChecklistDAO();
	
	public static ChecklistDAO getInstance() {
		return checklistDAO;
	}
	
	public ChecklistDAO() {
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
	public int create(Checklist checklist) {
		String sql = "INSERT INTO checklist VALUES(?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, checklist.getCbid());
			pstmt.setString(2, checklist.getClContent());
			pstmt.setLong(3, checklist.getClDate());
			pstmt.setInt(4, checklist.getClIsChecked());
			pstmt.setString(5, checklist.getUserName());
			pstmt.setString(6,  checklist.getDue());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public ArrayList<Checklist> loadAll() {
		int cbid = 0;
		String content = "";
		long date = 0;
		int isChecked = 0;
		String userName = "";
		String due = "";
		ArrayList<Checklist> cls = new ArrayList<Checklist>();
        try {
            pstmt = conn.prepareStatement("select * from checklist");
            rs= pstmt.executeQuery();
            while(rs.next()) {
            	cbid = rs.getInt("cbid");
            	content = rs.getString("content");
            	date = rs.getLong("date");
            	isChecked = rs.getInt("isChecked");
            	userName = rs.getString("userName");
            	due = rs.getString("due");
            	cls.add(new Checklist(cbid, content, date, isChecked, userName, due));
            }
        } catch(Exception e) {
        	e.printStackTrace();
        }
        return cls;
	}
	public int checkedChanged(long date) {
		int isChecked = -1;
		int afterIsChecked = -1;
		try {
			pstmt = conn.prepareStatement("select isChecked from checklist where date = " + date);
			rs= pstmt.executeQuery();
			while(rs.next()) {
            	isChecked = rs.getInt("isChecked");
            }
		} catch(Exception e) {
			e.printStackTrace();
		}
		if(isChecked == 0) {
			afterIsChecked = 1;
		} else if(isChecked == 1) {
			afterIsChecked = 0;
		}
		String sql = "UPDATE checklist SET isChecked = " + afterIsChecked +  " where date = " + date;
		try {
			pstmt = conn.prepareStatement(sql);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public int delete(long date) {
		String sql = "delete from checklist where date = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, date);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	public int allById(int cbid) {
		int all = 0;
        try {
            pstmt = conn.prepareStatement("select count(*) as allcount from checklist where cbid = ?");
            pstmt.setInt(1, cbid);
            rs= pstmt.executeQuery();
            while(rs.next()) {
            	all = rs.getInt("allcount");
            }
        } catch(Exception e) {
        	e.printStackTrace();
        }
        return all;
	}
	public int checkedById(int cbid) {
		int checked = 0;
        try {
            pstmt = conn.prepareStatement("select count(*) as checked from checklist where cbid = ? and isChecked = ?");
            pstmt.setInt(1, cbid);
            pstmt.setInt(2, 1);
            rs= pstmt.executeQuery();
            while(rs.next()) {
            	checked = rs.getInt("checked");
            }
        } catch(Exception e) {
        	e.printStackTrace();
        }
        return checked;
	}
	public double progressById(int cbid) {
		if(allById(cbid) != 0) {
			return (double)checkedById(cbid)/allById(cbid);
		} else {
			return 0;
		}
	}
}