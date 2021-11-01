/*
  In-class LED finite state machine, using a Moore fsm
*/

module light_sequencer(clk, buttons, rgb);

// set up params
parameter N = 8;

input wire clk;
input wire [1:0] buttons;
output logic [2:0] rgb;

//rst button
logic rst; always_comb rst = buttons[0];

// setup debounce
wire debounced;
debouncer #(N) DEBOUNCE(.clk(clk),.rst(rst),.bouncy_in(buttons[1]), .debounced_out(debounced));

wire positive_edge;
edge_detector_moore EDGE_DETECTOR(.clk(clk), .rst(rst), .in(debounced), .positive_edge(positive_edge));

// state logic based on Moore table
enum logic [1:0] {
    S_RED,
    S_GREEN,
    S_BLUE,
    S_ERROR
} state, next_state;


always_ff @(posedge clk) begin : fsm_logic
  if (rst) begin
    // initial state
    state <= state.first;
  end
  else begin
    if(positive_edge) begin
      case (state)
        S_RED : begin
          state <= S_GREEN;
        end
        S_GREEN : begin
          state <= S_BLUE;
        end
        S_BLUE: begin
          state <= S_RED;
        end
        default: state <= S_ERROR;
      endcase
    end

  end
end

always_comb begin: moore_inputs
  case(state)
    S_RED: rgb = 3'b011;    // 3'b100 but pulled to V, not ground
    S_GREEN: rgb = 3'b101;  // 3'b010 but pulled to V, not ground
    S_BLUE: rgb = 3'b110;   // 3'b001 but pulled to V, not ground
    S_ERROR: rgb = 3'b000;  // 3'b111 but pulled to V, not ground
  endcase
end

endmodule