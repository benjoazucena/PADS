package Utilities;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.json.JSONArray;
import org.json.JSONObject;

import com.mysql.jdbc.Connection;

import Models.Accreditor;
import Models.Notification;
import Models.Survey;

public class NotificationUtil {
	private DBUtil db;
	
	public NotificationUtil(){		
			db = new DBUtil();
	}
	
	
	public ArrayList<Notification> getAllNotifications (){
		ArrayList<Notification> notifs = new ArrayList<Notification>();
		Notification temp = new Notification();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM notifications");
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
								
				int notificationID = rs.getInt(1);
				String content = rs.getString(2);
				String date_created = rs.getString(3);
				String status = rs.getString(4);
				String type = rs.getString(5);
				System.out.println(content+"weeeeeeeeeeeeeeeeeeeeeeeeeeew");
				temp = new Notification(notificationID, content, date_created, status, type);
				notifs.add(temp);
			}
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:getAccreditors()");
			e.printStackTrace();
		}
		
	    return notifs;
	}
	
	public ArrayList<Notification> getAwardNotifications (){
		ArrayList<Notification> notifs = new ArrayList<Notification>();
		Notification temp = new Notification();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM notifications where type = ?");
			ps.setString(1,"Awards");
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
								
				int notificationID = rs.getInt(1);
				String content = rs.getString(2);
				String date_created = rs.getString(3);
				String status = rs.getString(4);
				String type = rs.getString(5);
				
				temp = new Notification(notificationID, content, date_created, status, type);
				notifs.add(temp);
			}
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:getAccreditors()");
			e.printStackTrace();
		}
		
	    return notifs;
	}

	
	public ArrayList<Notification> getExpirationNotifications (){
		ArrayList<Notification> notifs = new ArrayList<Notification>();
		Notification temp = new Notification();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM notifications where type = ?");
			ps.setString(1,"Expirations");
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
								
				int notificationID = rs.getInt(1);
				String content = rs.getString(2);
				String date_created = rs.getString(3);
				String status = rs.getString(4);
				String type = rs.getString(5);
				
				temp = new Notification(notificationID, content, date_created, status, type);
				notifs.add(temp);
			}
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:getAccreditors()");
			e.printStackTrace();
		}
		
	    return notifs;
	}

	
	public ArrayList<Notification> getUnconfirmedNotifications (){
		ArrayList<Notification> notifs = new ArrayList<Notification>();
		Notification temp = new Notification();
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM notifications where type = ?");
			ps.setString(1,"UnconfirmedSurveys");
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
								
				int notificationID = rs.getInt(1);
				String content = rs.getString(2);
				String date_created = rs.getString(3);
				String status = rs.getString(4);
				String type = rs.getString(5);
								
				temp = new Notification(notificationID, content, date_created, status, type);
				notifs.add(temp);
			}
		} catch (Exception e){
			System.out.println("Error in AccreditorUtil:getAccreditors()");
			e.printStackTrace();
		}
		
	    return notifs;
	}
	
	private boolean validContent(String content){
		boolean res = true;
		try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT content FROM notifications");
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
			if(rs.getString(1).equals(content)){
				res=false;
				System.out.println("FOUND A DUPLICATE FOR : "+content);
				 break;
			}
			
			}
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:getInstitutionCity()");
			e.printStackTrace();
		}
		 return res;
		
	}
	
	public void generateNotif(String content, String type){
		
		if(validContent(content)){
		try{
		Connection conn = db.getConnection();
		PreparedStatement ps = conn.prepareStatement("INSERT INTO `notifications` (`content`,`date_created`,`status`,`type`)"
													+"VALUES (?, ?, ?, ? ); ");
		ps.setString(1, content);
		ps.setString(2, formatNotifDate());
		ps.setString(3, "unread");
		ps.setString(4, type);
		ps.executeUpdate();
		
		} catch (Exception e){
			System.out.println("Error in generateNotif due to DUPLICATE ! ! !");
//			e.printStackTrace();
		}
		}
	}
	
	public void checkExpiredAccreditations(){
System.out.println("EXPIRATION NOTIFS CREATED");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		int curDate = Integer.parseInt(dateFormat.format(date).toString().replace("-", ""));
		
		try{
			Connection conn = db.getConnection();
			//SQL statement that checks if the current date is greater than the date of validity of a program's latest accreditation
			PreparedStatement ps = conn.prepareStatement("SELECT `SPID` , `valid_thru` FROM `program-survey` WHERE `valid_thru` IS NOT NULL");
			ResultSet rs = ps.executeQuery();
			ArrayList<Integer> expiredList = new ArrayList<Integer>();
			ArrayList<String> validityList = new ArrayList<String>();
			while(rs.next()){
				System.out.println(rs.getString(2)+"VALID THRU");
				int valid_thru = Integer.parseInt(rs.getString(2).replace("-",""));				
				if(valid_thru-curDate <= 10000){
					expiredList.add(rs.getInt(1));					
					validityList.add(rs.getString(2));
				}	
			}
			System.out.println("MAGICCCCCC!");
		
			generateExpiryNotifs(expiredList, validityList);
	
		} catch (Exception e){
				System.out.println("DUplicate Copy of Notification");
			}
	}
	
	private void generateExpiryNotifs(ArrayList<Integer> expiredList, ArrayList<String> validityList){
//		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@!");
		for(int i = 0; i<expiredList.size(); i++){
			String content = getContentNames(expiredList.get(i)) + " : Valid Until "+ validityList.get(i);
//			System.out.println(content+" CONTENT OF EXPIRATION NOTIF");
			generateNotif(content,"Expirations");
		}
	}

	
	private void getUnconfirmedSurveyList(ArrayList<Integer> filteredSurveyID){
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		int curDate = Integer.parseInt(dateFormat.format(date).toString().replace("-", ""));
		ArrayList<Survey> surveyList = new ArrayList<Survey>();
		
		try{
			Connection conn = db.getConnection();
			//SQL statement that checks if the current date is greater than the date of validity of a program's latest accreditation
			PreparedStatement ps = conn.prepareStatement("SELECT `surveyID` , `end_date`,`institutionID` FROM `surveys");
			ResultSet rs = ps.executeQuery();
				
			while(rs.next()){
				Survey survTemp = new Survey();
				int end_dateINT = Integer.parseInt(rs.getString(2).replace("-",""));
				for(int i = 0; i<filteredSurveyID.size();i++){
					if(curDate-end_dateINT > 0 && filteredSurveyID.get(i) == rs.getInt(1)){
						survTemp.setSurveyID(rs.getInt(1));
						survTemp.setEnd_date(rs.getString(2));
						survTemp.setInstitutionID(rs.getInt(3));
						survTemp.setInstitutionName(getInstName(rs.getInt(3)));
						System.out.println(i+" - "+survTemp.getEnd_date()+" | "+survTemp.getInstitutionName());
						surveyList.add(survTemp);
					}
				
				}
			
			}
			generateUnconfirmedNotifs(surveyList);
			
		} catch (Exception e){
				System.out.println("DUplicate Copy of Notification");
			}
	}
	
	private String getInstName(int institutionID){
	String name = "";
			try{
			Connection conn = db.getConnection();
			PreparedStatement ps = conn.prepareStatement("SELECT name FROM institutions WHERE institutionID = ?");
			ps.setInt(1, institutionID);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				name = rs.getString(1);
			}
		} catch (Exception e){
			System.out.println("Error in SurveyUtil:getInstitutionCity()");
			e.printStackTrace();
		}
	return name;
	}
	
	public void checkUnconfirmedSurveys(){
		System.out.println("ENTRY IN CHECK UNCONFIRMED NOTIF");
		ArrayList<Integer> filteredSurveyID = new ArrayList<Integer>();
	
		try{
			Connection conn = db.getConnection();
			//SQL statement that checks if the current date is greater than the date of validity of a program's latest accreditation
			PreparedStatement ps = conn.prepareStatement("SELECT DISTINCT `surveyID`FROM `program-survey` WHERE `currentDecisionBy` = ?");
			ps.setString(1,"None" );
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
			filteredSurveyID.add(rs.getInt(1));
			}
			
			getUnconfirmedSurveyList(filteredSurveyID);
		
		} catch (Exception e){
				System.out.println("Error in NotificationUtil:filterUnconfirmedSurveys()");
				e.printStackTrace();
			}
		

		
	}

	
	private void generateUnconfirmedNotifs(ArrayList<Survey> surveyList){
		
		for(int i = 0; i<surveyList.size(); i++){			
			String content = surveyList.get(i).getInstitutionName() + "'s Survey last '"+ formatDate(surveyList.get(i).getEnd_date()) + "' is Unconfirmed";
			System.out.println(content+" CONTENT OF Unconfirmation NOTIF");
			generateNotif(content,"UnconfirmedSurveys");
		}
	}

	private String getContentNames(int SPID){
		String name = "";
		int institutionID;
		
		try{
			Connection conn = db.getConnection();
			//SQL statement that checks if the current date is greater than the date of validity of a program's latest accreditation
			PreparedStatement ps = conn.prepareStatement("SELECT `degree_name`,`institutionID` FROM `school-program` WHERE SPID = ?");
			ps.setInt(1, SPID);
			ResultSet rs = ps.executeQuery();
			rs.next();
			name = rs.getString(1);
			institutionID = rs.getInt(2);
			
			ps = conn.prepareStatement("SELECT `name` FROM `institutions` WHERE `institutionID` = ?");
			ps.setInt(1, institutionID);
			rs = ps.executeQuery();
			rs.next();
			name =rs.getString(1) + " - " + name ;
			
		} catch (Exception e){
				System.out.println("Error in AccreditorUtil:getAccreditors()");
				e.printStackTrace();
			}
		return name;
	}
	
private static String formatNotifDate(){
	long yourmilliseconds = System.currentTimeMillis();
	SimpleDateFormat sdf = new SimpleDateFormat("MMM dd yyyy HH:mm");    
	Date resultdate = new Date(yourmilliseconds);	
	return sdf.format(resultdate);
}

private static String formatDate(String date){
	String format = "Date Error";
	String month = "";
	String day;
	String year;
	System.out.println("Date: " + date);
	if((date == null) || (date.equals(""))||(date.equals(" ")) ){}else{
		System.out.println("pumaosk");
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

//	parts = parts[1].split(",");
	day = parts[2];
	
	format = month + " " + day + ", "+ year;
	}
	return format;
}

	
	
	
}
