
all: all_1

all_1: ngspice_1.log
	$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	ps2pdf vo1.ps vo1.pdf
	ps2pdf vo2f_m.ps vo2f_m.pdf
	ps2pdf vo2f_ph.ps vo2f_ph.pdf
	ps2pdf vout.ps vout.pdf


ngspice_1.log: ../Simulation/t4.net
	ngspice -b $< -o $@


clean:
	@rm -f *.log *.tex *.pdf *.ps *~

.PHONY: all clean
