module decoder_3_to_8(ena, in, out);

  input wire ena;
  input wire [2:0] in;
  output logic [7:0] out;
  wire [1:0] ena_out;

decoder_1_to_2 ena_decoder (ena, in[2], ena_out);
decoder_2_to_4 decoder_0 (ena_out[0], in[1:0], out[3:0]);
decoder_2_to_4 decoder_1 (ena_out[1], in[1:0], out[7:4]);

endmodule