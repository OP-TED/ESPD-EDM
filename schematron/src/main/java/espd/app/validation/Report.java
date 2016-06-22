package espd.app.validation;

import sembu.utils.xml.XSLTTransformer;

import java.io.*;
import java.util.ArrayList;


public class Report {
	
	/**
	 * Method that gets all XML reports and execute the XSL-T to transform them into HTML files.
	 * @param outputPath - output folder path
	 * @param XSLTtoHTMLPath - path and name of the XSL-T to be executed
	 */
	public static void generateHTMLReports(boolean isServlet, String outputPath, String XSLTtoHTMLPath, String xml_folder, String html_folder){
		String outputXMLReports = outputPath + xml_folder;
		String outputHTMLReports = outputPath + html_folder;

		File folder = new File(outputPath + xml_folder);
		File[] listOfReports = folder.listFiles();

		for (int i = 0; i < listOfReports.length; i++) {
			if (listOfReports[i].isFile()) {
				XSLTTransformer.executeXSLTtoHTMLTransformation(isServlet, outputXMLReports+listOfReports[i].getName(), XSLTtoHTMLPath, outputHTMLReports+listOfReports[i].getName()+".html");
		    }
		}
		
		joinHTMLReports(outputPath, html_folder);
	}
	
	/**
	 * If there is more than one XML to be validated, it joins all the HTML reports in one.
	 * @param outputPath - output folder path
	 * @param parentPath - parent path
	 */
	public static void joinHTMLTagReports(ArrayList<String> outputPath, String parentPath){
				
		try {
			BufferedWriter outputFile = new BufferedWriter(new FileWriter(parentPath + outputPath.get(0) + "report.html"));
			outputFile.write("<html>");
			outputFile.write("<meta content=\"text/html;  charset=UTF-8\" http-equiv=\"Content-Type\">");
			outputFile.write("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">");
			outputFile.write("<link rel=\"stylesheet\" href=\"styles.css\">");
			outputFile.write("<link rel=\"stylesheet\" href=\"http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css\">");
			outputFile.write("<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js\"></script>");
			outputFile.write("<script src=\"http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js\"></script>");
			outputFile.write("<title>Report - Servlet upload</title>");
			outputFile.write("<body style=\"font-family:Arial;font-size:12pt;background-color:#EEEEEE\">");
			outputFile.newLine();

			outputFile.write("<div id=\"header\">");
			
			String tabs = "<div class=\"container\"><ul class=\"nav nav-pills\">";
				 
			String outputline = "<div class=\"tab-content\">";
			
			
			for(int i=1; i<outputPath.size(); i++){
				File folderReport = new File(outputPath.get(i) + "/report.html");
				BufferedReader htmlReport = new BufferedReader(new FileReader(parentPath + folderReport));
				String line = "";
				
				if(i==0){
					outputline = outputline + "<div id=\"" + i + "\" class=\"tab-pane fade in active\">";
					tabs = tabs + "<li class=\"active\"><a data-toggle=\"pill\" href=\"#" + i + "\">" + outputPath.get(i) + "</a></li>";
				}else{
					outputline = outputline + "<div id=\"" + i + "\" class=\"tab-pane fade\">";
					tabs = tabs + "<li><a data-toggle=\"pill\" href=\"#" + i + "\">" + outputPath.get(i) + "</a></li>";
				}
				while ((line = htmlReport.readLine()) != null) {
					outputline = outputline + line;
				}
				outputline = outputline + "</div>";
				htmlReport.close();
			}
			tabs = tabs + "</ul>";
			outputFile.write(tabs);
			outputFile.newLine();
			
			outputFile.write(outputline);
			outputFile.newLine();

			outputFile.write("</div></div>");
			outputFile.write("<div id=\"footer\">version ESPD: 1.0</div>");
			outputFile.write("</div>");
			outputFile.write("</body></meta></html>");
			
			outputFile.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * Method to join all HTML reports from one XML into one.
	 * @param outputPath
	 * @param html_folder
	 */
	private static void joinHTMLReports(String outputPath, String html_folder){
		File folderReport = new File(outputPath + html_folder);
		File[] listOfReports = folderReport.listFiles();
		
		try {
			BufferedWriter outputFile = new BufferedWriter(new FileWriter(outputPath + "report.html"));
			outputFile.write("<html>");
			outputFile.write("<meta content=\"text/html;  charset=UTF-8\" http-equiv=\"Content-Type\">");
			outputFile.write("<link rel=\"stylesheet\" href=\"styles.css\">");
			outputFile.write("<title>Report - Servlet upload</title>");
			outputFile.write("<body style=\"font-family:Arial;font-size:12pt;background-color:#EEEEEE\">");
			outputFile.newLine();

			outputFile.write("<div id=\"header\">");
			outputFile.write("<div id=\"logo\">");
			outputFile.write("<img height=\"110px\" align=\"middle\" src=\"img/COMlogo.png\">");
			outputFile.write("</div>");
			outputFile.write("<div id=\"title\"><h1>ESPD: Request / Response XML Validation</h1></div>");
			outputFile.write("<div id=\"section\"><p>Go to the upload page: <a href=upload.jsp>now</a></p></div>");
				 

			for(int i=0; i<listOfReports.length; i++){
				BufferedReader htmlReport = new BufferedReader(new FileReader(listOfReports[i]));
				String line = "";
				while ((line = htmlReport.readLine()) != null) {
					outputFile.write(line);
				}
				
				outputFile.newLine();
				htmlReport.close();
			}

			outputFile.write("<div id=\"footer\">version ESPD Request / Response: 1.0</div>");
			outputFile.write("</div>");
			outputFile.write("</body></meta></html>");
			
			outputFile.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * Method that creates the report XML based on ISO SVRL.
	 * @param outputPath - path where the report is saved
	 * @param message - message to be shown
	 * @param error - whether it is a report with the errors or a correct validationn
	 */
	public static void createReport(String outputPath, String message, boolean error){
		BufferedWriter outputFile = null;
		
		try {
			outputFile = new BufferedWriter(new FileWriter(outputPath + "0-XSD_Report.xml"));
			outputFile.write("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>");
			
			outputFile.write("<svrl:schematron-output xmlns:svrl=\"http://purl.oclc.org/dsdl/svrl\" xmlns:sch=\"http://www.ascc.net/xml/schematron\" xmlns:iso=\"http://purl.oclc.org/dsdl/schematron\" xmlns:hr=\"http://www.hr-xml.org/3\" xmlns:oa=\"http://www.openapplications.org/oagis/9\" title=\"Validation against XSD model\" schemaVersion=\"\">");
			outputFile.newLine();
			
			if(error){
				outputFile.write(createErrorTag(message));
				outputFile.newLine();
			}else{
				outputFile.write(createCorrectTag(message));
				outputFile.newLine();
			}
			
			outputFile.write("</svrl:schematron-output>");
			
			outputFile.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * Method that creates the node to the report for errors.
	 * @param message - message to be show
	 * @return String - node with the message
	 */
	private static String createErrorTag(String message){
		String xmlTag = "";
		
		xmlTag = "<svrl:failed-assert>";
		xmlTag = xmlTag + "<svrl:text>"+message+"</svrl:text>";
		xmlTag = xmlTag + "</svrl:failed-assert>";
		
		return xmlTag;
	}
	
	/**
	 * Method that creates the node to the report for correct results.
	 * @param message - message to be show
	 * @return String - node with the message
	 */
	private static String createCorrectTag(String message){
		String xmlTag = "";
		
		xmlTag = "<svrl:successful-report test=\""+"Validation against XSD model"+"\">";
		xmlTag = xmlTag + "<svrl:text>"+message+"</svrl:text>";
		xmlTag = xmlTag + "</svrl:successful-report>";
		
		return xmlTag;
	}
}
