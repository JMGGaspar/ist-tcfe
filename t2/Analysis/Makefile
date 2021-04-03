all: python octave


python: Data.txt

Data.txt: t2_datagen.py
	python2 $<

octave: Data.txt
	octave Main.m > octave.log

clean:
	@rm -f octave.log octave-workspace *Data.txt *.tex *.cir *.log *.eps *~

.PHONY: clean all
