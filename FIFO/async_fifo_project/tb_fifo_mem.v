`timescale 1ns/1ps

module tb_fifo_mem;

reg wr_clk;
reg we;

reg [7:0] data_in;
reg [5:0] wr_addr;
reg [5:0] rd_addr;

wire [7:0] data_out;

fifo_mem dut(
    .wr_clk(wr_clk),
    .we(we),
    .data_in(data_in),
    .data_out(data_out),
    .wr_addr(wr_addr),
    .rd_addr(rd_addr)
);

always #5 wr_clk = ~wr_clk;
initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,tb_fifo_mem);
end

initial begin
   

    wr_clk = 0;
    we = 0;

    data_in = 0;
    wr_addr = 0;
    rd_addr = 0;

    #10;

    we = 1;
    wr_addr = 0;
    data_in = 8'hAA;

    #10;

    wr_addr = 1;
    data_in = 8'h55;

    #10;

    wr_addr = 2;
    data_in = 8'hF0;

    #10;

    we = 0;

    rd_addr = 0;

    #10;

    rd_addr = 1;

    #10;

    rd_addr = 2;

    #10;

    $finish;

end

endmodule