@echo off 

REM +------------------------------------------------+
REM + ESPD Request and ESPD Response validation tool +
REM +                                                +
REM + v1.0.0 - 12.08.2024 - ESPD Team                +
REM +------------------------------------------------+

REM setup all files
setlocal EnableDelayedExpansion

REM PAHSE Request
set xml_test_req="..\xml-examples\ESPD-Request.xml"
set xsd_test_req="..\ubl-2.3\xsdrt\maindoc\UBL-QualificationApplicationRequest-2.3.xsd"
set log_req="logs\ESPDRequest\validation.txt"

set ph3req[0].xsl="ESPDRequest\xsl\01-ESPD-codelist-values.xsl"
set ph3req[1].xsl="ESPDRequest\xsl\02-ESPD-req-cardinality-br.xsl"
set ph3req[2].xsl="ESPDRequest\xsl\04-ESPD-common-other-br.xsl"
set ph3req[3].xsl="ESPDRequest\xsl\05-ESPD-req-procurer-br.xsl"
set ph3req[4].xsl="ESPDRequest\xsl\04-ESPD-req-other-br.xsl"
set ph3req[5].xsl="ESPDRequest\xsl\03-ESPD-common-criterion-br.xsl"
set ph3req[6].xsl="ESPDRequest\xsl\03-ESPD-req-criterion-br.xsl"
set ph3req[7].xsl="ESPDRequest\xsl\01-ESPD-common-cl-attributes.xsl"
set ph3req[8].xsl="ESPDRequest\xsl\05-ESPD-req-specific-br.xsl"
set ph3req[9].xsl="ESPDRequest\xsl\01-ESPD-common-cl-values-restrictions.xsl"

set ph3req[0].output="logs\ESPDRequest\output\01-ESPD-codelist-values.xml"
set ph3req[1].output="logs\ESPDRequest\output\02-ESPD-req-cardinality-br.xml"
set ph3req[2].output="logs\ESPDRequest\output\04-ESPD-common-other-br.xml"
set ph3req[3].output="logs\ESPDRequest\output\05-ESPD-req-procurer-br.xml"
set ph3req[4].output="logs\ESPDRequest\output\04-ESPD-req-other-br.xml"
set ph3req[5].output="logs\ESPDRequest\output\03-ESPD-common-criterion-br.xml"
set ph3req[6].output="logs\ESPDRequest\output\03-ESPD-req-criterion-br.xml"
set ph3req[7].output="logs\ESPDRequest\output\01-ESPD-common-cl-attributes.xml"
set ph3req[8].output="logs\ESPDRequest\output\05-ESPD-req-specific-br.xml"
set ph3req[9].output="logs\ESPDRequest\output\01-ESPD-common-cl-values-restrictions.xml"

REM PAHSE Response
set xml_test_res="..\xml-examples\ESPD-Response.xml"
set xsd_test_res="..\ubl-2.3\xsdrt\maindoc\UBL-QualificationApplicationResponse-2.3.xsd"
set log_res="logs\ESPDResponse\validation.txt"

set ph3res[0].xsl="ESPDResponse\xsl\01-ESPD-codelist-values.xsl"
set ph3res[1].xsl="ESPDResponse\xsl\02-ESPD-resp-cardinality-br.xsl"
set ph3res[2].xsl="ESPDResponse\xsl\04-ESPD-common-other-br.xsl"
set ph3res[3].xsl="ESPDResponse\xsl\05-ESPD-resp-eo-br.xsl"
set ph3res[4].xsl="ESPDResponse\xsl\04-ESPD-resp-other-br.xsl"
set ph3res[5].xsl="ESPDResponse\xsl\03-ESPD-common-criterion-br.xsl"
set ph3res[6].xsl="ESPDResponse\xsl\05-ESPD-resp-role-br.xsl"
set ph3res[7].xsl="ESPDResponse\xsl\03-ESPD-resp-criterion-br.xsl"
set ph3res[8].xsl="ESPDResponse\xsl\05-ESPD-resp-qualification-br.xsl"
set ph3res[9].xsl="ESPDResponse\xsl\05-ESPD-resp-specific-br.xsl"
set ph3res[10].xsl="ESPDResponse\xsl\01-ESPD-common-cl-attributes.xsl"
set ph3res[11].xsl="ESPDResponse\xsl\01-ESPD-common-cl-values-restrictions.xsl"

