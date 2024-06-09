package chat;

public class Chat {
	private int chatid;
	private String username;
	private int cbid;
	private String content;
	private String date;
	public Chat(int chatid, String username, int cbid, String content, String date) {
		this.chatid = chatid;
		this.username = username;
		this.cbid = cbid;
		this.content = content;
		this.date = date;
	}
	public int getChatid() {
		return chatid;
	}
	public void setChatid(int chatid) {
		this.chatid = chatid;
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
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
}
