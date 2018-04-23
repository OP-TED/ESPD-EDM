package org.example;

import java.io.*;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import javax.xml.transform.*;
import javax.xml.transform.stream.*;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.*;

public class Main {
	public static void main(String[] args) throws IOException {
		// initializing the log files to save the errors of the executed program
		final Logger logger = Logger.getLogger(Main.class);
		
		if (args.length != 4) {
			logger.error("The Arguments are  not properly placed");
		}

		File sourceFile = new File(args[0]); // source file
		File templateFile = new File(args[1]); // template file
		String value = (args[2]); // xsltParamName
		File resultedFile = new File(args[3]); // result file
		ZipFile zip = new ZipFile(sourceFile);
		try {

			if (!sourceFile.exists()) {
				logger.error("The File does not exist in the directory !");
			}
			if (!templateFile.exists()) {
				logger.error("The File does not exist in the directory !");
			}
			// Checking if the files have desired extensions
			String extentionOfSourceFile = FilenameUtils.getExtension(sourceFile.getName());
			String extentionOfTemplateFile = FilenameUtils.getExtension(templateFile.getName());

			if (!extentionOfSourceFile.equals("ods")) {
				logger.error("Please choose a proper ODS  file");
			}
			if (!extentionOfTemplateFile.equals("xslt")) {
				logger.error("Please choose a proper XSLT file");
			}

			Enumeration<?> entries = zip.entries();
			while (entries.hasMoreElements()) {

				ZipEntry entry = (ZipEntry) entries.nextElement();

				if (entry.getName().equals("content.xml")) {

					InputStream in = zip.getInputStream(entry);

					TransformerFactory file = TransformerFactory.newInstance();
					Transformer template = file.newTransformer(new StreamSource(templateFile));
					Source source = new StreamSource(in);
					Result result = new StreamResult(resultedFile);

					template.setParameter("inputTab", value);

					template.transform(source, result);

				}

			}

		}

		catch (TransformerException e) {
			logger.error(e.toString());

		} finally {
			zip.close();
		}
	}

}
