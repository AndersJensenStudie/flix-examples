package my.log4j.app;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class App {
    // Define the logger
    private static final Logger logger = LogManager.getLogger(App.class);

    public static void main(String[] args) {
        logger.info("Initializing application...");
        
        try {
            logger.debug("Doing some heavy lifting...");
            // Your logic here
        } catch (Exception e) {
            logger.error("Something went wrong!", e);
        }

        logger.info("Application finished successfully.");
    }
}