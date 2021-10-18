module mux2(D, S, Y);

input wire [63:0] D;
input wire S;
output logic [31:0] Y;

assign Y=(S)?D[63:32]:D[31:0];

endmodule