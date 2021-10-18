# -Wall turns on all warnings
# -g2012 selects the 2012 version of iVerilog
IVERILOG=iverilog -Wall -g2012 -y ./ -I ./
VVP=vvp
VIVADO=vivado -mode batch -source

# Look up .PHONY rules for Makefiles
.PHONY: clean submission remove_solutions

ADDERS = full_adder.sv add32.sv
MUXES = mux2.sv mux4.sv mux8.sv mux16.sv mux32.sv

test_add32: test_add32.sv ${ADDERS}
	${IVERILOG} $^ -o test_add32.bin &&	${VVP} test_add32.bin

test_mux32: test_mux32.sv ${MUXES}
	${IVERILOG} $^ -o test_mux32.bin &&	${VVP} test_mux32.bin

# Call this to clean up all your generated files
clean:
	rm -f *.bin *.vcd vivado*.log vivado*.jou vivado*.str

# Call this to generate your submission zip file.
submission:
	zip submission.zip Makefile *.sv README.md