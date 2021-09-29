module half_adder(a,b,y,c);

input wire a;
input wire b;
output logic y;
output logic c;

always_comb begin
  y = a ^ b;
  c = a & b;
end

endmodule