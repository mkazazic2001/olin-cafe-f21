`default_nettype none

module conway_cell(clk, rst, ena, state_0, state_d, state_q, neighbors);
  input wire clk;
  input wire rst;
  input wire ena;

  input wire state_0;
  output logic state_d;
  output logic state_q;
  logic next_state;

  input wire [7:0] neighbors;
  logic [3:0] live;

  eight_input_adder COUNT(neighbors, live);

  always_comb begin: input_logic
    // conway logic
    next_state = ~live[3] & ~live[2] & live[1] & (state_q & live[0] | live[0]);
    // apply ena and reset
    state_d = ~rst ? (ena ? next_state : state_q) : state_0;

  end
  
  always_ff @(posedge clk) begin: D_flip_flop
    state_q <= state_d;
  end



endmodule