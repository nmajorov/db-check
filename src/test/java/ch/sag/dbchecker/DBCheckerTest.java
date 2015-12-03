package ch.sag.dbchecker;

import org.junit.Test;

import static org.junit.Assert.*;

public class DBCheckerTest {

	@Test
	public void testConnection() throws Exception{
		
		System.setProperty("DRIVER_CLASS", "org.hsqldb.jdbc.JDBCDriver");
		System.setProperty("DB_URL", "jdbc:hsqldb:mem:anam");
		System.setProperty("DB_USERNAME", "sa");
		DBChecker dbChecker = new DBChecker();
		
	}
	
	//@Test
	public void testPasswdAndConnection() throws Exception{
		
		System.setProperty("DRIVER_CLASS", "org.hsqldb.jdbc.JDBCDriver");
		System.setProperty("DB_URL", "jdbc:hsqldb:mem:anam");
		System.setProperty("DB_USERNAME", "sa");
		System.setProperty("DB_PASSWORD", "test");
		DBChecker dbChecker = new DBChecker();
		
	}
	

}
