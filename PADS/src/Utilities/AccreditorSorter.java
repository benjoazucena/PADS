package Utilities;

import java.util.Comparator;

import Models.AccreditorCard;

public class AccreditorSorter implements Comparator<AccreditorCard> {

	@Override
	public int compare(AccreditorCard arg0, AccreditorCard arg1) {
		// TODO Auto-generated method stub
		if(arg0.getScore() < arg1.getScore()) return 1;
		if(arg0.getScore() > arg1.getScore()) return -1;
		return 0;
	}

}