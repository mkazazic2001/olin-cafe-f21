module mux2(D0, D1, S, Y);

input wire D0;
input wire D1;
input wire S;
output logic Y;

assign Y=(S)?D1:D0;

endmodule