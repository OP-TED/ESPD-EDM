package espd.app.validation;

import sembu.utils.config.PropertiesManager;
import sembu.utils.xml.XSDTransformer;
import sembu.utils.xml.XSLTTransformer;

import java.io.InputStream;

public class CommonValidation {
	protected String XSDPath;
	protected String XMLPath;
	protected String outputPath;
	protected String validationPath;
	protected String path;
	protected boolean isServlet;
	protected PropertiesManager properties;

	/**
	 * Constructor
	 */
	public CommonValidation() {
		System.setProperty("javax.xml.transform.TransformerFactory", "net.sf.saxon.TransformerFactoryImpl");
	}

	public void setXMLPath(String xmlPath) {
		this.XMLPath = xmlPath;
	}

	public PropertiesManager getProperties() {
		return properties;
	}

	public void setProperties(PropertiesManager properties) {
		this.properties = properties;
		validationPath = properties.getProperty("validation_path");
		if (properties.getProperty("environment").equals("jar")) {
			isServlet = false;
		} else {
			isServlet = true;
		}

	}

	/**
	 * Method that calls XSDTransformer.XSDValidation, and manages the result.
	 *
	 *
	 * @return String - Result of the validation
	 */
	protected boolean XSDValidation() {
		boolean error = true;

		String result = XSDTransformer.XSDValidation(isServlet, XSDPath, XMLPath);

		if (result == null) {
			error = false;
			Report.createReport(outputPath + properties.getProperty("upload_xml_path"), XMLPath + " is valid", error);
		} else {
			error = true;
			Report.createReport(outputPath + properties.getProperty("upload_xml_path"), result, error);
		}

		return error;
	}

	/**
	 * Method that calls all functions to do the common validation process.
	 */
	/*public void commonValidationProcess(){

	}*/

	/**
	 * Method that gets the XSL-T to transform the XML reports to HTML.
	 */
	protected void toHTML() {
		String xsltFile = path + properties.getProperty("xml_to_html_path");
		System.out.println("- Path: " + path);
		System.out.println("- Validation path: " + validationPath);
		System.out.println("- final: " + xsltFile);

		Report.generateHTMLReports(isServlet, outputPath, xsltFile, properties.getProperty("upload_xml_path"),
				properties.getProperty("upload_html_path"));
	}

	/**
	 * Method to validate the existence of both ESPDRequest and ESPDResponse XSD files.
	 *
	 * @param path - string
	 *
	 * @return boolean
	 */
	public boolean xsdExistence(String path) {
		boolean exist = false;

		exist = fileExistence(path);

		return exist;
	}

	/**
	 * Method to validate that the file exists.
	 *
	 * @param fileName - name of the file
	 *
	 * @return boolean - whether the file exist or not
	 */
	private boolean fileExistence(String fileName) {
		boolean exist = false;

		InputStream is = CommonValidation.class.getClassLoader().getResourceAsStream(fileName);

		if (is != null) {
			exist = true;
		}
		/*File file = new File(fileName);
		if(file.exists() && file.isFile()){
			exist = true;
		}*/

		return exist;
	}

	/**
	 * Method that gets the XSL-T transformation property (validation_ESPDResponse_br) to validate
	 * business rules of Response model.
	 */
	public void validationExecution(String xsltFile) {
		XSLTTransformer.executeXSLTTransformation(isServlet, XMLPath, xsltFile,
				outputPath + properties.getProperty("upload_xml_path"));
	}
}
