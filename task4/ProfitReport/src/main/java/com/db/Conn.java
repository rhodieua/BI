package com.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;

public class Conn {
	public static Connection conn;
	public static PreparedStatement ps;
	public static ResultSet rs;
	public static String sql;
	
	public static void connect() throws ClassNotFoundException, SQLException {
		
		conn = null;
		Class.forName("org.sqlite.JDBC");
		conn = DriverManager.getConnection("jdbc:sqlite:db2.db");
		
	}
	
	public static void close() throws ClassNotFoundException, SQLException {

		conn.close();
	
	}
	
	public static void readDB(String param, String... clause) throws ClassNotFoundException, SQLException {
		
		sql = 
			"SELECT ";
		if ("2".equals(param)) sql += " strftime('%m', SaleDate) AS ByMonth, "; // 2
		sql +=	
			" ProductID, " +
			" SUM(Profit) AS Profit " +
			"FROM ( " +
			" SELECT " +
			"  s.SaleDate, " +
			"  s.ProductID, " +
			"  s.Price, " +
			"  s.Quantity, " +
			"  MAX(p.NewPercentDate) AS RateDate, " +
			"  p.Rate, " +
			"  s.Price*s.Quantity*p.Rate AS Profit " +
			" FROM Sales s, Percent p " +
			" WHERE s.ProductID=p.ProductID " +
			" AND s.SaleDate>=p.NewPercentDate " +
	 		" GROUP BY " +
			"  s.SaleDate, " +
			"  s.ProductID, " +
			"  s.Price, " +
			"  s.Quantity " +
			") ";
		if ("1".equals(param))
			sql += 
			"WHERE SaleDate >= ? " + // 1
			"AND SaleDate <= ? " +   // 1
			"GROUP BY ProductID ";   // 1
		else
			sql += 
			"GROUP BY strftime('%m', SaleDate), ProductID " + // 2
			"HAVING SUM(Quantity) = ?"; // 2
			
		ps = conn.prepareStatement(sql);
		if ("1".equals(param)) {
			ps.setString(1, clause[0]);
			ps.setString(2, clause[1]);
		} else 
			ps.setInt(1, Integer.parseInt(clause[0]));
		
		rs = ps.executeQuery();
		
		String header = ("1".equals(param)) 
			? String.format("%1$10s|%2$10s", "ProductID", "Profit") 
			: String.format("%1$5s|%2$10s|%3$10s", "Month", "ProductID", "Profit"); 
		System.out.println(header);
		
		while (rs.next()) {
			String out = ("1".equals(param)) 
				? String.format("%1$10d|%2$10.2f", rs.getInt("ProductID"), rs.getDouble("Profit")) 
				: String.format("%1$5s|%2$10d|%3$10.2f", 
					rs.getString("ByMonth"), rs.getInt("ProductID"), rs.getFloat("Profit")); 
			System.out.println(out);		
		}
	}
	
}