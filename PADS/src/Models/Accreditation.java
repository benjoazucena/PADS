package Models;

import java.util.ArrayList;

public class Accreditation {
	private String institution;
	private String from;
	private String to;
	private String programs;
	
	public Accreditation(){
		
	}
	public Accreditation(String institution, String type, String from, String to, String position, String program,
			String areas) {
		super();
		this.institution = institution;
		this.from = from;
		this.to = to;
		this.programs = programs;
	}
	

	public String getPrograms() {
		return programs;
	}
	public void setPrograms(String programs) {
		this.programs = programs;
	}
	public String getInstitution() {
		return institution;
	}
	public void setInstitution(String institution) {
		this.institution = institution;
	}
	
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	
}
