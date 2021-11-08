`timescale 1ns/1ps
`default_nettype none

`include "alu_types.sv"

module alu(a, b, control, result, overflow, zero, equal);
parameter N = 32; // Don't need to support other numbers, just using this as a constant.

input wire [N-1:0] a, b; // Inputs to the ALU.
input alu_control_t control; // Sets the current operation.
output logic [N-1:0] result; // Result of the selected operation.

output logic overflow; // Is high if the result of an ADD or SUB wraps around the 32 bit boundary.
output logic zero;  // Is high if the result is ever all zeros.
output logic equal; // Is high if a == b.

// Set up outputs for each control case:
logic [N-1:0] sll_result;
logic [N-1:0] srl_result;
logic [N-1:0] sra_result;
logic [N-1:0] add_result;
logic [N-1:0] sub_result;
logic slt_result;
logic sltu_result;
wire [N-2:0] initial_bits = {31{1'b0}};

// Use *only* structural logic and previously defined modules to implement an 
// ALU that can do all of operations defined in alu_types.sv's alu_op_code_t!

// Possible outputs:

// ALU_SLL:
shift_left_logical #(.N(N)) SLL(.in(a), .shamt(b[4:0]), .out(sll_result[N-1:0]));
//ALU_SRL:
shift_right_logical #(.N(N)) SRL(.in(a), .shamt(b[4:0]), .out(srl_result[N-1:0]));
//ALU_SRA:
shift_right_arithmetic #(.N(N)) SRA(.in(a), .shamt(b[4:0]), .out(sra_result[N-1:0]));
// ALU_ADD:
adder_n #(.N(N)) ADDER(.a(a), .b(b), .c_in(1'b0), .c_out(), .sum(add_result[N-1:0]));
// ALU_SUB:
adder_n #(.N(N)) SUBTRACTOR(.a(a), .b(~b), .c_in(1'b1), .c_out(), .sum(sub_result[N-1:0]));
// ALU_SLT:
slt #(.N(N)) SLT(.a(a), .b(b), .out(slt_result));
// ALU_SLTU:
sltu #(.N(N)) SLTU(.a(a), .b(b), .out(sltu_result));

always_comb begin : all_cases_results
    case(control)
        ALU_AND: begin
            result = a&b;
        end
        ALU_OR: begin
            result = a|b;
        end
        ALU_XOR: begin
            result = a^b;
        end
        ALU_SLL: begin
            result = |(b[31:5]) ? 32'b0 : sll_result; // shift edge case
        end
        ALU_SRL: begin
            result = |(b[31:5]) ? 32'b0 : srl_result; // shift edge case
        end
        ALU_SRA: begin
            result = |(b[31:5]) ? 32'b0 : sra_result; // shift edge case
        end
        ALU_ADD: begin
            result = add_result;
        end
        ALU_SUB: begin
            result = sub_result;
        end
        ALU_SLT: begin
            result = {initial_bits, slt_result};
        end
        ALU_SLTU: begin
            result = {initial_bits, sltu_result};
        end
        default: result = 32'b0;
    endcase
end

always_comb begin : all_edge_cases
  case (control)
    ALU_SLTU, ALU_SLT, ALU_SUB: begin
        overflow = (a[N-1]^b[N-1])&(a[N-1]^sub_result[N-1]);
    end
    ALU_ADD : begin
        overflow = (a[N-1]~^b[N-1])&(a[N-1]^add_result[N-1]);
    end
    default: overflow = 0;
  endcase
  equal = &(~(a^b)); // unary/bit-wise operator through all non-equal/equal bits
  zero = &(~result); // unary/bit-wise operator through not result
end


endmodule