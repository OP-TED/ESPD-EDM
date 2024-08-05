# espd-demo
JavaScript application demonstrating the usage of ESPD EDM

[![EUPL Licence](https://img.shields.io/badge/Licence-EUPL%20v1.2-blue.svg)](https://eupl.eu/1.2/en)

**Audience** 

This is a technical repository and is intended to be used as a tool that gets as input:  
- ESPD Request and ESPD Response, and 
- UBL, ESPD specific business rules, and Code Lists

and validates the ESPD XML files that are uploaded via the web interface [ISAITB testbed site](https://www.itb.ec.europa.eu/espd/upload).

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Licence](#licence)

## Instalation
The code in this repository is intended to run on Github Pages or as PWA. If you want to test the code on your local machine, you can do the following steps:

1. clone the repository on your machine
```
git clone https://github.com/OP-TED/ESPD-EDM.git
cd ESPD-EDM
git checkout espd-demo
```
For local testing and devlopment webserver, [Fastify](https://fastify.dev/) was chosen. Any webserver that serves static files will do the job. You need to server the root folder. The prerequisites for **Fastify**: [NodeJS](https://nodejs.org/en/download/) and the framework itself. To install all prerequisites, run the command:
```
npm install
```
Develop and test on local machine and you can see the results using your favourite local webserver, Fastify is provided by default:
```
npm start
```
This should start the local webserver on port **3000**, you site is available at: [http://localhost:3000](http://localhost:3000)

## Usage

Go to the Github Pages site: [ESPD Demo](https://docs.ted.europa.eu/ESPD-EDM/). This is a Single Page Application that will allow you to test, visualize and play with ESPD EDM before deciding if you would like to proceed with the implementation or upgrade of you ESPD Service.

The site contains a couple the following sections:

### Section 1. Excel files distribution

**Export** menu allows to download the **Excel** files and the Code Lists as archive.
Here you can find your **Excel** files:
- for Code Lists
- for ESPD Model and ESPD Data Structure

### Section 2. Code Lists

**Lists** allows you to view Code Lists and all elements details.

### Section 3. UUID eCERTIS - ESPD integraton

**UUID** sections allows to explore the UUIDs for Exclusion Grounds and Selection Criteria. You can check the eCERTIS correspondence. Those UUIDs are the integration point between ESPD and eCERITS.

### Section 4. ESPD model visualiation

In order to model and better visualize the ESPD model we propose to use a UI visualitsation to get direct representation of what the model will look like on a web page.

We provide a basic behaviour demonstration of the rules behind each building block.

### Section 5. ESPD Request-Response examples generator 

We provide a JavaScript online implementation of the ESPD Request and Response example generator that will allow Member States to have a playground for testing latest ESPD versions. Member States will be able to generate specific examples and test the ESPD before implementation.

This is provided only for demonstrative purpouse and it is not an actual service. The Member States must use the officially implemented and agreed ESPD services for their corresponding country.

## Licence

This software is shared using the [European Union Public Licence (EUPL) version 1.2](https://joinup.ec.europa.eu/collection/eupl/eupl-text-eupl-12).