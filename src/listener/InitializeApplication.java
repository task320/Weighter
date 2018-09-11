package listener;

import java.util.Date;
import java.util.Formatter;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import util.Log4jLogger;

/**
 * Application Lifecycle Listener implementation class StartUP
 *
 */
@WebListener
public class InitializeApplication implements ServletContextListener {

	private  Log4jLogger logger =  Log4jLogger.getInstance();

    /**
     * Default constructor.
     */
    public InitializeApplication() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent arg0)  {
         // TODO Auto-generated method stub
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent arg0)  {
        //アプリケーションスタート
    	Date nowTime = new Date();
    	try(Formatter fm = new Formatter()){
    		fm.format("[%s]Application Start",nowTime.toString());
    		logger.InfoLog(fm.toString());
    	}

    }

}
