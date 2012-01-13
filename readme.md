OpenOCES API, Ruby edition
==========================
This is an attempt at implementing the OpenOCES API (OOAPI), otherwise only available as .NET
and Java libraries, in Ruby.

OOAPI is used to loading and verifying OCES certificates, used in the national Danish
infrastructure system NemID. OCES certificates are basically X.509 certificates with a few
extra properties.

For a typical log-in setup, the user is presented with a Java applet in a browser as log-in
prompt. After a log-in process, the server is presented with some XMLDSig, which OOAPI will
then consume and validate.

The Java and .NET versions of OOAPI are available [here](https://www.nets-danid.dk/produkter/for_tjenesteudbydere/nemid_tjenesteudbyder/nemid_tjenesteudbyder_support/tjenesteudbyderpakken/)


Vision
======
It should be extremely easy to support NemID log-in in your Ruby-based web application
backend, no matter which web application framework you use.


Status
======
Uh-oh. We're just getting started. Fooling around.