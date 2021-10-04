module eight_input_adder(in, out);
input wire [7:0] in;
output logic [3:0] out;

wire [5:0] half_out;

four_input_adder A(in[3:0],half_out[2:0]);
four_input_adder B(in[7:4], half_out[5:3]);
three_bit_adder C(half_out[2:0], half_out[5:3], out[3], out[2:0]);

endmodule