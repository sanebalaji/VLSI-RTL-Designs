`timescale 1ns/1ps
module tb_write_pointer;
reg wr_clk;
reg we;
reg wr_rst;
wire [6:0] wr_ptr;



write_pointer uut (
    .wr_clk(wr_clk),
    .wr_rst(wr_rst),
    .we(we),
    .wr_ptr(wr_ptr)
);
always #5 wr_clk=~wr_clk;
initial begin
    $dumpfile("wr_ptr.vcd");
    $dumpvars(0,tb_write_pointer);
end

initial begin
    wr_clk = 0;
    wr_rst = 1;
    we = 0;

    #10;

    wr_rst = 0;
    we = 1;

    #200;

    $finish;
end
endmodule