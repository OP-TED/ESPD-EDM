package sembu.utils.xml;

import org.xml.sax.SAXException;

import javax.xml.XMLConstants;
import javax.xml.transform.Source;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;
import java.io.File;
import java.io.IOException;

public class XSDTransformer {

	/**
	 * Method to validate a XML against {@param: xmlFilename} a XSD model {@param: xsdFilename}
	 *
	 * @param xsdFilename - Path and name of the XSD model
	 * @param xmlFilename - Path and name of the XML model
	 *
	 * @return String - Result of the validation
	 */
	public static String XSDValidation(boolean isServlet, String xsdFilename, String xmlFilename) {
		String result = null;

		//Construct a StreamSource from a File.
		ClassLoader loader = XSDTransformer.class.getClassLoader();

		Source xmlFile = new StreamSource(new File(xmlFilename));

		//Validate the ESPD XML with the XSD model
		SchemaFactory schemaFactory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
		Schema schema = null;
		try {
			if (isServlet) {
				schema = schemaFactory.newSchema(loader.getResource(xsdFilename));
				//schema = schemaFactory.newSchema(xsdSource);
			} else {
				schema = schemaFactory.newSchema(loader.getResource(xsdFilename));
			}

			Validator validator = schema.newValidator();
			validator.validate(xmlFile);

		} catch (SAXException e) {
			System.out.println(e.getLocalizedMessage());

		} catch (IOException e) {
			System.out.println(e.getLocalizedMessage());
		}

		return result;
	}
}
