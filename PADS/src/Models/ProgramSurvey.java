package Models;

public class ProgramSurvey {

	private int PSID;
	private int surveyID;
	private int SPID;
	private String survey_type;
	private String board_decision;
	private String valid_thru;
	private String report_path;
	private String remarks;
	private String decision_date;
	private String decision_by;
	private String surveyDate;
	
	public String getSurveyDate() {
		return surveyDate;
	}

	public void setSurveyDate(String surveyDate) {
		this.surveyDate = surveyDate;
	}

	public ProgramSurvey(){
		
	}

	public int getPSID() {
		return PSID;
	}

	public void setPSID(int pSID) {
		PSID = pSID;
	}

	public int getSurveyID() {
		return surveyID;
	}

	public void setSurveyID(int surveyID) {
		this.surveyID = surveyID;
	}

	public int getSPID() {
		return SPID;
	}

	public void setSPID(int sPID) {
		SPID = sPID;
	}

	public String getSurvey_type() {
		return survey_type;
	}

	public void setSurvey_type(String survey_type) {
		this.survey_type = survey_type;
	}

	public String getBoard_decision() {
		return board_decision;
	}

	public void setBoard_decision(String board_decision) {
		this.board_decision = board_decision;
	}

	
	public ProgramSurvey(int pSID, int surveyID, int sPID, String survey_type, String board_decision, String valid_thru,
			String report_path, String remarks, String decision_date, String decision_by) {
		
		this.PSID = pSID;
		this.surveyID = surveyID;
		this.SPID = sPID;
		this.survey_type = survey_type;
		this.board_decision = board_decision;
		this.valid_thru = valid_thru;
		this.report_path = report_path;
		this.remarks = remarks;
		this.decision_date = decision_date;
		this.decision_by = decision_by;
	}

	public String getValid_thru() {
		return valid_thru;
	}

	public void setValid_thru(String valid_thru) {
		this.valid_thru = valid_thru;
	}

	public String getReport_path() {
		return report_path;
	}

	public void setReport_path(String report_path) {
		this.report_path = report_path;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getDecision_date() {
		return decision_date;
	}

	public void setDecision_date(String decision_date) {
		this.decision_date = decision_date;
	}

	public String getDecision_by() {
		return decision_by;
	}

	public void setDecision_by(String decision_by) {
		this.decision_by = decision_by;
	}
	
	
	
}
