`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_adders;
  logic [2:0] a;
  logic [2:0] b;
  logic c_in;
  wire [1:0] c_half;
  wire [1:0] c_full;
  logic [2:0] c_two;
  logic [3:0] c_three;
  

  half_adder UUT(a[0], b[0], c_half[0], c_half[1]);
  full_adder UUTF(a[0], b[0], c_in, c_full[0], c_full[1]);
  two_bit_adder UUT2(a[1:0], b[1:0], c_two[1:0], c_two[2]);
  three_bit_adder UUT3(a[2:0], b[2:0], c_three[2:0], c_three[3]);

  initial begin
    // Collect waveforms
    $dumpfile("adders.vcd");
    $dumpvars(0, UUT);
    $dumpvars(0, UUTF);
    $dumpvars(0, UUT2);
    
    $display("\n\nHalf-Adder: \n");
    $display("a b | c y");
    $display("---------");
    for (int i = 0; i < 4; i = i + 1) begin
      b = i[0];
      a = i[1];
      #1 $display("%1b %1b | %1b %1b", a[0], b[0], c_half[1], c_half[0]);
    end

    $display("\n\nFull Adder: \n");
    $display("c_in  a b | c y");
    $display("----------------");
    for (int i = 0; i < 8; i = i + 1) begin
      b = i[0];
      a = i[1];
      c_in = i[2];
      #1 $display("  %1b   %1b %1b | %1b %1b", c_in, a[0], b[0], c_full[1], c_full[0]);
    end

    $display("\n\n2-bit Adder: \n");
    $display("  a b  | c y ");
    $display("-------------");
    for (int i = 0; i < 16; i = i + 1) begin
      b = i[1:0];
      a = i[3:2];
      #1 $display(" %2b %2b | %1b %2b", a[1:0], b[1:0], c_two[2], c_two[1:0]);
    end
        
    $finish;      
    end

endmodule