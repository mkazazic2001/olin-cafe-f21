module slt(a, b, less);

parameter N = 32;

input wire [N-1:0] a,b;
output logic less;

logic sign_a,sign_b;
logic select;

wire [N-1:0] sum;
wire c_out;

// Subtractor module
adder_n #(N) SUBTRACTOR(.a(a),.b(~b),.c_in(1),.sum(sum),.c_out());

// Find the signs of a and b
always_comb begin : lessThan
    sign_a = a[N-1];
    sign_b = b[N-1];
    // Use mux for True or False
    select = (~sign_a & ~sign_b) + (sign_a & sign_b);
    less = select ? sum[N-1] : sign_a;
end


endmodule