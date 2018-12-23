

SOURCES=$(shell find . -name '*.tikz')
OBJECTS=$(patsubst %.tikz, %.pdf, $(SOURCES))
AUX=$(patsubst %.tikz, %.aux, $(SOURCES))
LOG=$(patsubst %.tikz, %.log, $(SOURCES))
TEX=pdflatex

tikz:
	./render.sh

serve: tikz
	hugo serve

watch:
	fswatch -or . | xargs make tikz

clear-tex: clear-tex-aux clear-tex-log

clear-tex-aux: $(AUX)
	rm -f $^

clear-tex-log: $(LOG)
	rm -f $^

