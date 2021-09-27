`timescale 1ps/1ps

module test_main;

input logic clk;
input logic rst;

input logic [1:0] buttons;
output wire [1:0] leds;

main UUT (
    .clk(clk), .rst(rst), .buttons(buttons), .leds(leds);
)

initial begin
    clk = 0;
    rst = 1;

    $dumpvars(0,UUT);
    $dumpfile("waves.vcd")

    @(posedge clk);
    @(posedge clk);

    rst = 0; // deassert reset

    repeat(25) @(posedge clk);

    $finish;
end

always #5 clk = ~clk;

endmodule