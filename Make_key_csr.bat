@ECHO OFF
TITLE Making Keys and CSR
REM #-------------------------------------------------------------
REM Batch file(s) for making PKI keys and csr with a repetable proccess.
REM Author: Forrest Lee Erickson
REM Date: 20190909 
REM Warranty: This program is designed to kill you but is not guarenteed to do so. Use at own risk.
REM #-------------------------------------------------------------

clear 
ECHO Making PKI Keys and CSR (Certificate Signing Request)
ECHO Get your company information ready.

REM Should make/change to a directory but for now make in same directory
ECHO Changeing to directory
cd .
REM dir

REM Lets make keys with OpenSSL
ECHO Making keys with OpenSSL
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out private-key.pem

dir
ECHO To display the private key
pause 
 
openssl pkey -in private-key.pem -text

ECHO
ECHO Make  and display public key 
openssl pkey -in private-key.pem -out public-key.pem -pubout
openssl pkey -in public-key.pem -pubin -text

pause
 
