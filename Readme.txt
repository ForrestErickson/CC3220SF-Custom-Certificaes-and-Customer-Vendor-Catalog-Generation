20190909 1003

Root certificate for the ACME Conglomerate Inc. HQ and the IA of ACME Firmware Division
admin@acmeconglomerate.com
Acme conglomerate Inc. HQ is NY New York.
Challenge PW: wemakeeverything
DBA: ACME HQ


"Acme Rocket-Powered Products, Inc." based in Fairfield, New Jersey
rockets@acmeerocketpoweredproducts.com

ACME Firmware Division, of Acme Rocket-Powered Products, Inc. is based in Monument Valley UT.

firmwaresigning@acmeerocketpoweredproducts.com
Challenge PW: allzeros


Lets make a batch file(s) for making this proccess repetable.



File: "out.key" is the ACME Conglomerate Inc. HQ private key
File: "out.csr" is the ACME Conglomerate Inc. certificate signing request with the public key and company information.
File: "certificate.pem" is the ACME Conglomerate Inc. self signed x509 certificate.

20190815
To convert the PEM format to DER, I found some instructinos at:  
https://www.poftut.com/convert-der-pem-pem-der-certificate-format-openssl/
openssl x509 -inform PEM -outform DER -text -in mykey.pem -out mykey.der

so for our file: openssl x509 -inform PEM -outform DER -text -in certificate.pem -out certificate.der

Oops looks like the command should have been with out the "-text" option. Try again.
openssl x509 -inform PEM -outform DER -in certificate.pem -out certificate2.der
Replace the old text laden output file.




Make folder C:\Users\Public\Documents\keys_swpu332a_2.1\ExampleKnownCA
Copy certificate.der into folder.

Create certificate catalog:
Open a CMD window and cd to the bin folder of the SimpleLink.
C:\ti\uniflash_5.1.0\simplelink\imagecreator\bin

Make SLImageCreator.exe tools make_cert_catalog --cert_folder "C:\Users\Public\Documents\keys_swpu332a_2.1\ExampleKnownCA" --out_files "C:\Users\Public\Documents\keys_swpu332a_2.1\Certs"
This failed probably because the command was too big for DOS CMD window.

Make folders off of root.
Make SLImageCreator.exe tools make_cert_catalog --cert_folder "C:\tmp\ExampleKnownCA" --out_file "C:\tmp\Certs\certificate_Catalog.lst"

This worked and made a file.

Now to sign the file with the private key.  Copy the key to the Certs file for a shorter path.
SLImageCreator.exe tools sign --file "C:\tmp\Certs\C1.lst" --priv "C:\tmp\Certs\out.key" --out_file "C:\tmp\Certs\C1.lst.signed.bin" --fmt "BINARY_SHA1"
This worked. I have a file: C1.lst.signed.bin

20190820 Resume.
Let's make the OTP following section 7.2 of SWRU547A.

SLImageCreator.exe tools meta --cert "C:\Users\Public\Documents\keys_swpu332a_2.1\certificate.pem" --out_file "C:\tmp\OTP\vendor_otp.meta" --mac "000000000000" --usechain
This created a file.

Let's sign the file
SLImageCreator.exe tools sign --file "C:\tmp\OTP\vendor_otp.meta" --priv "C:\tmp\Certs\out.key" --out_file "C:\tmp\OTP\vendor_otp.meta.sig" --fmt "BINARY_SHA2"
This created a file.

Let's make the OTP information file.
SLImageCreator.exe tools inf --algo 2 --sign1 "C:\tmp\OTP\vendor_otp.meta.sig" --sign2 "C:\tmp\OTP\vendor_otp.meta.sig" --meta "C:\tmp\OTP\vendor_otp.meta" --out_file ""C:\tmp\OTP\vendor_opt.inf"
This created a file.


