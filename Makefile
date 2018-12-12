

SOURCES=$(shell find . -name '*.tikz')
OBJECTS=$(patsubst %.tikz, %.pdf, $(SOURCES))
AUX=$(patsubst %.tikz, %.aux, $(SOURCES))
LOG=$(patsubst %.tikz, %.log, $(SOURCES))
TEX=pdflatex

tikz: $(OBJECTS)

serve: tikz
	hugo serve

watch:
	fswatch -or . | xargs make tikz

$(OBJECTS): $(SOURCES)
	$(TEX) --shell-escape $^ -output-directory $(shell dirname $^)
	mv $@ static/images/
	rm -f *.aux *.log

clear-tex: clear-tex-aux clear-tex-log

clear-tex-aux: $(AUX)
	rm -f $^

clear-tex-log: $(LOG)
	rm -f $^

