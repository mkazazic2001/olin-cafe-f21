module full_adder(a,b,c_in,y,c);

input wire a;
input wire b;
input wire c_in;
output logic y;
output logic c;

always_comb begin
  y = a ^ b ^ c_in;
  c = (a & b) | (c_in & a) | (c_in & b);
end

endmodule