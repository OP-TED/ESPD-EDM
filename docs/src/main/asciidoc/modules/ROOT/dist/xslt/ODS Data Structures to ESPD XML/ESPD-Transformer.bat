@ECHO OFF
title ESPD XSLT Transformation

echo Syntax: [ODS FILE] [XSLT FILE] [TAB NAME] [OUTPUT XML]

java -jar ESPD-Transformation.jar %1 %2 %3 %4
PAUSE