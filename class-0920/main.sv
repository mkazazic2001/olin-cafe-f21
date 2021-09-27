module main(clk, rst, buttons, leds);

input wire clk;
input wire rst;

input wire [1:0] buttons;
output logic [1:0] leds;

always_comb begin : gate_practice
    // lhs has to be a logic element
    leds[0] = (buttons[0] ~& buttons[1]);
end

logic q;
logic qb;
logic d;

always_comb begin : 
    qb = ~q; // inverter
    d = rst ? 1'b0 : qb; // 2:1 mux
end

always_ff @(posedge clk) begin // the arrow on the flip flop
    q <= d;
end

endmodule