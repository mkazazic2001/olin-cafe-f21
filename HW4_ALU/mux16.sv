module mux8(D,S,Y);

input wire [511:0] D;
input wire [3:0] S;
output logic [31:0] Y;
logic [31:0] Y_1, Y_2;

mux8 pair_1_mux (D[511:256], S[3:1], Y_1);
mux8 pair_2_mux (D[255:0], S[3:1], Y_2);
mux2 final_mux ({Y_1,Y_2}, S[0], Y);

endmodule