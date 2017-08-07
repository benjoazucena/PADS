package Models;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.json.JSONArray;

import Utilities.AccreditorSorter;

public class AccreditorDeck {
	
	private ArrayList<AccreditorCard> allCards = new ArrayList<AccreditorCard>();
	private ArrayList<AccreditorCard> dumpCards = new ArrayList<AccreditorCard>();
	private ArrayList<AccreditorCard> filteredCards = new ArrayList<AccreditorCard>();

	public AccreditorDeck(){
		
		
		
		
		
	}
	
	public JSONArray getAccList(int v1total, int v2total, int v3total, int v4total){
		JSONArray jArray = new JSONArray();
		
		
		double v1mean = v1total / filteredCards.size();
		double v2mean = v2total / filteredCards.size();
		double v3mean = v3total / filteredCards.size();
		double v4mean = v4total / filteredCards.size();

		//compute stdev
		
		double stdev1 = 0;double stdev2 = 0;double stdev3 = 0;double stdev4 = 0;
		AccreditorCard temp = new AccreditorCard();
		double sttotal1 = 0; double sttotal2 = 0; double sttotal3 = 0; double sttotal4 = 0; 
		for(int i = 0; i < filteredCards.size(); i++){
			temp = filteredCards.get(i);
			
			sttotal1 += Math.pow(temp.getV1() - v1mean, 2);
			sttotal2 += Math.pow(temp.getV2() - v2mean, 2);
			sttotal3 += Math.pow(temp.getV3() - v3mean, 2);
			sttotal4 += Math.pow(temp.getV4() - v4mean, 2);

		}
		
		stdev1 = Math.pow(sttotal1/filteredCards.size(), 0.5);
		stdev2 = Math.pow(sttotal2/filteredCards.size(), 0.5);
		stdev3 = Math.pow(sttotal3/filteredCards.size(), 0.5);
		stdev4 = Math.pow(sttotal4/filteredCards.size(), 0.5);
		
		//zscore
		for(int i = 0; i < filteredCards.size(); i++){
			temp = filteredCards.get(i);
			
			temp.setV1((temp.getV1() - v1mean) / stdev1);
			temp.setV2((temp.getV2() - v2mean) / stdev2);
			temp.setV3((temp.getV3() - v3mean) / stdev3);
			temp.setV4((temp.getV4() - v4mean) / stdev4);
			
			temp.setScore(Math.pow(Math.pow(temp.getV1(), 2) + Math.pow(temp.getV2(), 2) + Math.pow(temp.getV3(), 2) + Math.pow(temp.getV4(), 2), 0.5));
		}
		
		
		List<AccreditorCard> accList = filteredCards;
		Collections.sort(accList, new AccreditorSorter());
		
		//convert to json
		
		return jArray;
	}

	public ArrayList<AccreditorCard> getAllCards() {
		return allCards;
	}

	public void setAllCards(ArrayList<AccreditorCard> allCards) {
		this.allCards = allCards;
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
	//insert computational functions
	
}
