package sembu.utils.config;

import java.util.Arrays;

public class Arguments {
	String xmlFilePath;

	public String getXmlFilePath() {
		return xmlFilePath;
	}

	public void setXmlFilePath(String xmlFilePath) {
		this.xmlFilePath = xmlFilePath;
	}

	public void parseArguments(String[] args) {
		String str1 = Arrays.toString(args);
		checkArguments(str1.substring(1, str1.length() - 1));

		for (int i = 0; i < args.length; i++) {
			String arg = args[i].trim();

			if (arg.equalsIgnoreCase("-xml")) {
				this.xmlFilePath = args[++i];
			}
		}
	}

	private void checkArguments(String stringArgs) {
		if (!stringArgs.toLowerCase().contains("-xml")) {
			exit();
		}
	}

	private void exit() {
		String outputInformation = "";

		outputInformation += "\nNo valid options have been provided.\n";
		outputInformation += "Usage: [arg1] [xpath1] \n";
		outputInformation += "To execute Schematron process, the arguments are:\n";
		outputInformation += "-xml .......................[XML File to be validated]\n";

		outputInformation += "\nExamples:\n -xml xmlValidated.xml \n";

		System.out.println(outputInformation);
		System.exit(1);
	}
}
