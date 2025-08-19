package com.limousine.autoemail;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Timer;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.connection.ClsConnection;
import com.emailsmsautogenerate.EmailSmsAutoAction;

public class AutoEmailContextListner implements ServletContextListener {

	private ScheduledExecutorService scheduler;
	private static long FOUR_HOURS;
	
	@Override
	public void contextInitialized(ServletContextEvent event) {

		ClsConnection ClsConnection=new ClsConnection();
		Connection conn = ClsConnection.getMyConnection();
		try {
			 Statement stmt = conn.createStatement();
			 int interval=0;
			 String sql= "select coalesce(`interval`,0) `interval` from gl_prjemail where status=3 and dtype='LBK'";
			 ResultSet rs = stmt.executeQuery(sql);
			 if(rs.next()) {
				 interval=rs.getInt("interval");
			 }
			 FOUR_HOURS=interval*60*60;
			 if (scheduler == null || scheduler.isShutdown()) {
			 scheduler = Executors.newSingleThreadScheduledExecutor();
		     scheduler.scheduleAtFixedRate(new AutoEmail(), 0, FOUR_HOURS, TimeUnit.SECONDS);
			 }
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public void contextDestroyed(ServletContextEvent event) {
		if (scheduler != null && !scheduler.isShutdown()) {
            scheduler.shutdown();
            try {
                if (!scheduler.awaitTermination(10, TimeUnit.SECONDS)) {
                    scheduler.shutdownNow();
                }
            } catch (InterruptedException e) {
                scheduler.shutdownNow();
                Thread.currentThread().interrupt();
            }
        }
	}
	
	

}
