module shift_right_arithmetic(in, shamt, out);

parameter N = 32; // only used as a constant! Don't feel like you need to a shifter for arbitrary N.

input wire [N-1:0] in;            // the input number that will be shifted left. Fill in the remainder with zeros.
input wire [$clog2(N)-1:0] shamt; // the amount to shift by (think of it as a decimal number from 0 to 31). 
output logic [N-1:0] out;
logic [N**2-1:0] Y_in;

// for signed bitstrings
logic sign_bit;
assign sign_bit = in[N-1];

genvar num_input;
generate
    for (num_input= 0; num_input < N; num_input = num_input + 1) begin: buildAllMuxInputs
        always_comb begin : buildMuxInput
            // build one n-length input for each possible right shift
            Y_in [N+(num_input*N)-1:num_input*N] = {{num_input{sign_bit}},in[N-1:num_input]};
        end
    end
endgenerate

// use n-bit mux with generated inputs to create sll shift
muxn shift_left_mux (Y_in, shamt, out);

endmodule