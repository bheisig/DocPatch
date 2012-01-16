## backulous -- Simple Backup Scripts
## Copyright (C) 2011 Benjamin Heisig <http://benjamin.heisig.name/>
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.


SHELL = /bin/sh

INSTALL = /usr/bin/install
INSTALL_PROGRAM = $(INSTALL)
INSTALL_DATA = $(INSTALL) -m 644
FIND = /usr/bin/find
GZIP = /bin/gzip
PANDOC = /usr/bin/pandoc
MARKDOWN2PDF = /usr/bin/markdown2pdf

project = $(shell cat usr/share/docpatch/config.inc | sed -n 's/^PROJECT_NAME="\(.*\)"$$/\1/p')
man1pages = $(project)
metainfos = AUTHORS INSTALL NEWS README THANKS TODO
docs = 
version = $(shell cat usr/share/docpatch/config.inc | sed -n 's/^PROJECT_VERSION="\(.*\)"$$/\1/p')

prefix = /usr
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
datarootdir = $(prefix)/share
datadir = $(datarootdir)
docdir = $(datarootdir)/doc/$(project)
infodir = $(datarootdir)/info
htmldir = $(docdir)/html
pdfdir = $(docdir)/pdf
mandir = $(datarootdir)/man
man1dir = $(mandir)/man1


## Build

all : man info meta
	@echo "$(project) built. Ready to install."

man : $(man1pages)
	@echo "Man pages built."

info :
	@echo "Build info documentation..."
	@mkdir docs/info
	@$(PANDOC) --from markdown --to texinfo $(docs) --toc --standalone | $(GZIP) -c > docs/info/$(project).info.gz

html :
	@echo "Build HTML documentation..."
	@$(PANDOC) --from markdown --to html -o docs/html/$(project).html --toc --standalone $(docs)

pdf :
	@echo "Build PDF documentation..."
	@$(MARKDOWN2PDF) -o docs/pdf/$(project).pdf $(docs)

dvi :
	@echo "Failed to build DVI documentation. It's not supported."
	exit 1

ps :
	@echo "Failed to build Postscript documentation. It's not supported."
	exit 1

meta : $(metainfos)
	@echo "Copy meta information COPYING..."
	@cp COPYING usr/share/doc/$(project)/COPYING
	@echo "Meta information built."

% : usr/share/man/man1/%.1.md
	@echo "Build man1 page $@..."
	@$(PANDOC) --from markdown --to man $< | $(GZIP) -c > usr/share/man/man1/$@.1.gz

% : %.md
	@echo "Build meta information $@..."
	@$(PANDOC) --from markdown --to plain $< > usr/share/doc/$(project)/$@


## Install/Uninstall

