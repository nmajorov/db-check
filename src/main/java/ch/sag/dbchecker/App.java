package ch.sag.dbchecker;

import java.sql.*;
/**
 * Hello world!
 *
 */
public class App 
{
    public void connect(String driver,String url, String username,String password) throws SQLException, ClassNotFoundException{
    	Class.forName(driver);
        Connection  connection = DriverManager.getConnection(url,username,password);
    	String databaseName= connection.getMetaData().getDatabaseProductName();
    	int databaseVersion =connection.getMetaData().getDatabaseMajorVersion();    		      
    	System.out.println("database name: " +databaseName + 
    			" version: " + databaseVersion);
    }
}
