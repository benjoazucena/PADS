package Models;

public class SchoolProgram {
	public SchoolProgram(int sPID, String institution, String level, String date_added, String next_survey_sched,
			String pending_reports, String next_survey_type, String degree_name) {
		super();
		SPID = sPID;
		this.institution = institution;
		this.level = level;
		this.date_added = date_added;
		this.next_survey_sched = formatDate(next_survey_sched);
		this.pending_reports = pending_reports;
		this.next_survey_type = next_survey_type;
		this.date_addedWord = formatDate(date_added);
		this.degree_name = degree_name;
		
	}
	
	public SchoolProgram(){
		
	}
	
	private int SPID;
	private String institution;
	private String level;
	private String date_added;
	private String next_survey_sched;
	private String pending_reports;
	private String next_survey_type;
	private String degree_name;
	private String date_addedWord;
	private String surveyDate;
	private String lapseDate;
	private String currentDecision;
	private String decisionBy;
	private String lastSurveyDate;
	
	public String getLastSurveyDate() {
		return lastSurveyDate;
	}

	public void setLastSurveyDate(String lastSurveyDate) {
		this.lastSurveyDate = formatDate(lastSurveyDate);
	}

	public String getDate_addedWord() {
		return date_addedWord;
	}

	public void setDate_addedWord(String date_addedWord) {
		this.date_addedWord = date_addedWord;
	}

	public int getSPID() {
		return SPID;
	}
	public void setSPID(int sPID) {
		SPID = sPID;
	}
	public String getInstitution() {
		return institution;
	}
	public void setInstitution(String institution) {
		this.institution = institution;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getDate_added() {
		return date_added;
	}
	public void setDate_added(String date_added) {
		this.date_added = date_added;
	}
	public String getNext_survey_sched() {
		return next_survey_sched;
	}
	public void setNext_survey_sched(String next_survey_sched) {
		this.next_survey_sched = next_survey_sched;
	}
	public String getPending_reports() {
		return pending_reports;
	}
	public void setPending_reports(String pending_reports) {
		this.pending_reports = pending_reports;
	}
	public String getNext_survey_type() {
		return next_survey_type;
	}
	public void setNext_survey_type(String next_survey_type) {
		this.next_survey_type = next_survey_type;
	}
	public String getDegree_name() {
		return degree_name;
	}
	public void setDegree_name(String degree_name) {
		this.degree_name = degree_name;
	}
	
	private static String formatDate(String date){
		String format = "NA";
		String month = "";
		String day;
		String year;
		System.out.println(date+"date of next sruv sched");

		if(date==null||date.equals("NA")||date.equals(" ")||date.equals("")){}
		else{
		String[] parts = date.split("-");
		System.out.println("pogiako"+ date);
		if(parts[1].equals("01")){
			month = "Jan";
		}else if(parts[1].equals("02")){
			month = "Feb";
		}else if(parts[1].equals("03")){
			month = "Mar";
		}else if(parts[1].equals("04")){
			month = "Apr";
		}else if(parts[1].equals("05")){
			month = "May";
		}else if(parts[1].equals("06")){
			month = "Jun";
		}else if(parts[1].equals("07")){
			month = "Jul";
		}else if(parts[1].equals("08")){
			month = "Aug";
		}else if(parts[1].equals("09")){
			month = "Sep";
		}else if(parts[1].equals("10")){
			month = "Oct";
		}else if(parts[1].equals("11")){
			month = "Nov";
		}else if(parts[1].equals("12")){
			month = "Dec";
		}
		year = parts[0];

//		parts = parts[1].split(",");
		day = parts[2];
		
		format = year + " " + month + " "+ day;
		}
		return format;
	}
	
}
