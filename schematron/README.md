# ESPD Schematron validation example

## Introduction

This Java project serves as an example of validating an `ESPDRequest` or `ESPDResponse`. It supports general validation,
code lists validation and business rules validation implemented with [Schematron](http://www.schematron.com/spec.html).

## Installation

The structure and management of the project is done through [Maven](Maven: https://maven.apache.org/).
Maven will facilitate the compilation of the source files, and the generation of the JAR file via the command: `clean package`.

## Execution
The project can be executed from your IDE by running the `ESPDValidation` class and passing the `–xml path/xmlFile.xml`
program argument.

The JAR file can be executed as a single file in a command prompt: `java –jar espd-schematron.jar –xml path/xmlFile.xml`.

## Additional documentation

[More information can be found here](./docs/schematron_examples.adoc)
