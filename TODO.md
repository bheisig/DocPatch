# ToDo

… also known as feature requests or bugs


## Meta information

* Use meta information to create output.


## Documentation

* make rule to generate README from docpatch(1) man page.


## Installation

* ./configure should build Makefile
* Check wether `make [all]` has been executed before `make install`


## make rules

* add files for SIGNATURE and SHASUMS


## Build script

* Convert *.meta (really?!)
    * Wordwrap after 80 chars (except 1. line)
    * Copy to $TMP_DIR/*.txt


## Create

* Handle non-numeric revisions.
* Reduce code overhead for each format.


## Checks

* Look for FIXMEs and TODOs and DELETEMEs
* Look for syntax errors in sources, meta information, patches and templates
