package com.db;

import java.sql.SQLException;

public class Run {
	
	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		
		System.out.println("Enter 1 for Task 1 (ReportStart/ReportEnd)");
		System.out.println("Enter 2 for Task 2 (Profit by month)");
		System.out.println("Enter anything else for quit");
			
		String input = System.console().readLine();

		if (!("1".equals(input) || "2".equals(input))) {
			System.exit(0);
		}
			
		enterParams(input);
	}
	
	public static void enterParams(String input) throws ClassNotFoundException, SQLException {
		
		if ("1".equals(input)) {
			System.out.println("Enter ReportStart (YYYY-MM-DD):");
			String reportStart = System.console().readLine();
				
			System.out.println("Enter ReportEnd (YYYY-MM-DD):");
			String reportEnd = System.console().readLine();
						
			sql("1", reportStart, reportEnd);
		} else {
			System.out.println("Enter Quantity:");
			String quantity = System.console().readLine();
				
			sql("2", quantity);
		}
	}
	
	public static void sql(String param, String... clause) throws ClassNotFoundException, SQLException {
		Conn.connect();
		Conn.readDB(param, clause);
		Conn.close();
	}
	
}