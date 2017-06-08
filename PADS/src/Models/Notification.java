package Models;

public class Notification {

	public Notification(){}
	private int notificationID;
	public Notification(int notificationID, String content, String dateCreated, String status, String type) {
		this.notificationID = notificationID;
		this.content = content;
		this.dateCreated = dateCreated;
		this.status = status;
		this.type = type;
	}
	public int getNotificationID() {
		return notificationID;
	}
	public void setNotificationID(int notificationID) {
		this.notificationID = notificationID;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDateCreated() {
		return dateCreated;
	}
	public void setDateCreated(String dateCreated) {
		this.dateCreated = dateCreated;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	private String content;
	private String dateCreated;
	private String status;
	private String type;
	
	
}
