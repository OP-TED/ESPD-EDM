package espd.app;

import sembu.utils.config.Arguments;
import sembu.utils.config.PropertiesManager;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.net.URL;

public class ESPDValidation {
	private static final String CONFIG_FILE = "local.config.properties";
	private static final String SERVLET_CONFIG_FILE = "config.properties";

	private static String xmlPathName;
	private static String currentPath;
	private static PropertiesManager properties;

	public static void main(String[] args) {
		initArgs(args);
		init(false);

		//Schematron life-cycle
		Upload upload = new Upload("", properties.getProperty("upload_path"), properties.getProperty("upload_xml_path"),
				properties.getProperty("upload_html_path"));

		if (upload.fileJARDetection(xmlPathName)) {
			System.out.println(upload.getUploadFolder());
			@SuppressWarnings("unused")
			int resultType = -1;

			if (upload.isXML()) {
				resultType = upload.XMLValidation("", properties);
			} else {
				resultType = upload.XMLSValidation("", properties);
			}
		}
	}

	private static void initArgs(String[] args) {
		Arguments argClass = new Arguments();
		argClass.parseArguments(args);
		xmlPathName = argClass.getXmlFilePath();
	}

	private static void init(boolean isServlet) {
		URL localPath = ESPDValidation.class.getProtectionDomain().getCodeSource().getLocation();
		currentPath = localPath.getFile();

		ClassLoader loader = ESPDValidation.class.getClassLoader();

		System.out.println("--- File path: " + currentPath);

		properties = new PropertiesManager();
		try {
			if (!isServlet)
				properties.initProperties(loader.getResource(CONFIG_FILE).openStream());
			else
				properties.initProperties(loader.getResource(SERVLET_CONFIG_FILE).openStream());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public String servletMain(HttpServletRequest request, String path) {
		init(true);

		String htmlError = "/errorType.html";

		Upload upload = new Upload(path, properties.getProperty("upload_path"),
				properties.getProperty("upload_xml_path"), properties.getProperty("upload_html_path"));
		if (upload.fileDetection(request)) {
			int resultType = 0;
			if (upload.isXML()) {
				resultType = upload.XMLValidation("", properties);
			} else {
				resultType = upload.XMLSValidation("", properties);
			}

			//Result process
			if (resultType >= 0) {

				switch (resultType) {
				case 1:
					htmlError = "/errorType.html";
					break;
				case 2:
					htmlError = "/" + upload.getUploadFolder() + "/report.html";
					break;
				case 3:
					htmlError = "/" + upload.getUploadFolder() + "/report.html";
					break;
				default:
					htmlError = "/welcome.html";
					break;
				}
			}
		}

		return htmlError;
	}
}
