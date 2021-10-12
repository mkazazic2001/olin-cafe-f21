`default_nettype none // Overrides default behaviour (in a good way)

module led_array_driver(ena, x, cells, rows, cols);
  // Module I/O and parameters
  parameter N=8; // Size of Conway Cell Grid.
  parameter ROWS=N;
  parameter COLS=N;

  // I/O declarations
  input wire ena;
  input wire [$clog2(N):0] x;
  input wire [N*N-1:0] cells;
  output logic [N-1:0] rows;
  output logic [N-1:0] cols;

  // You can check parameters with the $error macro within initial blocks.
  initial begin
    if ((N <= 0) || (N > 8)) begin
      $error("N must be within 0 and 8.");
    end
    if (ROWS != COLS) begin
      $error("Non square led arrays are not supported. (%dx%d)", ROWS, COLS);
    end
    if (ROWS < N) begin
      $error("ROWS/COLS must be >= than the size of the Conway Grid.");
    end
  end

  decoder_3_to_8 COL_DECODER(ena, x, cols);

  wire [N*N-1:0] leds;

  generate
    genvar row;
    for(row = 0; row < N; row++) begin
      always_comb begin : rowDriver
        // bitmask and OR together
        rows[row] = ena & ~|(cells[(row*N)+N-1:row*N] & cols);
      end
    end
  endgenerate



  
  
endmodule

`default_nettype wire // reengages default behaviour, needed when using 
                      // other designs that expect it.