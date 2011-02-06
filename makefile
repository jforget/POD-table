%.html1: %.pod
	pod2html --outfile=$@ $<

%.html: %.html1
	emacs --batch --load=tableau $< --funcall=tableau-html
	./ajust-html $@

%.dvi: %.tex
	latex $<
	latex $<

%.pdf: %.tex
	pdflatex $<
	pdflatex $<

%.tex1: %.pod
	pod2latex --out=$@ $<
	mv $@.tex $@

%.tex: %.tex1
	emacs --batch --load=tableau $< --funcall=tableau-latex
	./ajust-tex $*

tout: latex html pdf

html: lisez-moi.html README.html

latex: lisez-moi-1.dvi read-me-1.dvi

lisez-moi-1.dvi: lisez-moi.tex lisez-moi-1.tex

read-me-1.dvi: README.tex read-me-1.tex

pdf: read-me-1.pdf lisez-moi-1.pdf

read-me-1.pdf: README.tex read-me-1.tex

lisez-moi-1.pdf: lisez-moi.tex lisez-moi-1.tex

test: test.html
	echo '1..1'
	perl -pe 's/emacs\s+\d+\.\d+\.\d+/emacs version/i' test.html | diff -qBw - test.html.ref && echo '1 ok' || echo '1 not ok'
