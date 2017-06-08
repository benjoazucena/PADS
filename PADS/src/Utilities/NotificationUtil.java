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
	
	public void generateNotif(String content, String type){
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
			System.out.println("Error in AccreditorUtil:getAccreditors()");
			e.printStackTrace();
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
			System.out.println(content+" CONTENT OF EXPIRATION NOTIF");
			generateNotif(content,"Expirations");
		}
	}

	
	public void checkUnconfirmedSurveys(){
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		int curDate = Integer.parseInt(dateFormat.format(date).toString().replace("-", ""));
		
		try{
			Connection conn = db.getConnection();
			//SQL statement that checks if the current date is greater than the date of validity of a program's latest accreditation
			PreparedStatement ps = conn.prepareStatement("SELECT `surveyID` , `end_date` FROM `surveys");
			ResultSet rs = ps.executeQuery();
			ArrayList<Integer> surveyIDList = new ArrayList<Integer>();
			ArrayList<String> endDateList = new ArrayList<String>();
			while(rs.next()){
				int end_dateINT = Integer.parseInt(rs.getString(2).replace("-",""));
				if(curDate-end_dateINT > 0){
					surveyIDList.add(rs.getInt(1));
					endDateList.add(rs.getString(2));
				}
			}
			generateUnconfirmedNotifs(surveyIDList, endDateList);
			
		} catch (Exception e){
				System.out.println("DUplicate Copy of Notification");
			}
	}
	
	private ArrayList<Integer> filterUnconfirmedSurveys(ArrayList<Integer> surveyIDList, ArrayList<String> endDateList){
		ArrayList<Integer> filteredSurveys = new ArrayList<Integer>();
		 
		try{
			Connection conn = db.getConnection();
			//SQL statement that checks if the current date is greater than the date of validity of a program's latest accreditation
			PreparedStatement ps = conn.prepareStatement("SELECT `surveyID`,`SPID` ,`survey_type` FROM `program_survey` WHERE `currentDecisionBy` = ?");
			ps.setString(1,"None" );
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				for(int i = 0; i<surveyIDList.size(); i++){
					if(rs.getInt(1)==surveyIDList.get(i)){
						
					}
				}
			}
			
//			name = rs.getString(1);
//			institutionID = rs.getInt(2);
//			
//			ps = conn.prepareStatement("SELECT `name` FROM `institutions` WHERE `institutionID` = ?");
//			ps.setInt(1, institutionID);
//			rs = ps.executeQuery();
//			rs.next();
//			name = name + " - " + rs.getString(1);
//			
		} catch (Exception e){
				System.out.println("Error in AccreditorUtil:getAccreditors()");
				e.printStackTrace();
			}
		
		return filteredSurveys;
		
	}
	
	private void generateUnconfirmedNotifs(ArrayList<Integer> surveyIDList, ArrayList<String> endDateList){
		filterUnconfirmedSurveys(surveyIDList, endDateList);
		for(int i = 0; i<surveyIDList.size(); i++){
//			String content = getContentNames(surveyID.get(i)) + " : Valid Until "+ validityList.get(i);
//			System.out.println(content+" CONTENT OF EXPIRATION NOTIF");
//			generateNotif(content,"Expirations");
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
			name = name + " - " + rs.getString(1);
			
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

	
	
	
}
