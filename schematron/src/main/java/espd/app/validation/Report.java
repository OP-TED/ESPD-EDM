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
			outputFile.write("<img height=\"110px\" align=\"middle\" src=\"data:image/png;base64,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\">");
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
