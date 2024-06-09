package checklist;

public class Checklist {
	private int cbid;
	private String clContent;
	private Long clDate;
	private int clIsChecked;
	private String userName;
	private String due;
	public Checklist(int cbid, String clContent, Long clDate, int clIsChecked, String userName, String due) {
		this.cbid = cbid;
		this.clContent = clContent;
		this.clDate = clDate;
		this.clIsChecked = clIsChecked;
		this.userName = userName;
		this.due = due;
	}
	public int getCbid() {
		return cbid;
	}
	public void setCbid(int cbid) {
		this.cbid = cbid;
	}
	public String getClContent() {
		return clContent;
	}
	public void setClContent(String clContent) {
		this.clContent = clContent;
	}
	public Long getClDate() {
		return clDate;
	}
	public void setClDate(Long clDate) {
		this.clDate = clDate;
	}
	public int getClIsChecked() {
		return clIsChecked;
	}
	public void setClIsChecked(int clIsChecked) {
		this.clIsChecked = clIsChecked;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getDue() {
		return due;
	}
	public void setDue(String due) {
		this.due = due;
	}
}
