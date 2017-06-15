# ESPD Exchange Data Model (EDM)

## Introduction

The ESPD Exchange Data Model is the technical representation of the legal European Single Procurement Document. It is used to support interoperability between ESPD services provided all over Europe.

## Documentation

* [Version 2.0.0 - in progress (covers both Regulated and Self-Contained ESPD)](https://github.com/ESPD/ESPD-EDM/tree/2.0.0/docs/src/main/asciidoc/index.adoc)
* [Latest stable version v1.0.2](https://espd.github.io/ESPD-EDM/)
* [v1.0.1](https://github.com/ESPD/ESPD-EDM/blob/1.0.1/docs/src/main/asciidoc/index.adoc)

## Roadmap

* **Version 1.0.1**: Version 1.0.1 is used since December 2015. This version is based on UBL 2.1.
* **Current Version 1.0.2**: Version 1.0.2 has no impact on current implementation. It was published in July 2016. It fixes the issue: 
  * https://github.com/ESPD/ESPD-EDM/issues/2
* **Version 2.0.0**: The goal of version 2.0.0 is that the ESPD-EDM is self contained. Meaning that public buyers can specify directly in their ESPD services criteria instead of defining them in the procurement document or the notice. Examples are that the public buyer can specify the number of years needed for the turnovers, the financial ratios needed for the procedure or that they can specify certificates needed. Something else that will be implemented in version 2.0.0 is the possibility to weight criteria which is important to reduce the number of participants in a procedure. Issues for this release are:
  * https://github.com/ESPD/ESPD-EDM/issues/
  
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

### Version 2.0.0

**Please note that this version requires Java 8**

```xml
<dependency>
  <groupId>eu.europa.ec.grow.espd</groupId>
  <artifactId>exchange-model</artifactId>
  <version>2.0.0-SNAPSHOT</version>
</dependency>
```

## Use
The ESPD-EDM is made publicly available through Github. 
* If you just want to browse or access the model, you don't need to be registered in Github.
* If you want to create issues concerning the ESPD-EDM you have to be a registered user in Github. Please assign all issues in this repository to paulakeen
