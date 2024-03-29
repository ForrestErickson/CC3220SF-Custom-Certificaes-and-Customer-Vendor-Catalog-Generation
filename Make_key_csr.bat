@ECHO OFF
TITLE Making Keys and CSR
REM #-------------------------------------------------------------
REM Batch file(s) for making PKI keys and csr with a repetable proccess.
REM Author: Forrest Lee Erickson
REM Date: 20190909 
REM Warranty: This program is designed to kill you but is not guarenteed to do so. Use at own risk.
REM file naming as per or similar to: https://e2e.ti.com/support/wireless-connectivity/wifi/f/968/t/766413
REM #-------------------------------------------------------------

clear 
ECHO Making PKI Keys and CSR (Certificate Signing Request)
ECHO Get your company information ready.

REM Should make/change to a directory but for now make in same directory
ECHO Changeing to directory
cd .
REM dir

REM check and make folders for artifacts and output.
set SLIMAGECREATORPATH=C:\ti\uniflash_5.1.0\simplelink\imagecreator\bin\
set "CERT_FOLDER=Certs"
set "UNIFLASH_FOLDER=UniFlash"
IF not EXIST "%~dp0%CERT_FOLDER%" call :makeCerts
IF not EXIST "%~dp0%UNIFLASH_FOLDER%" call :makeUniFlash

REM Lets make keys with OpenSSL
ECHO Making CA (root Certificate Authority) keys with OpenSSL
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out root-ca-key.pem
openssl rsa -in root-ca-key.pem -inform PEM -out root-ca-key.der -outform DER

ECHO ...
ECHO To display the private key 
openssl pkey -in root-ca-key.pem -text

ECHO ...
ECHO Make  and display public key 
openssl pkey -in root-ca-key.pem -out root-ca-public-key.pem -pubout
openssl pkey -in root-ca-public-key.pem -pubin -text
pause

ECHO ...
ECHO Have your Certificate Authority company credinetials ready.
ECHO Make x509 CA certificate in PEM and DER
openssl req -new -x509 -days 10000 -key root-ca-key.pem -out root-ca-cert.pem
ECHO Use PEM to make a DER
pause
openssl x509 -in root-ca-cert.pem -inform PEM -out root-ca-cert.der -outform DER
REM ren root-ca-key.der root-ca-key
REM ren root-ca-cert.der root-ca-cert
ECHO Look for root-ca-cert.der
pause
copy root-ca-cert.der root-ca-cert
copy root-ca-cert.pem %~dp0%CERT_FOLDER%\

ECHO ...
ECHO Generate local "my" keys. 
openssl genrsa -out my-key.pem 2048
openssl rsa -in my-key.pem -inform PEM -out my-key.der -outform DER

ECHO ...
ECHO Ready to generate "my" certificate (untrusted)
ECHO Have your (firmware) company credinetials ready.
pause 
openssl req -new -key my-key.pem -out my-cert.pem

ECHO ...
ECHO Sign "my" certificate with the root CA key. Convert to DER and rename.
openssl x509 -req -days 10000 -in my-cert.pem -CA root-ca-cert.pem -CAkey root-ca-key.pem -set_serial 01 -out my-cert-trusted.pem
openssl x509 -in my-cert-trusted.pem -inform PEM -out my-cert-trusted.der -outform DER
ren my-cert-trusted.der my-cert-trusted

ECHO ...
ECHO You made it to the end of the OpenSSL phase.
dir
pause
exit /B 
REM end of main batch.

rem SUBROUTINES Here ---------------------------
:makeCerts
echo Make the Certs folder %1...
mkdir Certs
exit /b

:makeUniFlash
echo Make the UniFlash folder %1...
mkdir UniFlash
exit /b


REM a template for subroutine
:template
echo Processing template on arugment %1...
echo ... commands go here ...
exit /b
