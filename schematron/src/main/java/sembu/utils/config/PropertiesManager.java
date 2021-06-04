package sembu.utils.config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class PropertiesManager {
	private Properties properties;
	
	/**
	 * Loads the properties file send via parameter
	 * @param configFile: properties file
	 * @return boolean: whether the file has been correctly loaded
	 */
	public boolean initProperties(InputStream configFile){
		boolean initCorrect = true;
		
	    //Loading properties file
	    properties = new Properties();
	    try {
	    	properties.load(configFile);
		} catch (IOException e) {
			initCorrect = false;
			//TODO: Add log
		}
	    
	    return initCorrect;
	}
	
	/**
	 * Get a property value.
	 * @param key: name of the property
	 * @return String: value of the property
	 */
	public String getProperty(String key){
		return properties.getProperty(key);
	}
}
