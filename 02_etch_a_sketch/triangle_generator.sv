// Generates "triangle" waves (counts from 0 to 2^N-1, then back down again)
// The triangle should increment/decrement only if the ena signal is high, and hold its value otherwise.
module triangle_generator(clk, rst, ena, out);

parameter N = 8;
input wire clk, rst, ena;
output logic [N-1:0] out;

typedef enum logic {COUNTING_UP, COUNTING_DOWN} state_t;
state_t state;

always_ff @(posedge clk) begin : counter_logic
  if (rst) begin
      // set clock counter to 0
      out <= 0;
  end
  else if (ena) begin
    // counting up or counting down
    if(state == COUNTING_UP) begin
        out <= out + 1;
    end
    else begin
        out <= out - 1;
    end
  end
end

// when counter on 0 or 2^N-1, change state
always_comb begin : stateChange
    if(out == 0) begin
        state = COUNTING_UP;
    end
    else if(out == (2**N) - 1) begin
        state = COUNTING_DOWN;
    end
end

endmodule