module decoder_2_to_4(ena, in, out);

  input wire ena;
  input wire [1:0] in;
  output logic [3:0] out;
  wire [1:0] ena_out;

decoder_1_to_2 ena_decoder (ena, in[1], ena_out);
decoder_1_to_2 decoder_0 (ena_out[0], in[0], out[1:0]);
decoder_1_to_2 decoder_1 (ena_out[1], in[0], out[3:2]);

endmodule