module adder_1(a,b,c_in,sum,c_out);

input wire a;
input wire b;
input wire c_in;
output logic sum;
output logic c_out;

always_comb begin
  sum = a ^ b ^ c_in;
  c_out = (a & b) | (c_in & a) | (c_in & b);
end

endmodule