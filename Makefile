#--------------------------------
# To use this, link the source file to a version specific 
# instance of the target document name. Example:
#    ln -s arc-01 dmarc-arc-protocol-02.md
#
# Then run make
#

OPEN=$(word 1, $(wildcard /usr/bin/xdg-open /usr/bin/open /bin/echo))
SOURCES?=${wildcard dmarc-arc-*.md}
TEXT=${SOURCES:.md=.txt}
HTML=${SOURCES:.md=.html}
XML=${SOURCES:.md=.xml}

all: $(TEXT) $(HTML) $(XML)

text:	$(TEXT)
html:   $(HTML)

%.xml:	%.md
	kramdown-rfc2629 $< >$@.new
	sed -e 's/&lt;/</g' -e 's/\\\[/[/g' $@.new > $@
	rm $@.new
	#mv $@.new $@

%.html: %.xml
	xml2rfc --html $<
	#$(OPEN) $@

%.txt:	%.xml
	xml2rfc  $< $@
