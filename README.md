# ESPD Exchange Data Model (EDM)

## Introduction

The ESPD Exchange Data Model is the technical representation of the legal European Single Procurement Document. It is used to support interoperability between ESPD services provided all over Europe.

## Documentation

* [v2.1.0](https://espd.github.io/ESPD-EDM/v2.1.0/)
* [v2.0.2](https://espd.github.io/ESPD-EDM/v2.0.2/)
* [v2.0.1](https://espd.github.io/ESPD-EDM/v2.0.1/)
* [v2.0.0](https://espd.github.io/ESPD-EDM/v2.0.0/)
* [v1.0.2](https://espd.github.io/ESPD-EDM/v1.0.2/)
* [v1.0.1](https://github.com/ESPD/ESPD-EDM/blob/1.0.1/docs/src/main/asciidoc/index.adoc)

## Roadmap

Dear ESPD implementation community, 

We are happy to inform you about the release of ESPD EDM version 2.1.0.

### Version 2.1.0 (January 2019)
The [ESPD EDM version 2.1.0](https://github.com/ESPD/ESPD-EDM/tree/2.1.0) is now released and focuses, mainly, on the improvement of the 
ESPD-SELF-CONTAINED features. All the changes introduced in this new version were based on the inputs from Member States and other Stakeholders
collected through the GitHub [issues](https://github.com/ESPD/ESPD-EDM/issues) workspace. For further details please read the 
[release notes](https://espd.github.io/ESPD-EDM/v2.1.0/release_notes.html).

### Version 2.0.2 (May 2018)
 
The [ESPD EDM version 2.0.2](https://github.com/ESPD/ESPD-EDM/tree/2.0.2) addresses bugs fixed on the basis of the received comments on [GitHub](https://github.com/ESPD/ESPD-EDM/issues).
For further details please read the [release notes](https://espd.github.io/ESPD-EDM/v2.0.2/release_notes.html). The release contains a definition of all relevant
[business rules](https://github.com/ESPD/ESPD-EDM/tree/2.0.2/docs/src/main/asciidoc/dist/doc) and corresponding [schematron files](https://github.com/ESPD/ESPD-EDM/tree/2.0.2/docs/src/main/asciidoc/dist/val/schematron)
to validate Regulate and Self-Contained ESPD Request and Response XML instances (including the validation of the criteria taxonomy).
The corresponding [TestBed for version 2.0.2](http://isaitb2.northeurope.cloudapp.azure.com/espd/upload) has been set up. The specifications for version 2.0.2 contain an updated distribution of the
[ESPD Exchange Data Model](https://github.com/ESPD/ESPD-EDM/tree/2.0.2/docs/src/main/asciidoc/dist/val/schematron) and include a corresponding [implementation guideline](https://espd.github.io/ESPD-EDM/v2.0.2/xml_guide.html)
which clarifies the [ESPD validation architecture in Annex I](https://espd.github.io/ESPD-EDM/v2.0.2/xml_guide.html#annex-i-xml-validation).
Also, the [BIS 41 – ESPD version 2.0.2](http://wiki.ds.unipi.gr/display/ESPDInt/BIS+41+-+ESPD+V2.0.2) was updated accordingly.


### Release of criteria taxonomy file errata [ESPD EDM version 1.0.2] (May 2018)

A release of criteria taxonomy file errata [ESPD EDM version 1.0.2] was necessary as the documentation on the criteria taxonomy was not updated to reflect the changes that were made to the Commission ESPD service up until July 2017. All corrections relate to the Criteria Data Flows and result in a revision of the [criteria taxonomy for version 1.0.2](https://github.com/ESPD/ESPD-EDM/blob/2.0.2/docs/src/main/asciidoc/dist/cl/ods/CriteriaTaxonomy-V1.0.2-errata.ods) (revisions are marked within the sheet). No other change was done to the ESPD EDM version 1.0.2. The revisions should therefore have no impact on all current ESPD services based on v1.0.2 but we recommend using the revised criteria taxonomy to approve the correct Criteria Data Flows. 

### Version 2.0.1 (January 2018) 

Bug fixes detected in the previous versions; change requests related to these bugs were collected in this Github Issues space (see Issues for the details. See also the Release Notes above and the 'dist/rn' folder for details on those issues related to v2.1.0 that have been closed). 

### Version 2.0.0 (September 2017): 

The goal of version 2.0.0 is that the ESPD-EDM is self contained. Meaning that public buyers can specify directly in their ESPD services criteria instead of defining them in the procurement document or the notice. Examples are that the public buyer can specify the number of years needed for the turnovers, the financial ratios needed for the procedure or that they can specify certificates needed. Something else that will be implemented in version 2.0.0 is the possibility to weight criteria which is important to reduce the number of participants in a procedure. Issues for this release are in *https://github.com/ESPD/ESPD-EDM/issues*.

### Version 1.0.2 (July 2016) 

Version 1.0.2 has no impact on current implementation. It fixes the issue *https://github.com/ESPD/ESPD-EDM/issues*.
  
### Version 1.0.1 (December 2015)

Very first version of the ESPD-EDM. Partially based on UBL 2.1.

## Installation

The recommended way to get started using the `exchange-model` in a `Java` project is with a dependency management system.

### With Maven

```xml
<dependency>
  <groupId>eu.europa.ec.grow.espd</groupId>
  <artifactId>exchange-model</artifactId>
  <version>1.0.2</version>
</dependency>
```

### With Gradle

```groovy
dependencies {
    compile("eu.europa.ec.grow.espd:exchange-model:1.0.2")
}
```

### Version 2.1.0

**Please note that this version requires Java 8**

```xml
<dependency>
  <groupId>eu.europa.ec.grow.espd</groupId>
  <artifactId>exchange-model2</artifactId>
  <version>2.1.0</version>
</dependency>
```

Version 2 of the `Exchange Model` has a different `artifactId`, i.e. `exchange-model2`, in order to support 
the usage of both versions at the same time inside a `Java` `Maven` project.

In order to use the snapshot version, you might have to enable the `Maven` snapshot repository in your `pom.xml`.


```xml
<repositories>
  <repository>
    <id>oss-sonatype</id>
    <name>oss-sonatype</name>
    <url>https://oss.sonatype.org/content/repositories/snapshots/</url>
    <snapshots>
      <enabled>true</enabled>
    </snapshots>
  </repository>
</repositories>
```

## Use
The ESPD-EDM is made publicly available through Github. 
* If you just want to browse or access the model, you don't need to be registered in Github.
* If you want to create issues concerning the ESPD-EDM you have to be a registered user in Github. Please assign all issues in this repository to paulakeen
