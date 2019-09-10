@ECHO OFF
TITLE Making (Collect) UniFlash files for CC3220.
REM #-------------------------------------------------------------
REM Batch file(s) for making CC3220 OTP file.  This file collects the artifacts from making keys and the OPT.
REM Author: Forrest Lee Erickson
REM Date: 20190910 
REM Warranty: This program is designed to kill you but is not guarenteed to do so. Use at own risk.
REM file naming as per or similar to: https://e2e.ti.com/support/wireless-connectivity/wifi/f/968/t/766413
REM Run this file after creating keys and certificates AND making INF file by first running the files: Make_key_csr.bat and Make_OTP_file.bat
REM #-------------------------------------------------------------

CLEAR
ECHO Making (Collect) UniFlash files for CC3220.
ECHO ...

SETLOCAL
REM set MYPATH=C:\Users\Public\Documents\keys_20190909
set MYPATH=%~dp0
ECHO This is my path %MYPATH%
set "CERT_FOLDER=Certs"
set "UNIFLASH_FOLDER=UniFlash"
IF not EXIST "%~dp0%UNIFLASH_FOLDER%" call :makeUniFlash

REM Move to UniFlash folder the files we need for programing CC3220
copy my-key.der .\%UNIFLASH_FOLDER%\
copy my-cert-trusted .\%UNIFLASH_FOLDER%\
copy root-ca-cert.der .\%UNIFLASH_FOLDER%\root-ca-cert
copy %CERT_FOLDER%\vendor_otp.inf .\%UNIFLASH_FOLDER%\

ECHO ...
ECHO You made it to the end of the UniFlash file collection phase.
pause
ENDLOCAL
exit /B 
REM end of main batch.

rem SUBROUTINES Here ---------------------------
:makeUniFlash
echo Make the UniFlash folder %1...
mkdir UniFlash
exit /b

REM a template for subroutine
:template
echo Processing template on arugment %1...
echo ... commands go here ...
exit /b