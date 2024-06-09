package file;

public class File {
	private int fileid;
	private String username;
	private int cbid;
	private String content;
	private String path;
	private String date;
	public File(int fileid, String username, int cbid, String content, String path, String date) {
		this.fileid = fileid;
		this.username = username;
		this.cbid = cbid;
		this.content = content;
		this.path = path;
		this.date = date;
	}
	public int getFileid() {
		return fileid;
	}
	public void setFileid(int fileid) {
		this.fileid = fileid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public int getCbid() {
		return cbid;
	}
	public void setCbid(int cbid) {
		this.cbid = cbid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
}
