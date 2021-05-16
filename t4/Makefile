# ------------------------------------------------------------
# type "make" command in the Linux terminal create report.pdf
#
# type "make clean" to delete all generated files
# ------------------------------------------------------------

all:
	@echo "******************************************************************"
	@echo "This may take a while, take a seat and have a drink."
	@echo "Reasons why were explained in the section Comparison of the report"
	@echo "******************************************************************"
	make -C Analysis
	make -C Simulation
*	make -C Doc
*	cp Doc/report.pdf .

clean:
	make -C Analysis clean
	make -C Simulation clean
*	make -C Doc clean

.PHONY: all clean


