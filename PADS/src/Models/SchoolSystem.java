package Models;

public class SchoolSystem {


	private int schoolsystemID;
	private String name;
	private String date_joined = "";
	private int numberOfInstitutions;
	
	public SchoolSystem(){}
	
	public int getNumberOfInstitutions() {
		return numberOfInstitutions;
	}

	public void setNumberOfInstitutions(int numberOfInstitutions) {
		this.numberOfInstitutions = numberOfInstitutions;
	}

	public SchoolSystem(int schoolsystemID, String name, String date_joined) {
		super();
		this.schoolsystemID = schoolsystemID;
		this.name = name;
		this.date_joined = date_joined;
	}

	public int getSchoolSystemID() {
		return schoolsystemID;
	}

	public void setSchoolSystemID(int schoolsystemID) {
		this.schoolsystemID = schoolsystemID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDate_joined() {
		return date_joined;
	}

	public void setDate_joined(String date_joined) {
		this.date_joined = date_joined;
	}
	
	
	
	
}
