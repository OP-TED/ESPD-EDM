package sembu.utils.xml;

import javax.xml.transform.*;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;

public class XSLTTransformer {

	/**
	 * Method that executes a XSL-T transformation against a XML.
	 *
	 * @param pathXML  - path of the XML
	 * @param pathXSLT - path of the XSL-T
	 * @param pathOut  - path of the output folder
	 */
	public static void executeXSLTTransformation(boolean isServlet, String pathXML, String pathXSLT, String pathOut) {
		//Preparing the files needed for the transformation
		File xsltFile = new File(pathXSLT);
		Source xsltSource = null;
		Source xmlSource = new StreamSource(new File(pathXML));

		ClassLoader loader = XSLTTransformer.class.getClassLoader();
		try {
			xsltSource = new StreamSource(loader.getResource(pathXSLT).openStream());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Result xmlOutput = new StreamResult(new File(pathOut + xsltFile.getName() + ".xml"));

		//TODO: Log
		System.out.println("New generated file: " + xsltFile.getName() + ".xml");
		try {
			//Transformation
			TransformerFactory tFactory = TransformerFactory.newInstance();
			Transformer transformer = tFactory.newTransformer(xsltSource);
			//javax.xml.transform.Transformer transformer = TransformerFactory.newInstance().newTransformer(xsltSource);
			transformer.transform(xmlSource, xmlOutput);
		} catch (TransformerException e) {
			e.printStackTrace();
		}
	}

	public static void executeXSLTTransformationParam(boolean isServlet, String pathXML, String pathXSLT,
			String pathOut, URL param) {
		//Preparing the files needed for the transformation
		File xsltFile = new File(pathXSLT);
		Source xsltSource = null;
		Source xmlSource = new StreamSource(new File(pathXML));

		ClassLoader loader = XSLTTransformer.class.getClassLoader();
		try {
			xsltSource = new StreamSource(loader.getResource(pathXSLT).openStream());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Result xmlOutput = new StreamResult(new File(pathOut + xsltFile.getName() + ".xml"));

		//TODO: Log
		System.out.println("New generated file: " + xsltFile.getName() + ".xml");
		try {
			//Transformation
			TransformerFactory tFactory = TransformerFactory.newInstance();

			Transformer transformer = tFactory.newTransformer(xsltSource);
			transformer.setParameter("mypath", param.getFile());
			transformer.transform(xmlSource, xmlOutput);
		} catch (TransformerException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Method that executes a XSL-T transformation against a XML, and gives the output name.
	 *
	 * @param pathXML  - path of the XML
	 * @param pathXSLT - path of the XSL-T
	 * @param fileOut  - path and name of the output file
	 */
	public static void executeXSLTtoHTMLTransformation(boolean isServlet, String pathXML, String pathXSLT,
			String fileOut) {
		//Preparing the files needed for the transformation
		ClassLoader loader = XSLTTransformer.class.getClassLoader();

		File xmlFile = new File(pathXML);
		Source xsltSource;

		Result xmlOutput = new StreamResult(new File(fileOut));

		//TODO: Log
		System.out.println("New generated file: " + xmlFile.getName());

		try {

			//Source xmlSource = new StreamSource(loader.getResource(pathXML).openStream()); 
			Source xmlSource = new StreamSource(xmlFile);
			xsltSource = new StreamSource(loader.getResource(pathXSLT).openStream());

			//Transformation
			TransformerFactory tFactory = TransformerFactory.newInstance();
			tFactory.setURIResolver(new URIResolver() {
				public Source resolve(String href, String base) throws TransformerException {
					InputStream is = getStream(href);
					return new StreamSource(is);
				}
			});
			System.out.println("XSLT: " + xmlOutput);
			System.out.println("XSLT: " + pathXML);

			Transformer transformer = tFactory.newTransformer(xsltSource);
			transformer.transform(xmlSource, xmlOutput);

		} catch (TransformerException | IOException e) {
			e.printStackTrace();
		}
	}

	static InputStream getStream(String fileName) {
		InputStream xslStream = Thread.currentThread().getContextClassLoader()
				.getResourceAsStream("common/xsl/" + fileName);
		if (xslStream == null || fileName.equals("")) {
			xslStream = Thread.currentThread().getContextClassLoader().getResourceAsStream(fileName);
			System.out.println(fileName);
		} else {

			System.out.println("common/xsl/" + fileName);
		}
		return xslStream;
	}
}
