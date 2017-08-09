package Models;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import Utilities.AccreditorSorter;

public class AccreditorDeck {
	
	private ArrayList<AccreditorCard> priorityCards = new ArrayList<AccreditorCard>();
	private ArrayList<AccreditorCard> dumpCards = new ArrayList<AccreditorCard>();
	private ArrayList<AccreditorCard> filteredCards = new ArrayList<AccreditorCard>();

	public AccreditorDeck(){
		
		
		
		
		
	}
	
	public JSONArray getAccList(double v1total, double v2total, double v3total){
		JSONArray jArray = new JSONArray();
		
		System.out.println("V1Total:"+v1total+", V2TOTAL:"+ v2total+", V3TOTAL:" +v3total);
		int numberOfCards = filteredCards.size() + priorityCards.size();
		double v1mean = v1total / numberOfCards;
		double v2mean = v2total / numberOfCards;
		double v3mean = v3total / numberOfCards;
		System.out.println("V1mean:"+v1mean+", V2mean:"+ v2mean+", V3mean:" +v3mean);

		//compute stdev
		
		double stdev1 = 0;double stdev2 = 0;double stdev3 = 0;
		AccreditorCard temp = new AccreditorCard();
		double sttotal1 = 0; double sttotal2 = 0; double sttotal3 = 0; 
		for(int i = 0; i < filteredCards.size(); i++){
			temp = filteredCards.get(i);
			
			sttotal1 += Math.pow(temp.getV1() - v1mean, 2);
			sttotal2 += Math.pow(temp.getV2() - v2mean, 2);
			sttotal3 += Math.pow(temp.getV3() - v3mean, 2);
			

		}
		
		for(int i = 0; i < priorityCards.size(); i++){
			temp = priorityCards.get(i);
			
			sttotal1 += Math.pow(temp.getV1() - v1mean, 2);
			sttotal2 += Math.pow(temp.getV2() - v2mean, 2);
			sttotal3 += Math.pow(temp.getV3() - v3mean, 2);
			

		}
		
		stdev1 = Math.pow(sttotal1/numberOfCards, 0.5);
		stdev2 = Math.pow(sttotal2/numberOfCards, 0.5);
		stdev3 = Math.pow(sttotal3/numberOfCards, 0.5);
		System.out.println("V1SD:"+stdev1+", V2SD:"+ stdev2+", V3SD:" +stdev3);
		
		//zscore
		for(int i = 0; i < filteredCards.size(); i++){
			temp = filteredCards.get(i);
			
			temp.setV1((temp.getV1() - v1mean) / stdev1);
			temp.setV2((temp.getV2() - v2mean) / stdev2);
			temp.setV3((temp.getV3() - v3mean) / stdev3);
	
			
			temp.setScore(temp.getV1()+temp.getV2()+temp.getV3());
			System.out.println(temp.getAccreditorName() + " : " + temp.getScore()  + " : " + temp.getV1() + " : " + temp.getV2()  + " : " + temp.getV3()  );

		}
		
		for(int i = 0; i < priorityCards.size(); i++){
			temp = priorityCards.get(i);
			
			temp.setV1((temp.getV1() - v1mean) / stdev1);
			temp.setV2((temp.getV2() - v2mean) / stdev2);
			temp.setV3((temp.getV3() - v3mean) / stdev3);
	
			
			temp.setScore(temp.getV1()+temp.getV2()+temp.getV3());
			System.out.println(temp.getAccreditorName() + " : " + temp.getScore()  + " : " + temp.getV1() + " : " + temp.getV2()  + " : " + temp.getV3()  );
		}
		
		
		List<AccreditorCard> accList = filteredCards;
		List<AccreditorCard> priList = priorityCards;
		Collections.sort(accList, new AccreditorSorter());
		Collections.sort(priList, new AccreditorSorter());
		
		
		//set ranking
		
		for(int i = 0; i < priList.size(); i++){
			temp = priList.get(i);
			temp.setRank(i);
		}
		
		for(int i = 0; i < accList.size(); i++){
			temp = accList.get(i);
			temp.setRank(i + priList.size());
		}
		
		//build json
		JSONObject jTemp;
		for(int i = 0; i < priList.size(); i++){
			temp = priList.get(i);
			jTemp = new JSONObject();

			jTemp.put("accreditorName", temp.getAccreditorName());
			jTemp.put("primaryArea", temp.getPrimary());
			jTemp.put("secondaryArea", temp.getSecondary());
			jTemp.put("tertiaryArea", temp.getTertiary());
			jTemp.put("primaryAreaID", temp.getPrimaryID());
			jTemp.put("secondaryAreaID", temp.getSecondaryID());
			jTemp.put("tertiaryAreaID", temp.getTertiaryID());
			jTemp.put("city", temp.getCity());
			jTemp.put("discipline", temp.getDiscipline());
			jTemp.put("numberSurveys", temp.getNumberSurveys());
			jTemp.put("accreditorID", temp.getAccreditorID());
			jTemp.put("rank", i);
			jTemp.put("affiliation", temp.getAffiliation());
			jTemp.put("lastSurveyDate", temp.getLastSurveyDate());

			jArray.put(jTemp);
		}
		
		for(int i = 0; i < accList.size(); i++){
			temp = accList.get(i);
			jTemp = new JSONObject();

			jTemp.put("accreditorName", temp.getAccreditorName());
			jTemp.put("primaryArea", temp.getPrimary());
			jTemp.put("secondaryArea", temp.getSecondary());
			jTemp.put("tertiaryArea", temp.getTertiary());
			jTemp.put("primaryAreaID", temp.getPrimaryID());
			jTemp.put("secondaryAreaID", temp.getSecondaryID());
			jTemp.put("tertiaryAreaID", temp.getTertiaryID());
			jTemp.put("city", temp.getCity());
			jTemp.put("discipline", temp.getDiscipline());
			jTemp.put("numberSurveys", temp.getNumberSurveys());
			jTemp.put("accreditorID", temp.getAccreditorID());
			jTemp.put("rank", i + priList.size());
			jTemp.put("affiliation", temp.getAffiliation());
			jTemp.put("lastSurveyDate", temp.getLastSurveyDate());
			
			System.out.println("Score of " + temp.getAccreditorName() + " is " + temp.getScore());
		
			jArray.put(jTemp);
		}
		
		for(int i = 0; i < dumpCards.size(); i++){
			temp = dumpCards.get(i);
			jTemp = new JSONObject();

			jTemp.put("accreditorName", temp.getAccreditorName());
			jTemp.put("primaryArea", temp.getPrimary());
			jTemp.put("secondaryArea", temp.getSecondary());
			jTemp.put("tertiaryArea", temp.getTertiary());
			jTemp.put("primaryAreaID", temp.getPrimaryID());
			jTemp.put("secondaryAreaID", temp.getSecondaryID());
			jTemp.put("tertiaryAreaID", temp.getTertiaryID());
			jTemp.put("city", temp.getCity());
			jTemp.put("discipline", temp.getDiscipline());
			jTemp.put("numberSurveys", temp.getNumberSurveys());
			jTemp.put("accreditorID", temp.getAccreditorID());
			jTemp.put("rank", accList.size() + priList.size() + 1);
			jTemp.put("affiliation", temp.getAffiliation());
			jTemp.put("lastSurveyDate", temp.getLastSurveyDate());

			jArray.put(jTemp);
		}
		return jArray;
	}

	public ArrayList<AccreditorCard> getPriorityCards() {
		return priorityCards;
	}

	public void setPriorityCards(ArrayList<AccreditorCard> priorityCards) {
		this.priorityCards = priorityCards;
	}

	public ArrayList<AccreditorCard> getDumpCards() {
		return dumpCards;
	}

	public void setDumpCards(ArrayList<AccreditorCard> dumpCards) {
		this.dumpCards = dumpCards;
	}

	public ArrayList<AccreditorCard> getFilteredCards() {
		return filteredCards;
	}

	public void setFilteredCards(ArrayList<AccreditorCard> filteredCards) {
		this.filteredCards = filteredCards;
	}
	
	public void addCard_filtered(AccreditorCard ac){
		this.filteredCards.add(ac);
	}
	public void addCard_dump(AccreditorCard ac){
		this.dumpCards.add(ac);
	}
	public void addPriorityCard(AccreditorCard ac){
		this.priorityCards.add(ac);
	}
	//insert computational functions
	
}
