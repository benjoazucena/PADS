package Models;

import java.util.ArrayList;

public class Program {
	

	private int programID;
	private String name;
	private int count;
	
	
	private ArrayList<SchoolProgram> sps;
	
	public Program(int programID, String name, int count) {
		super();
		this.programID = programID;
		this.name = name;
		this.count = count;
	}
	
	public Program(){
		
	}
	
	public ArrayList<SchoolProgram> getSps(){
		return sps;
	}
	
	public void setSps(ArrayList<SchoolProgram> sps){
		this.sps = sps;
	}
	public int getProgramID() {
		return programID;
	}

	public void setProgramID(int programID) {
		this.programID = programID;
	}
	
	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