install :
	$(NORMAL_INSTALL)
	@echo "Install $(project)..."
	@if [ ! -d $(DESTDIR)$(bindir) ]; then \
	    mkdir -p $(DESTDIR)$(bindir); \
	  fi
	@$(INSTALL) usr/bin/$(project) $(DESTDIR)$(bindir)
	@mkdir -p $(DESTDIR)$(datadir)/$(project)
	@$(INSTALL) usr/share/$(project)/* $(DESTDIR)$(datadir)/$(project)
	@mkdir -p $(DESTDIR)$(docdir)
	@$(INSTALL_DATA) usr/share/doc/$(project)/AUTHORS \
	  usr/share/doc/$(project)/COPYING \
	  usr/share/doc/$(project)/INSTALL \
	  usr/share/doc/$(project)/NEWS \
	  usr/share/doc/$(project)/README \
	  usr/share/doc/$(project)/THANKS \
	  usr/share/doc/$(project)/TODO $(DESTDIR)$(docdir)
	@mkdir -p $(DESTDIR)$(docdir)/examples
	@mkdir $(DESTDIR)$(docdir)/examples/bash_completion.d
	@mkdir $(DESTDIR)$(docdir)/examples/cron.d
	@mkdir $(DESTDIR)$(docdir)/examples/etc
	@$(INSTALL_DATA) usr/share/doc/$(project)/examples/bash_completion.d/* $(DESTDIR)$(docdir)/examples/bash_completion.d
	@$(INSTALL_DATA) usr/share/doc/$(project)/examples/cron.d/* $(DESTDIR)$(docdir)/examples/cron.d
	@$(INSTALL_DATA) usr/share/doc/$(project)/examples/etc/* $(DESTDIR)$(docdir)/examples/etc
	$(POST_INSTALL)
	@echo "Install info documentation..."
	@if [ ! -d $(DESTDIR)$(infodir) ]; then \
	    mkdir -p $(DESTDIR)$(infodir); \
	  fi
	@$(INSTALL_DATA) docs/info/*.info.gz $(DESTDIR)$(infodir)
	install-info --dir-file="$(DESTDIR)$(infodir)/dir" $(DESTDIR)$(infodir)/$(project).info.gz
	@if [ ! -d $(DESTDIR)$(man1dir) ]; then \
	    mkdir -p $(DESTDIR)$(man1dir); \
	  fi
	@$(INSTALL_DATA) usr/share/man/man1/*.1.gz $(DESTDIR)$(man1dir)
	@echo "$(project) installed."

install-html :
	@echo "Install HTML documentation..."
	@$(INSTALL_DATA) docs/html/*.html $(DESTDIR)$(htmldir)

install-pdf :
	@echo "Install PDF documentation..."
	@$(INSTALL_DATA) docs/pdf/*.pdf $(DESTDIR)$(pdfdir)

uninstall :
	$(PRE_UNINSTALL)
	@echo "Uninstall info documentation..."
	@rm $(DESTDIR)$(infodir)/$(project).info.gz
	$(NORMAL_UNINSTALL)
	@echo "Uninstall $(project)..."
	@rm $(DESTDIR)$(bindir)/$(project)
	@rm -r $(DESTDIR)$(datadir)/$(project)/
	@rm -r $(DESTDIR)$(docdir)
	@rm $(DESTDIR)$(man1dir)/$(project).1.gz


## Release

dist : changelog
	@echo "Create directory $(project)-$(version)/..."
	@mkdir $(project)-$(version)
	@echo "Copy files to $(project)-$(version)/..."
	@chmod 777 -R $(project)-$(version)/
	@find docs usr -type d -exec mkdir $(project)-$(version)/{} \; \
	  -exec chmod 777 $(project)-$(version)/{} \;
	@find docs usr -type f -exec cp {} $(project)-$(version)/{} \; \
	  -exec chmod 755 $(project)-$(version)/{} \;
	@$(INSTALL_PROGRAM) -m 755 AUTHORS.md ChangeLog configure COPYING Makefile NEWS.md README.md THANKS.md TODO.md $(project)-$(version)
	@echo "Create tarball $(project)-$(version).tar.gz..."
	@tar czf $(project)-$(version).tar.gz $(project)-$(version)
	@echo "Release made."

changelog :
	@echo "Create changelog from git log..."
	@if [ -d ".git" ]; then \
	    git log --date-order --date=short | \
	    sed -e '/^commit.*$$/d' | \
	    awk '/^Author/ {sub(/\\$$/,""); getline t; print $$0 t; next}; 1' | \
	    sed -e 's/^Author: //g' | \
	    sed -e 's/>Date:   \([0-9]*-[0-9]*-[0-9]*\)/>\t\1/g' | \
	    sed -e 's/^\(.*\) \(\)\t\(.*\)/\3    \1    \2/g' > ChangeLog ; \
	  else \
	    echo "No git repository present." ; \
	    exit 1 ; \
	  fi


## Clean up

clean : distclean
	@echo "Remove distribution..."
	@rm -rf $(project)-$(version)/
	@rm -f $(project)-$(version).tar.gz
	@rm -f ChangeLog

distclean :
	@echo "Remove man pages..."
	@$(FIND) usr/share/man -name '*.gz' -delete
	@echo "Remove documentation..."
	@rm -rf docs/info/
	@$(FIND) docs/html/ -name '*.html' -delete
	@$(FIND) docs/pdf/ -name '*.pdf' -delete
	@echo "Remove meta information about $(project)..."
	@rm -f usr/share/doc/$(project)/AUTHORS
	@rm -f usr/share/doc/$(project)/COPYING
	@rm -f usr/share/doc/$(project)/INSTALL
	@rm -f usr/share/doc/$(project)/NEWS
	@rm -f usr/share/doc/$(project)/README
	@rm -f usr/share/doc/$(project)/THANKS
	@rm -f usr/share/doc/$(project)/TODO

mostlyclean : clean

maintainer-clean : clean


.PHONY : man info html pdf dvi ps meta install install-html install-pdf uninstall dist changelog clean distclean mostlyclean maintainer-clean

