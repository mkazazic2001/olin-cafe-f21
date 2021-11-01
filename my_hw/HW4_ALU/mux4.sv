module mux4(D, S, Y);

input wire [127:0] D;
input wire [1:0] S;
output logic [31:0] Y;
logic [31:0] Y_1, Y_2;

mux2 pair_1_mux (D[127:64], S[1], Y_1);
mux2 pair_2_mux (D[63:0], S[1], Y_2);
mux2 final_mux ({Y_1,Y_2}, S[0], Y);

endmodule