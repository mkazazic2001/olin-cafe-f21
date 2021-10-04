module four_input_adder(in, out);
input wire [3:0] in;
output logic [2:0] out;

wire [3:0] half_out;

half_adder A(in[0], in[1], half_out[0], half_out[1]);
half_adder B(in[2], in[3], half_out[2], half_out[3]);
two_bit_adder C(half_out[1:0], half_out[3:2], out[2], out[1:0]);

endmodule