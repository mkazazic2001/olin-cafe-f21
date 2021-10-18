`timescale 1ns / 1ps
`default_nettype none

`define SIMULATION

module test_adders;
  logic [31:0] a;
  logic [31:0] b;
  logic c_in;
  logic c_full;
  logic c_32;
  logic sum_full;
  logic [31:0] sum_32;
  logic [32:0] sum;
  

  full_adder UUTF(a[0], b[0], c_in, sum_full, c_full);
  add32 UUT32(a[31:0], b[31:0], c_in, sum_32[31:0], c_32);

  initial begin
    // Collect waveforms
    $dumpfile("adders.vcd");
    $dumpvars(0, UUTF);
    $dumpvars(0, UUT32);

    $display("\n\nFull Adder: \n");
    $display("c_in  a b | c y");
    $display("----------------");
    for (int i = 0; i < 8; i = i + 1) begin
      b = i[0];
      a = i[1];
      c_in = i[2];
      #1 $display("  %1b   %1b %1b | %1b %1b", c_in, a[0], b[0], c_full, sum_full);
    end

    $display("\n32-Bit Adder:");
    // Test for Empty Sum, Carry 1
    a = 1<<31;
    b = 1<<31;
    c_in = 0;
    #1 sum = a + b;

    if ((sum_32 !== sum[31:0]) || (c_32 !== sum[32]))  begin
        $error("%32b + %32b = %1b%32b (expected %33b)", a, b, c_32, sum_32, sum);
    end
    else begin
        $display("Passed: %32b + %32b = %1b%32b (expected %33b)", a, b, c_32, sum_32, sum);
    end
    
    // Test Halfway Point Carry
    a = 1<<16;
    b = 1<<16;
    #1 sum = a + b;

    if ((sum_32 !== sum[31:0]) || (c_32 !== sum[32]))  begin
        $error("%32b + %32b = %1b%32b (expected %33b)", a, b, c_32, sum_32, sum);
    end
    else begin
        $display("Passed: %32b + %32b = %1b%32b (expected %33b)", a, b, c_32, sum_32, sum);
    end

    // Test double carry
    a = 2'b11<<16;
    b = 2'b11<<16;
    #1 sum = a + b;

    if ((sum_32 !== sum[31:0]) || (c_32 !== sum[32]))  begin
        $error("%32b + %32b = %1b%32b (expected %33b)", a, b, c_32, sum_32, sum);
    end
    else begin
        $display("Passed: %32b + %32b = %1b%32b (expected %33b)", a, b, c_32, sum_32, sum);
    end

    // Test the c-in Carry
    a = 6'b111111;
    b = 6'b111111;
    c_in = 1;
    #1 sum = a + b + 1;

    if ((sum_32 !== sum[31:0]) || (c_32 !== sum[32]))  begin
        $error("%1b + %32b + %32b = %1b%32b (expected %33b)",c_in, a, b, c_32, sum_32, sum);
    end
    else begin
        $display("Passed: %1b + %32b + %32b = %1b%32b (expected %33b)", c_in, a, b, c_32, sum_32, sum);
    end
    
    $display("\n32-Bit Adder Tested.");
    $finish;
    end

endmodule