@ECHO OFF
TITLE Making OTP files for CC3220.
REM #-------------------------------------------------------------
REM Batch file(s) for making CC3220 OTP file.
REM Author: Forrest Lee Erickson
REM Date: 20190909 
REM Warranty: This program is designed to kill you but is not guarenteed to do so. Use at own risk.
REM file naming as per or similar to: https://e2e.ti.com/support/wireless-connectivity/wifi/f/968/t/766413
REM Run this file after creating keys and certificates by first running the file: Make_key_csr.bat 
REM #-------------------------------------------------------------

CLEAR
ECHO Making OTP file for CC3220
ECHO ...

SETLOCAL
REM set MYPATH=C:\Users\Public\Documents\keys_20190909
set MYPATH=%~dp0
ECHO This is my path %MYPATH%

set SLIMAGECREATORPATH=C:\ti\uniflash_5.1.0\simplelink\imagecreator\bin\
set "CERT_FOLDER=Certs"
REM echo CERT_FOLDER

ECHO ...
ECHO Simple Link Image Creator Version.
%SLIMAGECREATORPATH%SLImageCreator.exe --version
dir "%MYPATH%" 

ECHO ...
ECHO Creating CA Catalog.
%SLIMAGECREATORPATH%SLImageCreator.exe tools make_cert_catalog --cert_folder %MYPATH%%CERT_FOLDER% --out_file "%MYPATH%%CERT_FOLDER%\certificate_Catalog.lst"

ECHO ...
ECHO Sign the CA Catalog.
rem SLImageCreator.exe tools sign --file "C:\Certs\certificate_Catalog.lst" --priv "C:\Certs\root-ca-key.pem" --out_file "C:\Certs\certificate_Catalog.lst.signed.bin" --fmt "BINARY_SHA1"
%SLIMAGECREATORPATH%SLImageCreator.exe tools sign --file "%MYPATH%%CERT_FOLDER%\certificate_Catalog.lst" --priv "%MYPATH%root-ca-key.pem" --out_file "%MYPATH%%CERT_FOLDER%\certificate_Catalog.lstsigned.bin" --fmt "BINARY_SHA1"

ECHO ...
ECHO Creat the OTP file.
rem .\SLImageCreator.exe tools meta --cert "C:\Certs\root-ca-cert.pem" --out_file "C:\Certs\vendor_otp.meta"
%SLIMAGECREATORPATH%SLImageCreator.exe tools meta --cert "%MYPATH%%CERT_FOLDER%\root-ca-cert.pem" --out_file "%MYPATH%%CERT_FOLDER%\vendor_opt.meta 



ECHO ...
ECHO You made it to the end of the OTP file creation phase.
pause
ENDLOCAL