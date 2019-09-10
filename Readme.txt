Batch files for making the required PKI files for CC3220SF with a self signed certificate.

REM #-------------------------------------------------------------
REM Batch file(s) for making CC3220 OTP file.  This file collects the artifacts from making keys and the OPT.
REM Author: Forrest Lee Erickson
REM Date: 20190910 
REM Warranty: This program(s) is designed to kill you but is not guaranteed to do so. Use at own risk.
REM file naming as per or similar to: https://e2e.ti.com/support/wireless-connectivity/wifi/f/968/t/766413
REM These batch file(s) make this process repeatable.
REM #-------------------------------------------------------------


NOTE:
The user must have UniFlash SLImageCreator installed at the hard coded path in the file: Make_key_csr.bat
Or the user can change the path in that file to match the UniFlash SLImageCreator on their PC.



20190909 1003
Helpful notes: A fictitious company for whom we are creating Root of Trust CA.

Root certificate for the ACME Conglomerate Inc. HQ and the IA of ACME Firmware Division
admin@acmeconglomerate.com
Acme conglomerate Inc. HQ is NY New York.
Challenge PW: wemakeeverything
DBA: ACME HQ


"Acme Rocket-Powered Products, Inc." based in Fairfield, New Jersey
rockets@acmeerocketpoweredproducts.biz

ACME Firmware Division, of Acme Rocket-Powered Products, Inc. is based in Monument Valley UT.

firmwaresigning@acmeerocketpoweredproducts.biz
Challenge PW: allzeros
DBA: ACME Wosh Boom

Notes on output files:


File: "out.key" is the ACME Conglomerate Inc. HQ private key
File: "out.csr" is the ACME Conglomerate Inc. certificate signing request with the public key and company information.
File: "certificate.pem" is the ACME Conglomerate Inc. self signed x509 certificate.



Files for programing the CC3220 will be found in the subfolder UniFlash.
File: my-cert-trusted is...
File: my-key.der is the secret key
File: vendor_otp.inf is the OTP file which "validates" the self signed Vendor Certificate Catalog.