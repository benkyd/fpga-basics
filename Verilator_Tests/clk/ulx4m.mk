PIN_DEF ?= ./ulx4m_v002.lpf
DEVICE ?= 85k
BUILDDIR = bin
TOP ?= top
VERILOG ?= $(wildcard *.v)

compile: $(BUILDDIR)/toplevel.bit

prog: $(BUILDDIR)/toplevel.bit
	fujprog $^

dfu: $(BUILDDIR)/toplevel.bit
	dfu-util -a 0 -D  $^ -R

sim: $(BUILDDIR)/sim.out
	$^

$(BUILDDIR)/sim.out: $(VERILOG) sim_main.cpp
	mkdir -p $(BUILDDIR)
	verilator -Wall --cc $(VERILOG) \
		--top-module top \
		--exe sim_main.cpp \
		--build -CFLAGS "-O2 -std=c++17" \
		--trace \
		--Wno-UNUSEDSIGNAL \
		--Wno-UNDRIVEN \
		--timing
	cp obj_dir/Vtop $@

$(BUILDDIR)/toplevel.json: $(VERILOG)
	mkdir -p $(BUILDDIR)
	yosys \
		-p "read -sv $^" \
		-p "hierarchy -top ${TOP}" \
		-p "synth_ecp5 -abc9 -json $@" \

$(BUILDDIR)/%.config: $(PIN_DEF) $(BUILDDIR)/toplevel.json
	nextpnr-ecp5 --${DEVICE} --package CABGA381 --timing-allow-fail --freq 25 --textcfg  $@ --json $(filter-out $<,$^) --lpf $<

$(BUILDDIR)/toplevel.bit: $(BUILDDIR)/toplevel.config
	ecppack --compress $^ $@

clean:
	rm -rf ${BUILDDIR} obj_dir

.SECONDARY:
.PHONY: compile clean prog dfu sim
