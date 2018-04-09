package ch.sag.dbchecker;

import org.junit.Test;

import static org.junit.Assert.*;

public class DBCheckerTest {

	@Test
	public void testConnection() throws Exception{
		
		System.setProperty("DRIVER_CLASS", "org.hsqldb.jdbc.JDBCDriver");
		System.setProperty("DB_URL", "jdbc:hsqldb:mem:anam");
		System.setProperty("DB_USERNAME", "sa");
		System.setProperty("MAX_TRY","3");
		DBChecker dbChecker = new DBChecker();
		
	}
	

	@Test
	public void testWrongMaxTry() throws Exception{
		
		System.setProperty("DRIVER_CLASS", "org.hsqldb.jdbc.JDBCDriver");
		System.setProperty("DB_URL", "jdbc:hsqldb:mem:anam");
		System.setProperty("DB_USERNAME", "sa");
		System.setProperty("DB_PASSWORD", "test");
		System.setProperty("MAX_TRY","1X");
		try {
			DBChecker dbChecker = new DBChecker();
		} catch (Exception e) {
			assertTrue(e.getMessage().contains("MAX_TRY should be an integer value"));
		}
		
		
				
	}


	//@Test
	public void testPasswdAndConnection() throws Exception{
		
		System.setProperty("DRIVER_CLASS", "org.hsqldb.jdbc.JDBCDriver");
		System.setProperty("DB_URL", "jdbc:hsqldb:mem:anam");
		System.setProperty("DB_USERNAME", "sa");
		System.setProperty("DB_PASSWORD", "test");
		System.setProperty("MAX_TRY","1");
		DBChecker dbChecker = new DBChecker();
		
	}
	

}
