package Models;

public class AccreditorCard {

	private int accreditorID;
	private String accreditorName;
	private String affiliation;
	private String discipline;
	private String primary;
	private String secondary;
	private String tertiary;
	private int totalSurveys;
	private String city;
	private String lastSurveyDate;
	private double score;
	private double v1,v2,v3,v4;
	
	public AccreditorCard(int accreditorID,String accreditorName,String affiliation,String discipline,String primary,String secondary, String tertiary, int totalSurveys){
		
	}

	public AccreditorCard(){
		
	}
	public String getLastSurveyDate() {
		return lastSurveyDate;
	}

	public void setLastSurveyDate(String lastSurveyDate) {
		this.lastSurveyDate = lastSurveyDate;
	}

	public int getAccreditorID() {
		return accreditorID;
	}
	public void setAccreditorID(int accreditorID) {
		this.accreditorID = accreditorID;
	}
	public String getAccreditorName() {
		return accreditorName;
	}
	public void setAccreditorName(String accreditorName) {
		this.accreditorName = accreditorName;
	}
	public String getAffiliation() {
		return affiliation;
	}
	public void setAffiliation(String affiliation) {
		this.affiliation = affiliation;
	}
	public String getDiscipline() {
		return discipline;
	}
	public void setDiscipline(String discipline) {
		this.discipline = discipline;
	}
	public String getPrimary() {
		return primary;
	}
	public void setPrimary(String primary) {
		this.primary = primary;
	}
	public String getSecondary() {
		return secondary;
	}
	public void setSecondary(String secondary) {
		this.secondary = secondary;
	}
	public String getTertiary() {
		return tertiary;
	}
	public void setTertiary(String tertiary) {
		this.tertiary = tertiary;
	}
	public int getTotalSurveys() {
		return totalSurveys;
	}
	public void setTotalSurveys(int totalSurveys) {
		this.totalSurveys = totalSurveys;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public double getScore() {
		return score;
	}
	public void setScore(double score) {
		this.score = score;
	}
	public double getV1() {
		return v1;
	}
	public void setV1(double v1) {
		this.v1 = v1;
	}
	public double getV2() {
		return v2;
	}
	public void setV2(double v2) {
		this.v2 = v2;
	}
	public double getV3() {
		return v3;
	}
	public void setV3(double v3) {
		this.v3 = v3;
	}
	public double getV4() {
		return v4;
	}
	public void setV4(double v4) {
		this.v4 = v4;
	}
	
	
	
	
	
	
	
}
