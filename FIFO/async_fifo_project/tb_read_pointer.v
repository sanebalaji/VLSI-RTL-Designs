`timescale 1ns/1ps

module tb_read_pointer;

reg rd_clk;
reg rd_rst;
reg re;

wire [6:0] rd_ptr;

read_pointer dut(
    .rd_clk(rd_clk),
    .rd_rst(rd_rst),
    .re(re),
    .rd_ptr(rd_ptr)
);

// Clock generation
always #5 rd_clk = ~rd_clk;

// VCD dump
initial begin
    $dumpfile("rd_ptr.vcd");
    $dumpvars(0,tb_read_pointer);
end

// Stimulus
initial begin

    rd_clk = 0;
    rd_rst = 1;
    re     = 0;

    #10;

    rd_rst = 0;
    re     = 1;

    #200;

    re     = 0;

    #20;

    $finish;

end

endmodule