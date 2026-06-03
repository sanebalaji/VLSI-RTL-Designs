`timescale 1ns/1ps

module tb_async_fifo;

reg wr_clk;
reg rd_clk;

reg wr_rst;
reg rd_rst;

reg we;
reg re;

reg [7:0] data_in;

wire [7:0] data_out;
wire full;
wire empty;

async_fifo dut(
    .wr_clk(wr_clk),
    .rd_clk(rd_clk),
    .wr_rst(wr_rst),
    .rd_rst(rd_rst),
    .we(we),
    .re(re),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
);

// Write clock = 100 MHz
always #5 wr_clk = ~wr_clk;

// Read clock = 50 MHz
always #10 rd_clk = ~rd_clk;

initial begin

    $dumpfile("async_fifo.vcd");
    $dumpvars(0,tb_async_fifo);

    wr_clk = 0;
    rd_clk = 0;

    wr_rst = 1;
    rd_rst = 1;

    we = 0;
    re = 0;

    data_in = 0;

    #20;

    wr_rst = 0;
    rd_rst = 0;

    // Write data
    we = 1;

    data_in = 8'd10; #10;
    data_in = 8'd20; #10;
    data_in = 8'd30; #10;
    data_in = 8'd40; #10;
    data_in = 8'd50; #10;

    we = 0;

    #30;

    // Read data
    re = 1;

    #100;

    re = 0;

    #50;

    $finish;

end

endmodule