package com.common;

import java.io.OutputStream;
import java.io.PrintStream;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

    
public class DisableSysoutServlet implements ServletContextListener{       
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext servletContext = sce.getServletContext();
        String disableSysoutParam = servletContext.getInitParameter("disableSysout");
        System.out.println("Context Param:"+disableSysoutParam);
            
        if(Boolean.parseBoolean(disableSysoutParam)) {
            // Create a dummy PrintStream that discards the output
            PrintStream dummyStream = new PrintStream(new OutputStream() {
                public void write(int b) {
                    // Do nothing
                }    
            }); 
    
            // Store the original System.out
            PrintStream originalOut = System.out;

            // Set System.out to the dummy stream
            System.setOut(dummyStream);  

            // Store the original System.err
            PrintStream originalErr = System.err;

            // Set System.err to the dummy stream
            //System.setErr(dummyStream);

            // Register a shutdown hook to restore the original System.out and System.err
            /*Runtime.getRuntime().addShutdownHook(new Thread(() -> {
                System.setOut(originalOut);
                System.setErr(originalErr);
            }));*/
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Code to be executed on application shutdown
    }
}
