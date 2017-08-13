package Models;

public class Survey {
	private int surveyID;
	
	private String start_date;
	private String end_date;	
	private String date_approved;
	private String date_requested;
	private int institutionID;
	private String institutionName;
	public int getSurveyID() {
		return surveyID;
	}
	public void setSurveyID(int surveyID) {
		this.surveyID = surveyID;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getDate_approved() {
		return date_approved;
	}
	public void setDate_approved(String date_approved) {
		this.date_approved = date_approved;
	}
	public String getDate_requested() {
		return date_requested;
	}
	public void setDate_requested(String date_requested) {
		this.date_requested = date_requested;
	}
	public int getInstitutionID() {
		return institutionID;
	}
	public void setInstitutionID(int institutionID) {
		this.institutionID = institutionID;
	}
	public String getInstitutionName() {
		return institutionName;
	}
	public void setInstitutionName(String institutionName) {
		this.institutionName = institutionName;
	}
}
