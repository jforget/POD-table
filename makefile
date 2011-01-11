%.html1: %.pod
	pod2html --outfile=$@ $<

%.html: %.html1
	cp $< $@
	./ajust-html $@
	emacs --batch --load=tableau $@ --funcall=tableau-html --funcall=save-buffer

%.dvi: %.tex
	latex $<
	latex $<

%.pdf: %.tex
	pdflatex $<
	pdflatex $<

%.tex: %.pod
	pod2latex $<
	./ajust-tex $@
	emacs --batch --load=tableau $@ --funcall=tableau-latex --funcall=save-buffer

tout: latex html pdf

html: lisez-moi.html read-me.html

latex: lisez-moi-1.dvi read-me-1.dvi

lisez-moi-1.dvi: lisez-moi.tex lisez-moi-1.tex

read-me-1.dvi: read-me.tex read-me-1.tex

pdf: read-me-1.pdf lisez-moi-1.pdf

read-me-1.pdf: read-me.tex read-me-1.tex

lisez-moi-1.pdf: lisez-moi.tex lisez-moi-1.tex
