package Models;

public class Work {
	
	private String institution;
	private int accreditorID;
	private String date_entered;
	private String date_finished;
	private String position;
	private int institutionID;
	
	
	public Work(String institution, int accreditorID, String date_entered, String date_finished, String position, int institutionID) {
		super();
		this.institution = institution;
		this.accreditorID = accreditorID;
		this.date_entered = date_entered;
		this.date_finished = date_finished;
		this.position = position;
		this.institutionID = institutionID;
	}
	
	public Work(){
		
	}
	
	public int getInstitutionID() {
		return institutionID;
	}

	public void setInstitutionID(int institutionID) {
		this.institutionID = institutionID;
	}

	public int getAccreditorID() {
		return accreditorID;
	}
	public void setAccreditorID(int accreditorID) {
		this.accreditorID = accreditorID;
	}
	public String getDate_entered() {
		return date_entered;
	}
	public void setDate_entered(String date_entered) {
		this.date_entered = date_entered;
	}
	public String getDate_finished() {
		return date_finished;
	}
	public void setDate_finished(String date_finished) {
		this.date_finished = date_finished;
	}

	public String getInstitution() {
		return institution;
	}

	public void setInstitution(String institution) {
		this.institution = institution;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}
	
	
}
