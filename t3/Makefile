# ------------------------------------------------------------
# type "make" command in the Linux terminal create report.pdf
#
# type "make clean" to delete all generated files
# ------------------------------------------------------------

all:
	make -C Analysis
	make -C Simulation
	make -C Comparison
	make -C Doc
	cp Doc/report.pdf .

clean:
	make -C Analysis clean
	make -C Simulation clean
	make -C Comparison clean
	make -C Doc clean

.PHONY: all clean


