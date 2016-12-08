package csf.project.whatsapp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class App{
	
	private String findContactNamebyID(Statement wa_stat, String id){	
		try{
			ResultSet rs = wa_stat.executeQuery("select * from wa_contacts");
			while(rs.next()){
				if(rs.getString("jid").equals(id)){
					System.out.println("Name: " + rs.getString("display_name"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
    public static void main( String[] args ){
        System.out.println("[DEBUG] Application is starting...");
        System.out.println("[DEBUG] Ready to extract messages from databases");
        App app = new App();
        try {
			Class.forName("org.sqlite.JDBC");
	        System.out.println("[DEBUG] Connectiong to databases...");
			Connection msg_conn = DriverManager.getConnection("jdbc:sqlite:src/main/resources/msgstore.db");
			Connection wa_conn = DriverManager.getConnection("jdbc:sqlite:src/main/resources/wa.db");
			
			Statement wa_stat = wa_conn.createStatement();
			Statement msg_stat = msg_conn.createStatement();
					
			ResultSet msg_rs = msg_stat.executeQuery("select * from messages;");
			
			System.out.println("-------------------------");
			
			while(msg_rs.next()){
				System.out.println("-------------------------");
				String id = msg_rs.getString("key_remote_jid");
				System.out.println("Remote ID: " + id);
				app.findContactNamebyID(wa_stat, id);
				System.out.println("Message: " + msg_rs.getString("data"));
				System.out.println("-------------------------");
			}
			System.out.println("-------------------------");
		} catch (ClassNotFoundException e) {
			System.err.println("[ERROR] Failed to load JDBC class");
			e.printStackTrace();
		} catch (SQLException e) {
			System.err.println("[ERROR] Failed to connect to database");
			e.printStackTrace();
		}
        
    }
}
