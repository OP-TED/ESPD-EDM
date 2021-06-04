package sembu.utils.file;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.io.FilenameUtils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

public class FileManager {
	private String reports_xml_folder;
	private String reports_html_folder;

	private String separator;    //It depends on mode {servlet or JAR}

	private String uploadParentPath;    //Upload parent folder path

	private ArrayList<String> foldersPaths;    //Folder more than one file

	private ArrayList<String> filenames;    //Filename more than one file

	/**
	 * Constructor
	 *
	 * @param isServlet - Whether is a servlet or not
	 */
	public FileManager(boolean isServlet) {
		super();

		if (isServlet) {
			separator = "\\";
		} else {
			separator = "/";
		}

		this.foldersPaths = new ArrayList<String>();
		this.filenames = new ArrayList<String>();
	}

	/**
	 * Setter of the parent path (not including the time path)
	 *
	 * @param path - upload path of the files.
	 */
	public void setUploadParentPath(String path) {
		this.uploadParentPath = path;
	}

	/**
	 * Getter of the parent path (not including the time path)
	 *
	 * @return String
	 */
	public String getUploadParentPath() {
		return this.uploadParentPath;
	}

	/**
	 * Setter of the folder names
	 *
	 * @param path - folder names
	 */
	public void setFoldersPaths(String path) {
		this.foldersPaths.add(path);
	}

	/**
	 * Get a folder name
	 *
	 * @param i - number of the folder obtained
	 *
	 * @return String
	 */
	public String getFolderPath(int i) {
		return this.foldersPaths.get(i);
	}

	/**
	 * Get the whole folder path object
	 *
	 * @return ArrayList<String>
	 */
	public ArrayList<String> getFoldersPaths() {
		return this.foldersPaths;
	}

	/**
	 * Setter of a name of a file
	 *
	 * @param filename - name of a file
	 */
	public void setFilenames(String filename) {
		this.filenames.add(filename);
	}

	/**
	 * Getter of the number of filenames stored in the filenames object
	 *
	 * @return int
	 */
	public int numberFilenames() {
		return this.filenames.size();
	}

	/**
	 * Get the file name in the @param num
	 *
	 * @param num
	 *
	 * @return
	 */
	public String getFilename(int num) {
		return this.filenames.get(num);
	}

	/**
	 * Getter of the full path with the filename
	 *
	 * @return String
	 */
	public String getFullPathFilename(int number) {
		if (numberFilenames() > number && number >= 0) {
			return getUploadParentPath() + getFolderPath(number) + getFilename(number);
		}

		return null;
	}

	/**
	 * Getter of the full path (no filename included)
	 *
	 * @param number
	 *
	 * @return String
	 */
	public String getFullPath(int number) {
		if (this.foldersPaths.size() > number && number >= 0) {
			return getUploadParentPath() + getFolderPath(number);
		}

		return null;
	}

	/**
	 * Creates the folder send by parameter (if not exist or it is not a directory)
	 *
	 * @param rootPath - path
	 */
	public void createFolder(String rootPath) {
		boolean exist = Files.exists(Paths.get(rootPath));
		boolean isDirectory = Files.isDirectory(Paths.get(rootPath));

		if (!exist || !isDirectory) {
			new File(rootPath).mkdirs();
		}
	}

	/**
	 * Creates the output folder structure.
	 * Each uploaded file has a folder.
	 *
	 * @param root        - Root path
	 * @param folder      - name of the folder
	 * @param xml_folder  - folder to store XMLs
	 * @param html_folder - folder to store HTMLs
	 */
	public void createFolderStructure(String root, String folder, String xml_folder, String html_folder) {
		//Variables
		Date now = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd_hhmmss");
		String pathTime = folder + dateFormat.format(now) + separator;

		//Folders
		reports_xml_folder = xml_folder;
		reports_html_folder = html_folder;

		//Create main folder
		createFolder(root + pathTime);

		//Upload the variables
		setUploadParentPath(root);
		setFoldersPaths(pathTime);
	}

	/**
	 * Method that saves the file into the server.
	 *
	 * @param fileItem - file from the form to be uploaded.
	 *
	 * @return boolean - Whether the file has been saved or not.
	 *
	 * @throws Exception
	 */
	public boolean saveUploadedFile(FileItem fileItem) throws Exception {
		boolean isFileSave = false;
		boolean isFormField = fileItem.isFormField();

		if (!isFormField) {
			//Get the uploaded file parameters
			String currentFileName = fileItem.getName();
			setFilenames(currentFileName);

			if (!currentFileName.isEmpty()) {
				File file = new File(getFullPathFilename(0));
				fileItem.write(file);

				createFolder(getFullPath(0) + reports_xml_folder);
				if (separator.equals("\\")) {
					createFolder(getFullPath(0) + reports_html_folder);
				}

				isFileSave = true;
			}
		}

		return isFileSave;
	}

	/**
	 * Method that save the file into the folder (JAR process)
	 *
	 * @param xmlName - name of the XML to be validated
	 *
	 * @return boolean
	 *
	 * @throws Exception
	 */
	public boolean saveUploadedFile(String xmlName) throws Exception {
		boolean isFileSave = false;

		//Copy the filename into the folder
		File fileXMLInput = new File(xmlName);
		File file = new File(getFullPath(0) + fileXMLInput.getName());
		Files.copy(fileXMLInput.toPath(), file.toPath());

		if (file.exists()) {
			setFilenames(fileXMLInput.getName());

			//Create the folder structure
			createFolder(getFullPath(0) + reports_xml_folder);
			if (separator.equals("\\")) {
				createFolder(getFullPath(0) + reports_html_folder);
			}

			isFileSave = true;
		}

		return isFileSave;
	}

	/**
	 * Method that saves the ZIP files into the server.
	 *
	 * @param fileItem - file from the form to be uploaded.
	 *
	 * @return boolean
	 *
	 * @throws Exception
	 */
	public boolean saveUploadedZip(FileItem fileItem, String zipName, boolean isJar) throws Exception {
		boolean isZipSave = false;
		byte[] buffer = new byte[1024];

		//Name of the ZIP file
		if (!isJar) {
			zipName = fileItem.getName();
		}
		setFilenames(zipName);

		if (!zipName.isEmpty()) {
			//Save the ZIP file into the folder created
			File zipFile;

			if (!isJar) {
				zipFile = new File(getFullPath(0) + zipName);
				fileItem.write(zipFile);
			} else {
				zipFile = new File(zipName);
			}

			//Open ZIP file
			ZipInputStream zis = new ZipInputStream(new FileInputStream(zipFile));
			ZipEntry ze = zis.getNextEntry();

			//For each file in the ZIP
			while (ze != null) {
				String fileName = ze.getName();    //Name of the file inside the ZIP
				String folder = getFullPath(0) + FilenameUtils.removeExtension(fileName) + this.separator;

				createFolder(folder);    //Create folder with the name of the file
				createFolder(folder + reports_xml_folder); //Subfolders
				createFolder(folder + reports_html_folder); //Subfolders

				setFoldersPaths(getFolderPath(0) + FilenameUtils.removeExtension(fileName) + this.separator);

				setFilenames(fileName);

				//Save the file within the ZIP into the folder
				FileOutputStream fos = new FileOutputStream(folder + fileName);

				int len;
				while ((len = zis.read(buffer)) > 0) {
					fos.write(buffer, 0, len);
				}

				fos.close();
				ze = zis.getNextEntry();
			}

			zis.closeEntry();
			zis.close();

			isZipSave = true;
		}

		return isZipSave;
	}
}
