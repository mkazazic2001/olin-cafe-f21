module mux32(D,S,Y);

input wire [1023:0] D;
input wire [4:0] S;
output logic [31:0] Y;
logic [31:0] Y_1, Y_2;

mux16 pair_1_mux (D[1023:512], S[3:1], Y_1);
mux16 pair_2_mux (D[511:0], S[3:1], Y_2);
mux2 final_mux ({Y_1,Y_2}, S[0], Y);

endmodule