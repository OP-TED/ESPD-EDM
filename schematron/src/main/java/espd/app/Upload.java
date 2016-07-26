package espd.app;

import espd.app.validation.RequestValidation;
import espd.app.validation.ResponseValidation;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import sembu.utils.config.PropertiesManager;
import sembu.utils.file.FileManager;
import sembu.utils.xml.XMLParser;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Iterator;
import java.util.List;
import java.util.zip.ZipInputStream;

/**
 * Upload the XML file and validates that it's an XML and the model.
 *
 * @author mfontsan
 */
public class Upload {
	private int maxMemSize = 4 * 1024;
	private int maxFileSize = 50 * 1024 * 8;

	private boolean isXML;
	private ServletFileUpload upload;
	private FileManager fileManager;

	public boolean isXML() {
		return isXML;
	}

	public void setXML(boolean isXML) {
		this.isXML = isXML;
	}

	/**
	 * Upload class constructor
	 *
	 * @param uploadPath: path of the upload folder.
	 */
	public Upload(String realPath, String uploadPath, String xml_folder, String html_folder) {
		if (xml_folder.contains("\\")) {
			this.fileManager = new FileManager(true);
		} else {
			this.fileManager = new FileManager(false);
		}

		this.fileManager.createFolderStructure(realPath, uploadPath, xml_folder, html_folder);
	}

	/**
	 * Get all the folders
	 *
	 * @return String
	 */
	public String getUploadFolder() {
		return fileManager.getFolderPath(0);
	}

	/**
	 * Detection of the XML file (only for JARs)
	 *
	 * @param xmlPath
	 *
	 * @return boolean
	 */
	@SuppressWarnings("resource")
	public boolean fileJARDetection(String xmlPath) {
		try {
			if (isXMLFile(xmlPath)) {
				isXML = true;
				//It is stored if it is an XML file.
				return this.fileManager.saveUploadedFile(xmlPath);
			} else {
				File zipFile = new File(xmlPath);
				ZipInputStream zis = new ZipInputStream(new FileInputStream(zipFile));

				if (zis != null) {
					isXML = false;
					zis.close();

					return this.fileManager.saveUploadedZip(null, xmlPath, true);
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return false;
	}

	/**
	 * Method to store the file that the user wants to validate if it is an XML.
	 *
	 * @param request
	 */
	public boolean fileDetection(HttpServletRequest request) {
		initUploadManager();

		try {
			//Parse the request to get file items.
			List<FileItem> fields = upload.parseRequest(request);
			//TODO: Log - Number of fields
			System.out.println("Number of fields: " + fields.size() + "<br/><br/>");

			//Process the uploaded file items
			Iterator<FileItem> it = fields.iterator();
			if (!it.hasNext()) {
				//TODO: Log - No files have been uploaded.
				System.out.println("No files have been uploaded");
				return false;
			}

			while (it.hasNext()) {
				FileItem fileItem = it.next();
				if (!fileItem.isFormField()) {
					if (isXMLFile(fileItem.getName())) {
						//It is stored if it is an XML file.
						isXML = true;
						return this.fileManager.saveUploadedFile(fileItem);
					} else {
						if (fileItem.getContentType().equals("application/octet-stream")) {
							isXML = false;
							return this.fileManager.saveUploadedZip(fileItem, "", false);
						}
					}
				}
			}

		} catch (FileUploadException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	private int validationProcess(PropertiesManager properties, String path, String fileUploadPath, String uploadPath) {
		int resultType = -1;
		String ESPDType = modelDetection(fileUploadPath);

		if (ESPDType.equals("")) {
			resultType = 1;
		} else {
			boolean error = true;
			if (ESPDType.equals("Request")) {
				RequestValidation validation = new RequestValidation(path, fileUploadPath, uploadPath);
				validation.setProperties(properties);
				error = validation.validationProcess();
			}
			if (ESPDType.equals("Response")) {
				ResponseValidation validation = new ResponseValidation(path, fileUploadPath, uploadPath);
				validation.setProperties(properties);
				error = validation.validationProcess();
			}

			if (error) {
				resultType = 2;
			} else {
				resultType = 3;
			}
		}

		return resultType;
	}

	/**
	 * Method that manages the XML validation process.
	 *
	 * @param path       - Root path of the servlet
	 * @param properties - properties from the .properties file
	 *
	 * @return int - result type (-1 = validation correct; 1 = model of the XML incorrect; 2 = error during the validation process; 3 = no error during the validation process)
	 */
	public int XMLValidation(String path, PropertiesManager properties) {
		int resultType = -1;

		resultType = validationProcess(properties, path, fileManager.getFullPathFilename(0),
				fileManager.getFullPath(0));

		return resultType;
	}

	/**
	 * Method that manages more than one XML validation process.
	 *
	 * @param path       - Root path of the servlet
	 * @param properties - properties from the .properties file
	 *
	 * @return int - result type (-1 = validation correct; 1 = model of the XML incorrect; 2 = error during the validation process; 3 = no error during the validation process)
	 */
	public int XMLSValidation(String path, PropertiesManager properties) {
		int resultType = -1;

		for (int i = 1; i < fileManager.numberFilenames(); i++) {
			resultType = validationProcess(properties, path, fileManager.getFullPathFilename(i),
					fileManager.getFullPath(i));
		}
		//Report.joinHTMLTagReports(fileManager.getFoldersPaths(), fileManager.getUploadParentPath());
		return resultType;
	}

	/**
	 * Method that calls the XMLParser that detects the EFSA Type; if it does not belong to ESPDResponse or ESPDRequest, it returns NULL
	 *
	 * @return String or NULL
	 */
	public String modelDetection(String xmlPath) {
		XMLParser xmlParser = new XMLParser();

		String ESPDType = xmlParser.getESPDModel(xmlPath);

		System.out.println("Model detected: " + ESPDType);
		return ESPDType;
	}

	/**
	 * Initializes the file upload manager.
	 */
	private void initUploadManager() {
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(maxMemSize);    //Maximum size that will be stored in memory
		factory.setRepository(
				new File(this.fileManager.getFullPath(0)));    //Location to save data that is larger than maxMemSize.

		// Create a new file upload handler
		upload = new ServletFileUpload(factory);
		upload.setSizeMax(maxFileSize);    //Maximum file size to be uploaded.
	}

	/**
	 * Returns whether the file {@param xmlFile} is an XML or not.
	 *
	 * @param xmlFile - file to be processed
	 *
	 * @return boolean
	 */
	private boolean isXMLFile(String xmlFile) {
		try {
			String fileType = Files.probeContentType(Paths.get(xmlFile));
			if ("text/xml".equalsIgnoreCase(fileType) || "application/xml".equalsIgnoreCase(fileType)) {
				return true;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return false;
	}

}