set ph3res[0].output="logs\ESPDResponse\output\01-ESPD-codelist-values.xml"
set ph3res[1].output="logs\ESPDResponse\output\02-ESPD-resp-cardinality-br.xml"
set ph3res[2].output="logs\ESPDResponse\output\04-ESPD-common-other-br.xml"
set ph3res[3].output="logs\ESPDResponse\output\05-ESPD-resp-eo-br.xml"
set ph3res[4].output="logs\ESPDResponse\output\04-ESPD-resp-other-br.xml"
set ph3res[5].output="logs\ESPDResponse\output\03-ESPD-common-criterion-br.xml"
set ph3res[6].output="logs\ESPDResponse\output\05-ESPD-resp-role-br.xml"
set ph3res[7].output="logs\ESPDResponse\output\03-ESPD-resp-criterion-br.xml"
set ph3res[8].output="logs\ESPDResponse\output\05-ESPD-resp-qualification-br.xml"
set ph3res[9].output="logs\ESPDResponse\output\05-ESPD-resp-specific-br.xml"
set ph3res[10].output="logs\ESPDResponse\output\01-ESPD-common-cl-attributes.xml"
set ph3res[11].output="logs\ESPDResponse\output\01-ESPD-common-cl-values-restrictions.xml"

REM ______________________
REM [- START PROCESSING -]

echo.
echo ______________________
echo [- START PROCESSING -]
echo.
echo Precondition validation ...
REM check logs and output folders
if exist logs rmdir /S /Q logs
mkdir logs\ESPDRequest\output logs\ESPDResponse\output
call :msg logs folder OK

echo ESPD Document validation vs UBL and XSL ...

echo --------------------------------------------- >  %log_req%
echo Phase: ESPD Request validation vs UBL and XSL >> %log_req%
echo --------------------------------------------- >> %log_req%

echo Checking UBL XSD file for Request ...
if not exist %xsd_test_req% goto :nofile

echo Validating against %xsd_test_req% >> %log_req%
call :xjparse %xsd_test_req% %xml_test_req% %log_req%
if %errorlevel% neq 0 goto :error_validation

for /L %%i in (0 1 9) do (
  echo Validating against !ph3req[%%i].xsl! >> %log_req%
  call :saxonica %xml_test_req% %%ph3req[%%i].xsl%% %%ph3req[%%i].output%% %log_req%
  if %errorlevel% neq 0 goto :error_validation
)

echo ---------------------------------------------- >  %log_res%
echo Phase: ESPD Response validation vs UBL and XSL >> %log_res%
echo ---------------------------------------------- >> %log_res%

echo Checking UBL XSD file for Response ...
if not exist %xsd_test_res% goto :nofile

echo Validating against %xsd_test_res% >> %log_res%
call :xjparse %xsd_test_res% %xml_test_res% %log_res%
if %errorlevel% neq 0 goto :error_validation

for /L %%i in (0 1 11) do (
  echo Validating against !ph3res[%%i].xsl! >> %log_res%
  call :saxonica %xml_test_res% %%ph3res[%%i].xsl%% %%ph3res[%%i].output%% %log_res%
  if %errorlevel% neq 0 goto :error_validation
)
echo.
call :msg Done successfully validating ESPD Request and ESPD Response, check logs olders for any validation messages.

goto :done

REM XJPARSE local function
REM <param> - the XSD file for validation
REM <param> - the XML file to be validated
REM <param> - the log file
:xjparse
echo xjparse %*
java -jar "lib\xjparse-app-3.0.0.jar" -S %1 %2 2>&1 >> %3
EXIT /B

REM SAXON XSLT transformation local function
REM <param> - the input file 
REM <param> - the XSL transfomer file
REM <param> - the output file
REM <param> - the log file
:saxonica
echo saxon %3 %1 %2 %4
java -jar "lib\saxon-he-12.5.jar" -o:%3 %1 %2 2>&1 >> %4
EXIT /B

REM Checking UBL XSD files
:nofile
echo.
echo [101m x-x [0m Error UBL XSD file not found
goto :done

REM ESPD Dcoument valiation error
:error_validation
echo.
echo [101m ! [0m Error validating ESPD Document; process terminated!
goto :done

REM Auxiliary message display function
:msg
echo.
echo [1m[32m[X][0m %*
echo.
EXIT /B

REM [-THE END-]
:done
echo.
echo [-THE END-]
echo ___________
echo.
endlocal
REM ___________