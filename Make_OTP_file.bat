@ECHO OFF
TITLE Making OTP files for CC3220.
REM #-------------------------------------------------------------
REM Batch file(s) for making CC3220 OTP file.
REM Author: Forrest Lee Erickson
REM Date: 20190909 
REM Warranty: This program is designed to kill you but is not guarenteed to do so. Use at own risk.
REM file naming as per or similar to: https://e2e.ti.com/support/wireless-connectivity/wifi/f/968/t/766413
REM Run this file after creating keys and certificates by running the file: Make_key_csr.bat 
REM #-------------------------------------------------------------

clear 
ECHO Making OTP file for CC3220
ECHO ...

SETLOCAL

set SLIMAGECREATORPATH=C:\ti\uniflash_5.1.0\simplelink\imagecreator\bin\
set "CERT_FOLDER=Certs"
REM echo CERT_FOLDER

ECHO ...
ECHO Simple Link Image Creator Version.
%SLIMAGECREATORPATH%SLImageCreator.exe --version

ECHO ...
ECHO Creating CA Catalog.
%SLIMAGECREATORPATH%SLImageCreator.exe tools make_cert_catalog --cert_folder "."  --out_file "foo2.txt"


ECHO ...
ECHO You made it to the end of the OTP file creation phase.
rem dir .\Certs
pause


ENDLOCAL