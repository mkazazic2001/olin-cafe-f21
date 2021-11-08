module sltu(a, b, out);
parameter N = 32;
input wire signed [N-1:0] a, b;
output logic out;

// Find if a < b for two unsigned bitstrings!

logic [N-1:0] not_b;
always_comb not_b = ~b;
wire c_out;
wire [N-1:0] difference; 
adder_n #(.N(N)) SUBTRACTOR(
  .a(a), .b(not_b), .c_in(1'b1),
  .c_out(c_out), .sum(difference[N-1:0])
);

`ifdef MUX_APPROACH

mux4 #(.N(1)) SLT_MUX(
  .switch({a[31], b[31]}), // switch on the sign bits
  .in0(difference[N-1]), .in1(1'b0), .in2(1'b1), .in3(difference[N-1]),
  .out(out)
);
`endif

`define CLEVER_GATES_APPROACH
`ifdef CLEVER_GATES_APPROACH

always_comb begin : slt_all_cases
  out = ~c_out;
end

`endif

endmodule


