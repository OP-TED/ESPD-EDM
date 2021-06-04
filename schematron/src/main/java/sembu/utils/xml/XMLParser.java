package sembu.utils.xml;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;

/**
 * 
 * @author mfontsan
 *
 */
public class XMLParser {
	public enum ESPDModel {
	    Request, Response 
	}

	/**
	 * Returns the ESPD model that it is being processed.
	 * @param xmlFilePath - path of the XML file
	 * @return String - ESPD type: Request (Root: ESPDRequest) or Response (Root: ESPDResponse)
	 */
	public String getESPDModel(String xmlFilePath){
		String ESPDType = "";
		
		try {
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder documentBuilder = dbf.newDocumentBuilder();
			Document doc = documentBuilder.parse(xmlFilePath); 
			
			//Root element of the XML file
	        Element  element = doc.getDocumentElement(); 
	        
	        switch(element.getNodeName()){
		        case "espd-req:ESPDRequest":
		        	ESPDType = ESPDModel.Request.toString(); 
		        	break;
		        case "espd:ESPDResponse":
		        	ESPDType = ESPDModel.Response.toString();
		        	break;
		        default:
		        	ESPDType = "";
		        	break;
	        }

		} catch (ParserConfigurationException e) {
			System.out.println(e.getLocalizedMessage());
		} catch (SAXException e) {
			System.out.println(e.getLocalizedMessage());
		} catch (IOException e) {
			System.out.println(e.getLocalizedMessage());
		}
		
		return ESPDType;
	}
}
