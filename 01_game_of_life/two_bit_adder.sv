// Use a half-adder and full-adder to create a 2-bit adder
module two_bit_adder(a,b,y,c);

input wire [1:0] a;
input wire [1:0] b;
output logic [1:0] y;
output logic c;
logic c_in;

half_adder half(a[0], b[0], y[0], c_in);
full_adder full(a[1], b[1], c_in, y[1],c);

endmodule