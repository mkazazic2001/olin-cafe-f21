// Use a 2-bit adder and full-adder to create a 3-bit adder
module three_bit_adder(a,b,y,c);

input wire [2:0] a,b;
output logic [2:0] y;
output logic c;
logic c_in;

two_bit_adder two(a[1:0], b[1:0], y[1:0], c_in);
full_adder full(a[2], b[2], c_in, y[2],c);

endmodule