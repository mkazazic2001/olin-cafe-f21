module add32(a, b, c_in, sum, c_out);
// Add 32-bit to 32-bit

input wire [31:0] a, b;
input wire c_in;
output logic [31:0] sum;
output wire c_out;

wire [32:0] carries;
assign carries[0] = c_in;
assign c_out = carries[N];
generate
    genvar i;
    for(i = 0; i < 32; i++) begin: ripple_carry
        full_adder ADDER (
            .a(a[i]),
            .b(b[i]),
            .c_in(carries[i]),
            .sum(sum[i])
            .c_out(carries[i+1])
        );
    end
endgenerate

endmodule