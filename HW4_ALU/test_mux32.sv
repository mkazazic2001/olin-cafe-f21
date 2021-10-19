`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_muxes;
  logic [1023:0] D;
  logic [4:0] S;
  logic [31:0] Y_2_1;
  logic [31:0] Y_32_1;
  logic [31:0] value_split;
  

  mux2 UUT2_1_MUX (D[63:0], S[0], Y_2_1[31:0]);
  mux32 UUT32_1_MUX (D[1023:0], S[4:0], Y_32_1[31:0]);

  initial begin
    // Collect waveforms
    $dumpfile("muxes.vcd");
    $dumpvars(0, UUT2_1_MUX);
    $dumpvars(0, UUT32_1_MUX);

    $display("\n\n32-Bit-Wide 2:1 MUX: \n");
    
    D = {32{1'b1}}<<32;
    #1 for (int i = 0; i < 2; i = i + 1) begin
      value_split = D>>i*32;
      #1 if (value_split != Y_2_1) begin
          $error("Got %32b, Expected %32b", Y_2_1, value_split);
      end
    end
    $display("\n Tested. \n");
    $display("-------------------------------------------------------------------");

    $display("\n32-Bit-Wide 32:1 MUX:\n");
    for (int i = 0; i < 32; i = i + 1) begin
        D = D | $random%4294967295<<i*32;
    end

    #1 $display("Randomly Generated 1024-bit string: \n\n%1024b", D);
    for (int i = 0; i < 32; i = i + 1) begin
      value_split = D>>i*32;
      #1 if (value_split != Y_32_1) begin
          $error("Got %32b, Expected %32b", Y_32_1, value_split);
      end
    end
    $display("\n Tested. \n");
    
    
    $finish;
    end

endmodule