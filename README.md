# Tegile-API-Toolkit

The Tegile API Toolkit provides a set of bash functions that utilize the Tegile API via curl
JSON HTTPS POST methods.  The toolkit provides functions to create, list and delete Tegile
share-level snapshots and clones.

The functions were created with simplicity in mind.  The functions return what curl returns.
Upon improper use of the functions, the functions return 128 which is out of the scope of curl
return codes.  The functions do not exit but rather return so as not to interrupt anything
from the calling script (ie Reverting Oracle DB hot backup mode, etc). It is up to the calling
script to handle errors and JSON parsing where applicable.
