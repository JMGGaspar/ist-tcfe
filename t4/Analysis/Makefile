all: octave


octave: Main.m
	octave Main.m > octave.log

clean:
	@rm -f octave.log octave-workspace *.tex *.cir *.log *.eps *~

.PHONY: clean all
