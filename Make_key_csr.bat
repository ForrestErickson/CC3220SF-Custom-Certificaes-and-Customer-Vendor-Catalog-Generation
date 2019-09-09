@ECHO OFF
TITLE Making Keys and CSR
REM #-------------------------------------------------------------
REM Batch file(s) for making PKI keys and csr with a repetable proccess.
REM Author: Forrest Lee Erickson
REM Date: 20190909 
REM Warranty: This program is designed to kill you but is not guarenteed to do so. Use at own risk.
REM file naming as per https://e2e.ti.com/support/wireless-connectivity/wifi/f/968/t/766413
REM #-------------------------------------------------------------

clear 
ECHO Making PKI Keys and CSR (Certificate Signing Request)
ECHO Get your company information ready.

REM Should make/change to a directory but for now make in same directory
ECHO Changeing to directory
cd .
REM dir

REM Lets make keys with OpenSSL
ECHO Making CA keys with OpenSSL
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out root-ca-key.pem
openssl rsa -in root-ca-key.pem -inform PEM -out root-ca-key.der -outform DER

dir
ECHO To display the private key
pause 
 
openssl pkey -in root-ca-key.pem -text

ECHO
ECHO Make  and display public key 
openssl pkey -in root-ca-key.pem -out root-ca-public-key.pem -pubout
openssl pkey -in root-ca-public-key.pem -pubin -text
pause

ECHO ...
ECHO Make x509 certificate in PEM and DER
openssl req -new -x509 -days 10000 -key root-ca-key.pem -out root-ca-cert.pem
openssl rsa -in root-ca-key.pem -inform PEM -out root-ca-key.der -outform DER
ren root-ca-key.der root-ca-key
dir
pause 
