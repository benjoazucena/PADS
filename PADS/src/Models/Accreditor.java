package Models;

import java.util.ArrayList;

public class Accreditor {
	
	private int accreditorID;
	private String honorifics;
	private String firstName;
	private String lastName;
	private String middleName;
	private String email;
	private String contact;
	private String institution;
	private String discipline;
	private String primaryArea;
	private String secondaryArea;
	private String tertiaryArea;
	private int totalSurveys;
	private String city;
	private String country;
	private String venue_trained;
	private String date_trained;
	private String address;
	private ArrayList<Degree> degrees;
	private ArrayList<Work> works;
	
	public Accreditor(int accreditorID, String honorifics, String firstName, String lastName, String middleName,
			String email, String contact, String institution, String discipline, String primaryArea, String secondaryArea, String tertiaryArea,
			int totalSurveys, String city, String country, String venue_trained, String date_trained, String address) {
		super();
		this.accreditorID = accreditorID;
		this.honorifics = honorifics;
		this.firstName = firstName;
		this.lastName = lastName;
		this.middleName = middleName;
		this.email = email;
		this.institution = institution;
		this.discipline = discipline;
		this.primaryArea = primaryArea;
		this.secondaryArea = secondaryArea;
		this.tertiaryArea = tertiaryArea;
		this.totalSurveys = totalSurveys;
		this.city = city;
		this.country = country;
		this.venue_trained = venue_trained;
		this.date_trained = date_trained;
		this.address = address;
		this.contact = contact;
		
		
	}
	
	public String getTertiaryArea() {
		return tertiaryArea;
	}

	public void setTertiaryArea(String tertiaryArea) {
		this.tertiaryArea = tertiaryArea;
	}

	public Accreditor(){
		
	}
	
	public void addDegrees(ArrayList<Degree> degrees){
		this.degrees = degrees;
	}
	
	public void addWorks(ArrayList<Work> works){
		this.works = works;
	}
	
	public ArrayList<Work> getWorks(){
		return works;
	}
	public ArrayList<Degree> getDegrees(){
		return degrees;
	}
	
	public String getContact(){
		return contact;
	}
	public void setContact(String contact){
		this.contact = contact;
	}
	public int getAccreditorID() {
		return accreditorID;
	}
	public void setAccreditorID(int accreditorID) {
		this.accreditorID = accreditorID;
	}
	public String getHonorifics() {
		return honorifics;
	}
	public void setHonorifics(String honorifics) {
		this.honorifics = honorifics;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getMiddleName() {
		return middleName;
	}
	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getInstitution() {
		return institution;
	}
	public void setInstitution(String institution) {
		this.institution = institution;
	}
	public String getDiscipline() {
		return discipline;
	}
	public void setDiscipline(String discipline) {
		this.discipline = discipline;
	}
	public String getPrimaryArea() {
		return primaryArea;
	}
	public void setPrimaryArea(String primaryArea) {
		this.primaryArea = primaryArea;
	}
	
	public int getPrimaryAreaID(){
		int id =0;
		System.out.println("AREA: " + primaryArea);
		if(primaryArea.equals("Faculty")) id = 1;
		else if(primaryArea.equals("Instruction")) id = 2;
		else if(primaryArea.equals("Laboratories")) id = 3;
		else if(primaryArea.equals("Libraries")) id = 4;
		else if(primaryArea.equals("Community")) id = 5;
		else if(primaryArea.equals("Physical Facilities")) id = 6;
		else if(primaryArea.equals("Student Services")) id = 7;
		else if(primaryArea.equals("Administration")) id = 8;
		else if(primaryArea.equals("Research")) id = 9;
		else if(primaryArea.equals("Clinical Training")) id = 10;
		else if(primaryArea.equals("Other Resources")) id = 11;
		return id;
	}
	public int getSecondaryAreaID(){
		int id =0;
		if(secondaryArea.equals("Faculty")) id = 1;
		else if(secondaryArea.equals("Instruction")) id = 2;
		else if(secondaryArea.equals("Laboratories")) id = 3;
		else if(secondaryArea.equals("Libraries")) id = 4;
		else if(secondaryArea.equals("Community")) id = 5;
		else if(secondaryArea.equals("Physical Facilities")) id = 6;
		else if(secondaryArea.equals("Student Services")) id = 7;
		else if(secondaryArea.equals("Administration")) id = 8;
		else if(secondaryArea.equals("Research")) id = 9;
		else if(secondaryArea.equals("Clinical Training")) id = 10;
		else if(secondaryArea.equals("Other Resources")) id = 11;
		return id;
	}
	
	public int getTertiaryAreaID(){
		int id =0;
		if(tertiaryArea.equals("Faculty")) id = 1;
		else if(tertiaryArea.equals("Instruction")) id = 2;
		else if(tertiaryArea.equals("Laboratories")) id = 3;
		else if(tertiaryArea.equals("Libraries")) id = 4;
		else if(tertiaryArea.equals("Community")) id = 5;
		else if(tertiaryArea.equals("Physical Facilities")) id = 6;
		else if(tertiaryArea.equals("Student Services")) id = 7;
		else if(tertiaryArea.equals("Administration")) id = 8;
		else if(tertiaryArea.equals("Research")) id = 9;
		else if(tertiaryArea.equals("Clinical Training")) id = 10;
		else if(tertiaryArea.equals("Other Resources")) id = 11;
		return id;
	}
	public String getSecondaryArea() {
		return secondaryArea;
	}
	public void setSecondaryArea(String secondaryArea) {
		this.secondaryArea = secondaryArea;
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
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getVenue_trained() {
		return venue_trained;
	}
	public void setVenue_trained(String venue_trained) {
		this.venue_trained = venue_trained;
	}
	public String getDate_trained() {
		return date_trained;
	}
	public void setDate_trained(String date_trained) {
		this.date_trained = date_trained;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getFullName(){
		return lastName + ", " + firstName + " " + middleName + " (" + honorifics + ")";
	}
	
}