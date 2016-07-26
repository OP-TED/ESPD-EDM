package espd.app.validation;

public class RequestValidation extends CommonValidation {
	/**
	 * Constructor method
	 *
	 * @param path        - path and file name of the XSD model
	 * @param xmlFilename - path and file name of the XML
	 * @param output      - path of the output folder
	 */
	public RequestValidation(String path, String xmlFilename, String output) {
		super();

		this.path = path;
		this.XMLPath = xmlFilename;
		this.outputPath = output;
	}

	/**
	 * Method that validates the XML sample
	 *
	 * @return boolean - whether the validation process has any error or not
	 */
	public boolean validationProcess() {
		boolean error = false;
		boolean isServlet = false;

		XSDPath = path + properties.getProperty("request_xsd_file");

		error = XSDValidation();

		//If there is any error during the XSD validation, the process is interrupted.
		if (!error) {
			validationExecution(path + properties.getProperty("request_path") + validationPath + properties
					.getProperty("validation_codes"));
			validationExecution(path + properties.getProperty("request_path") + validationPath + properties
					.getProperty("validation_cl_attrb"));
			validationExecution(path + properties.getProperty("request_path") + validationPath + properties
					.getProperty("validation_id_attrb"));
			validationExecution(path + properties.getProperty("request_path") + validationPath + properties
					.getProperty("validation_br"));

			//ClassLoader loader = RequestValidation.class.getClassLoader();
			//XSLTTransformer.executeXSLTTransformation(isServlet, XMLPath, path + properties.getProperty("request_path")+ validationPath + properties.getProperty("validation_br"), outputPath + properties.getProperty("upload_xml_path"));
		}
		toHTML();

		return error;
	}
}
