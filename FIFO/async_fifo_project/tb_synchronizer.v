`timescale 1ns/1ps

module tb_synchronizer;

reg clk;
reg rst;
reg [6:0] d;

wire [6:0] q;

synchronizer dut(
    .clk(clk),
    .rst(rst),
    .d(d),
    .q(q)
);

// Clock generation
always #5 clk = ~clk;

// VCD dump
initial begin
    $dumpfile("sync.vcd");
    $dumpvars(0,tb_synchronizer);
end

// Stimulus
initial begin

    clk = 0;
    rst = 1;
    d   = 7'b0000000;

    #10;

    rst = 0;

    d = 7'b0000001;
    #10;

    d = 7'b0000011;
    #10;

    d = 7'b0000111;
    #10;

    d = 7'b0001111;
    #10;

    d = 7'b0011111;
    #10;

    d = 7'b0111111;
    #10;

    d = 7'b1111111;
    #20;

    $finish;

end

endmodule