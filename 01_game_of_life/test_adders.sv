`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_adders;
  logic ena;
  logic [2:0] a;
  logic [2:0] b;
  logic c_in;
  wire [3:0] c;
  

  half_adder UUT(a[0], b[0], c[0], c[1]);
  full_adder UUTF(a[0], b[0], c_in, c[0], c[1]);

  initial begin
    // Collect waveforms
    $dumpfile("adders.vcd");
    $dumpvars(0, UUT);
    $dumpvars(0, UUTF);
    
    $display("a b | c y");
    $display("---------");
    for (int i = 0; i < 4; i = i + 1) begin
      a = i[0];
      b = i[1];
      #1 $display("%1b %1b | %1b %1b", a[0], b[0], c[1], c[0]);
    end

        $display("c a b | c y");
    $display("---------");
    for (int i = 0; i < 8; i = i + 1) begin
      a = i[1];
      b = i[0];
      c_in = i[2];
      #1 $display("%1b %1b %1b | %1b %1b", c_in, a[0], b[0], c[1], c[0]);
    end
        
    $finish;      
    end

endmodule