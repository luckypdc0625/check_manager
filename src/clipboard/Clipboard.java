package clipboard;

public class Clipboard {
	private int cbId;
	private String cbName;
	private String cbInvolved;
	private String cbManager;
	public Clipboard(int cbId, String cbName, String cbInvolved, String cbManager) {
		this.cbId = cbId;
		this.cbName = cbName;
		this.cbInvolved = cbInvolved;
		this.cbManager = cbManager;
	}
	public int getCbId() {
		return cbId;
	}
	public void setCbId(int cbId) {
		this.cbId = cbId;
	}
	public String getCbName() {
		return cbName;
	}
	public void setCbName(String cbName) {
		this.cbName = cbName;
	}
	public String getCbInvolved() {
		return cbInvolved;
	}
	public void setCbInvolved(String cbInvolved) {
		this.cbInvolved = cbInvolved;
	}
	public String getCbManager() {
		return cbManager;
	}
	public void setCbManager(String cbManager) {
		this.cbManager = cbManager;
	}
}
