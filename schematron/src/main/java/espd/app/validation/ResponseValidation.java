package espd.app.validation;

public class ResponseValidation extends CommonValidation {

	/**
	 * Constructor method
	 *
	 * @param path        - path and file name of the XSD model
	 * @param xmlFilename - path and file name of the XML
	 * @param output      - path of the output folder
	 */
	public ResponseValidation(String path, String xmlFilename, String output) {
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

		XSDPath = path + properties.getProperty("response_xsd_file");

		error = XSDValidation();

		//If there is any error during the XSD validation, the process is interrupted.
		if (!error) {
			validationExecution(path + properties.getProperty("response_path") + validationPath + properties
					.getProperty("validation_codes"));
			validationExecution(path + properties.getProperty("response_path") + validationPath + properties
					.getProperty("validation_cl_attrb"));
			validationExecution(path + properties.getProperty("response_path") + validationPath + properties
					.getProperty("validation_id_attrb"));
			validationExecution(path + properties.getProperty("response_path") + validationPath + properties
					.getProperty("validation_br"));
			validationExecution(path + properties.getProperty("response_path") + validationPath + properties
					.getProperty("validation_spec_br"));
		}
		toHTML();

		return error;
	}
}
