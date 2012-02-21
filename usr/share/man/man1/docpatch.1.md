% DOCPATCH(1) DocPatch User Manuals | Version 0.1
%
% January 17, 2012


# NAME

DocPatch - patching documents that matter


# SYNOPSIS

docpatch [*output*] [*command*] [*options*]


# DESCRIPTION


## Who we are

We are part of the Open Data movement and supports the Open Definition (<http://opendefinition.org/okd/>). **Our way** is to "hack" on documents and build Free Software around them---**our goal** is to bring open data to governments---**our idea** is to re-publish constitutions, law texts, and any other public documents in a way everyone and everything may use them.


## What DocPatch stands for

**DocPatch** is our platform to provide these documents to you. It relies on some simple tools from software development. The "heart" of this platform is a version control system (vcs) to manage the documents with their complete history and additional meta information. The documents itself are written in a markup language which allows us a) to use any text editor and b) to convert the texts into any format we want.

This is our current tool stack:

*   vcs: `git` (<http://git-scm.com/>)
*   converter: `pandoc` (<http://johnmacfarlane.net/pandoc/index.html>)
*   markup language: `pandoc`'s enhanced `markdown` (<http://daringfireball.net/projects/markdown/>)

These tools are simple to use, but powerful, widely spread, and open. (Even if they won't fit any more in the future, they could be replaced by other, even better tools. For distributing the repositories, the code, the generated documents, and everything else we use some more tools, e. g. web server, operating system,..., but they don't matter for our intended purpose.)


## First Milestone

Our first target is the German constitution, called "Grundgesetz". First published in March 23th 1949 it was changed round about 60 times. It's interesting to see why it was changed, when, by whom and under what circumstances. The good is: All information is public. The bad: The information doesn't match the Open Definition and many details are hard to find.

In short: We are putting the complete "Grundgesetz" under version control und publish it. Read more about on our website: <https://forge.benjaminheisig.de/docpatch/grundgesetz>

Clone the repository to play around with **DocPatch**:

    git clone git://git.benjaminheisig.de/grundgesetz.git


# INSTALLATION

Installation DocPatch and its components requires the following dependencies:

*   POSIX operating system
*   `git` (distributed version control system)
*   `gpg` (OpenPGP encryption and signing tool)
*   `pandoc` incl. `markdown2pdf` (converting tool)
*   `quilt` (patch management)

After you met all requirements installation is simply done by:

    ./configure
    make
    make install


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

create
:   Produce pretty output from source.


# OPTIONS

-h, \--help
:   Show this help and exit.

\--license
:   Show license information and exit.

\--version
:   Show information about this script and exit.


# FILES

`/etc/docpatch/docpatch.conf`
:   System wide configuration

`~/.docpatch.conf`
:   User specific configuration


# ENVIRONMENT

Most of the configuration settings maybe set in environment.


# DIAGNOSTICS


## EXIT CODES

*   `0`: Operation was successful.
*   `> 0`: Something went wrong.


# BUGS

Please, report any bugs to <https://forge.benjaminheisig.de/docpatch>.


# COPYRIGHT

Copyright (C) 2012 Benjamin Heisig, <http://benjamin.heisig.name/>. License GPLv3+: GNU GPL version 3 or later (<http://gnu.org/licenses/gpl.html>). This is free software: you are free to change and redistribute it. There is NO WARRANTY, to the extent permitted by law.


# AUTHOR

Benjamin Heisig, <http://benjamin.heisig.name/>


# THANKS

We would like to thank the following people:

*   from Chaospott Essen (<http://www.chaospott.de/>)
*   from tiggersWelt.net (<http://www.tiggerswelt.net/>) who provide the hosting services

And everyone who keeps sending us feedback and improving this project! Thank you :-)


# SEE ALSO

`docpatch-build`(1), `docpatch-create`(1), `git`(1), `markdown2pdf`(1), `pandoc(1)`, `quilt`(1)
