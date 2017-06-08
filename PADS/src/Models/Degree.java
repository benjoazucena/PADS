package Models;

public class Degree {
	
	private String degree_name;
	private int accreditorID;
	private String institution;
	private int institutionID;
	public Degree(String degree_name, int accreditorID, String institution, int institutionID) {
		super();
		this.degree_name = degree_name;
		this.accreditorID = accreditorID;
		this.institution = institution;
		this.institutionID = institutionID;
	}
	
	public int getInstitutionID() {
		return institutionID;
	}

	public void setInstitutionID(int institutionID) {
		this.institutionID = institutionID;
	}

	public Degree(){
		
	}
	
	public String getDegree_name() {
		return degree_name;
	}
	public void setDegree_name(String degree_name) {
		this.degree_name = degree_name;
	}
	public int getAccreditorID() {
		return accreditorID;
	}
	public void setAccreditorID(int accreditorID) {
		this.accreditorID = accreditorID;
	}

	public String getInstitution() {
		return institution;
	}

	public void setInstitution(String institution) {
		this.institution = institution;
	}
	
	
	
}
