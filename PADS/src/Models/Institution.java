	package Models;

public class Institution {

	private int institutionID;
	private String institutionAcronym;
	public String getInstitutionAcronym() {
		return institutionAcronym;
	}

	public void setInstitutionAcronym(String institutionAcronym) {
		this.institutionAcronym = institutionAcronym;
	}

	private int schoolsystemID;
	public String getContact_email() {
		return contact_email;
	}

	public void setContact_email(String contact_email) {
		this.contact_email = contact_email;
	}

	private String schoolsystemName;
	public String getSchoolsystemName() {
		return schoolsystemName;
	}

	public void setSchoolsystemName(String schoolsystemName) {
		this.schoolsystemName = schoolsystemName;
	}

	private String name;
	private String head="";
	private String position="";
	private String email="";
	private String address="";
	private String region="";
	private String status="";
	private String date_added="";
	private String city="";
	private String fax="";
	private String contact_person="";
	private String contact_number="";
	private String contact_position="";
	public String getContact_position() {
		return contact_position;
	}

	public void setContact_position(String contact_position) {
		this.contact_position = contact_position;
	}

	private String website;
	private String country;
	private String contact_email;
	private String date_addedWord;
	
	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public int getInstitutionID() {
		return institutionID;
	}

	public void setInstitutionID(int institutionID) {
		this.institutionID = institutionID;
	}

	public int getSchoolsystemID() {
		return schoolsystemID;
	}

	public void setSchoolsystemID(int schoolsystemID) {
		this.schoolsystemID = schoolsystemID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getHead() {
		return head;
	}

	public void setHead(String head) {
		this.head = head;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDate_added() {
		return date_added;
	}

	public void setDate_added(String date_added) {
		this.date_added = date_added;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getContact_person() {
		return contact_person;
	}

	public void setContact_person(String contact_person) {
		this.contact_person = contact_person;
	}

	public String getContact_number() {
		return contact_number;
	}

	public void setContact_number(String contact_number) {
		this.contact_number = contact_number;
	}

	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	public Institution(){}
	
	public Institution(int institutionID, int schoolsystemID, String name, String head, String position, String email,
			String address, String status, String date_added, String city, String fax,
			String contact_person, String contact_position, String contact_number, String website, String country, String contact_email, String institutionAcronym) {
		super();
		this.institutionID = institutionID;
		this.schoolsystemID = schoolsystemID;
		this.institutionAcronym = institutionAcronym;
		this.name = name;
		this.head = head;
		this.position = position;
		this.email = email;
		this.address = address;
		this.country = country;
		this.status = status;
		this.date_added = formatDate_yearFirst(date_added);
		this.date_addedWord = formatDate(date_added);
		this.city = city;
		this.fax = fax;
		this.contact_person = contact_person;
		this.contact_number = contact_number;
		this.contact_email = contact_email;
		this.website = website;
		this.contact_position =contact_position;
		System.out.println(date_added+"CITY!!!!!!!!!!"+ institutionAcronym);
	}
	
	public String getDate_addedWord() {
		return date_addedWord;
	}

	public void setDate_addedWord(String date_addedWord) {
		this.date_addedWord = date_addedWord;
	}

	private static String formatDate(String date){
		String format = new String();
		String month = "";
		String day;
		String year;
		if(date==null||date.equals("")||date.equals(" ")){}
		else{
		String[] parts = date.split("-");
		if(parts[1].equals("01")){
			month = "January";
		}else if(parts[1].equals("02")){
			month = "February";
		}else if(parts[1].equals("03")){
			month = "March";
		}else if(parts[1].equals("04")){
			month = "April";
		}else if(parts[1].equals("05")){
			month = "May";
		}else if(parts[1].equals("06")){
			month = "June";
		}else if(parts[1].equals("07")){
			month = "July";
		}else if(parts[1].equals("08")){
			month = "August";
		}else if(parts[1].equals("09")){
			month = "September";
		}else if(parts[1].equals("10")){
			month = "October";
		}else if(parts[1].equals("11")){
			month = "November";
		}else if(parts[1].equals("12")){
			month = "December";
		}
		year = parts[0];

//		parts = parts[1].split(",");
		day = parts[2];
		
		format = month + " " + day + ", "+ year;
		}
		return format;
	}
	
	private static String formatDate_yearFirst(String date){
		String format = new String();
		String month = "";
		String day;
		String year;
		if(date==null||date.equals("")||date.equals(" ")){}
		else{
		String[] parts = date.split("-");
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
