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

The idea is __not__ to copy all the functionality from the original OOAPI versions, only the
bare necessities. For example:

* The original OOAPI versions support partial revocation lists, full revocation lists, and
  OCSP responders as ways to check the validity of a certificate. By default, partial
  revocation lists are used, and most clients will never need anything else. That's all we'll
  support, then.
* The original OOAPI versions support a lot of queries on OCES certificates. We will only
  support what is strictly necessary to support login and signing.
* The original OOAPI versions have two API layers, where clients will typically use the most
  abstract layer (the "security package"). Hence, the functionality in this layer is what we
  will opt for.
* The original OOAPI versions include a so-called PID client, which can be used to verify that
  a Danish civil registration number (CPR number) matches a PID or actually get the civil
  registration number from a PID. (The latter service is only available for public
  institutions.) We might not support this, since it is not strictly necessary for log-in and
  signing.


Status
======
Uh-oh. We're just getting started. Fooling around.