% DOCPATCH(1) DocPatch User Manuals | Version 0.1
%
% January 17, 2012


# NAME

docpatch - patching documents that matter


# SYNOPSIS

docpatch [*output*] [*command*] [*options*]


# DESCRIPTION

FIXME


# OUTPUT

-q
:   Be quiet (for scripting).

-v
:   Be verbose.

-V
:   Be verboser.

-D
:   Be verbosest (for debugging).


# COMMANDS

build
:   Build repository.

epub
:   Create EPUB version.

pdf
:   Create PDF version.


# OPTIONS

-h, \--help
:   Show this help and exit.

\--license
:   Show license information and exit.

\--version
:   Show information about this script and exit.


# INSTALLATION

Installation DocPatch and its components requieres the following dependencies

* POSIX operating system
* `git` (distributed version control system)
* `gpg` (OpenPGP encryption and signing tool)
* `pandoc` incl. `markdown2pdf` (converting tool)
* `quilt` (patch management)


# ENVIRONMENT

FIXME


# DIAGNOSTICS

FIXME


# EXIT CODES

* `0`: Operation was successful.
* `> 0`: Something went wrong.


# BUGS

Please, report any bugs to <https://forge.benjaminheisig.de/docpatch>.


# COPYRIGHT

Copyright (C) 2012 Benjamin Heisig <http://benjamin.heisig.name/>. License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>. This is free software: you are free to change and redistribute it. There is NO WARRANTY, to the extent permitted by law.


# AUTHOR

Benjamin Heisig <http://benjamin.heisig.name/>


# THANKS

We would like to thank the following people:

* from Chaospott Essen <http://www.chaospott.de/>
* from tiggersWelt.net <http://www.tiggerswelt.net/> who provide the hosting services

And everyone who keeps sending us feedback and improving this project! Thank you :-)


# SEE ALSO

`docpatch-build`(1), `docpatch-create`(1), `git`(1), `markdown2pdf`(1), `pandoc(1)`, `quilt`(1)
