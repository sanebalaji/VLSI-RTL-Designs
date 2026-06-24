`timescale 1ns/1ps

module tb_data_array;

reg clk;
reg write_en;

reg [1:0] index;
reg [127:0] block_in;

wire [127:0] block_out;

data_array dut (

    .clk(clk),
    .write_en(write_en),

    .index(index),

    .block_in(block_in),

    .block_out(block_out)

);

always #5 clk = ~clk;

initial begin

    $dumpfile("data_array.vcd");
    $dumpvars(0, tb_data_array);

end

initial begin

    $monitor(
        "Time=%0t clk=%b write_en=%b index=%d block_out=%h",
        $time,
        clk,
        write_en,
        index,
        block_out
    );

end

initial begin

    clk      = 0;
    write_en = 0;
    index    = 0;
    block_in = 0;

    $display("========== DATA ARRAY TEST ==========");

    #10;

    //------------------------------------
    // Write Block [4 5 6 7] to Line 2
    //------------------------------------

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

    //------------------------------------
    // Read Line 2
    //------------------------------------

    #10;

    index = 2;

    #10;

    $display("");
    $display("Expected Word0 = 4");
    $display("Actual   Word0 = %d", block_out[31:0]);

    $display("Expected Word1 = 5");
    $display("Actual   Word1 = %d", block_out[63:32]);

    $display("Expected Word2 = 6");
    $display("Actual   Word2 = %d", block_out[95:64]);

    $display("Expected Word3 = 7");
    $display("Actual   Word3 = %d", block_out[127:96]);

    //------------------------------------
    // Write another block to Line 1
    //------------------------------------

    #10;

    index = 1;

    block_in = {
        32'd40,
        32'd30,
        32'd20,
        32'd10
    };

    write_en = 1;

    #10;

    write_en = 0;

    //------------------------------------
    // Read Line 1
    //------------------------------------

    #10;

    index = 1;

    #10;

    $display("");
    $display("Expected Word0 = 10");
    $display("Actual   Word0 = %d", block_out[31:0]);

    $display("Expected Word1 = 20");
    $display("Actual   Word1 = %d", block_out[63:32]);

    $display("Expected Word2 = 30");
    $display("Actual   Word2 = %d", block_out[95:64]);

    $display("Expected Word3 = 40");
    $display("Actual   Word3 = %d", block_out[127:96]);

    #20;

    $finish;

end

endmodule