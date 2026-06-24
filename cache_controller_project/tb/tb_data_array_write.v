`timescale 1ns/1ps

module tb_data_array_write;

reg clk;

reg write_en;
reg write_word_en;

reg [1:0] index;
reg [1:0] offset;

reg [31:0] write_data;

reg [127:0] block_in;

wire [127:0] block_out;

data_array dut(

    .clk(clk),

    .write_en(write_en),
    .write_word_en(write_word_en),

    .index(index),
    .offset(offset),

    .write_data(write_data),

    .block_in(block_in),

    .block_out(block_out)

);

always #5 clk = ~clk;

initial begin

    $dumpfile("data_array_write.vcd");
    $dumpvars(0,tb_data_array_write);

end

initial begin

    clk = 0;

    write_en = 0;
    write_word_en = 0;

    index = 0;
    offset = 0;

    write_data = 0;
    block_in = 0;

    //----------------------------------
    // LOAD BLOCK [4 5 6 7]
    //----------------------------------

    #10;

    index = 2;

    block_in = {
        32'd7,
        32'd6,
        32'd5,
        32'd4
    };

    write_en = 1;

    #10;

    write_en = 0;

    //----------------------------------
    // WRITE 999 TO WORD2
    //----------------------------------

    #20;

    offset = 2'b10;

    write_data = 32'd999;

    write_word_en = 1;

    #10;

    write_word_en = 0;

    //----------------------------------
    // VERIFY
    //----------------------------------

    #20;

    $display("");
    $display("Word0 = %d", block_out[31:0]);
    $display("Word1 = %d", block_out[63:32]);
    $display("Word2 = %d", block_out[95:64]);
    $display("Word3 = %d", block_out[127:96]);

    #20;

    $finish;

end

endmodule