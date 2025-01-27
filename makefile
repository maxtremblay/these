filename=these
.PHONY: clean all pvc bibtex pdf read fast final draft

SHELL=/bin/bash

MK = latexmk
PDFLTX = pdflatex -shell-escape
INTMOD = -interaction=batchmode 
MKFLAGS = -pdf -pdflatex="$(PDFLTX) $(INTMOD)"
DRFTFLGS = -pdf -pdflatex="$(PDFLTX) $(INTMOD) -draftmode %O %S && touch %D"
EBMK = tex4ebook
EPUB2FLAGS = -st -f epub -c config/epub2.cfg -e config/epub2.mk4
EPUB3FLAGS = -st -f epub3 -c config/epub3.cfg
EBDRAFT = -m draft
EBMATHML = "mathml" # "mathml" for mathml, else leave blank
RM = rm


all: draft final # Compiles with no PDF, then build it
	$(MK) $(DRFTFLGS) ${filename} # Just so latexmk says 'up-to-dati

slow:
	$(MK) $(MKFLAGS) ${filename}

draft:
	$(MK) $(DRFTFLGS) ${filename}

final:
	$(PDFLTX) $(INTMOD) ${filename}

pvc: 
	$(MK) -pvc $(MKFLAGS) ${filename}

bibtex:
	bibtex ${filename}

pdf:
	$(PDFLTX) ${filename}


epub2: epub2_latex_draft bibtex epub2_latex

epub2_latex:
	$(EBMK) $(EPUB2FLAGS) $(filename)

epub2_latex_draft:
	$(EBMK) $(EPUB2FLAGS) $(EBDRAFT) $(filename)


epub3: epub3_latex_draft bibtex epub3_latex

epub3_latex:
	$(EBMK) $(EPUB3FLAGS) $(filename) $(EBMATHML)

epub3_latex_draft:
	$(EBMK) $(EPUB3FLAGS) $(EBDRAFT) $(filename) $(EBMATHML)


clean:
	$(MK) -c
	-$(RM) -f *.aux *.pyg *.bbl *.brf *.fls *~ *.bak *.bibliography
	-$(RM) -rf _minted-these
	-$(RM) -f ${filename}.xmpdata
	-$(RM) -f pdfa.xmpi
	-$(RM) -f content.opf *.xhtml *.html ${filename}.{4ct,4tc,css,epub,idv,lg,ncx,out.ps,tmp,xref}
	-$(RM) -f $(filename)*.png
	-$(RM) -f $(filename)*.svg
	-$(RM) -f Figures/*_ebook.svg
	-$(RM) -rf these-epub3/
	-$(RM) -rf these-epub/
	-$(RM) -rf sources/*.aux

read:
	evince ${filename}.pdf 
	
