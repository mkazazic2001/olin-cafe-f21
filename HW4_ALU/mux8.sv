module mux8(D,S,Y);

input wire [255:0] D;
input wire [2:0] S;
output logic [31:0] Y;
logic [63:0] Y_1, Y_2;

mux4 pair_1_mux (D[255:128], S[2:1], Y_1);
mux4 pair_2_mux (D[127:0], S[2:1], Y_2);
mux2 final_mux ({Y_1,Y_2}, S[0], Y);

endmodule