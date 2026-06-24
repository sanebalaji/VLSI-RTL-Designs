`timescale 1ns/1ps

module tb_dirty_array;

reg clk;
reg write_en;

reg dirty_in;
reg [1:0] index;

wire dirty_out;

dirty_array dut(

    .clk(clk),
    .write_en(write_en),

    .dirty_in(dirty_in),
    .index(index),

    .dirty_out(dirty_out)

);

always #5 clk = ~clk;

initial begin

    $dumpfile("dirty_array.vcd");
    $dumpvars(0, tb_dirty_array);

end

initial begin

    $display("========== DIRTY ARRAY TEST ==========");

    clk = 0;
    write_en = 0;

    dirty_in = 0;
    index = 0;

    //--------------------------------
    // WRITE DIRTY=1 TO LINE 2
    //--------------------------------

    #10;

    index = 2;
    dirty_in = 1;
    write_en = 1;

    #10;

    write_en = 0;

    #20;

    $display("");
    $display("Expected Dirty = 1");
    $display("Actual Dirty   = %b", dirty_out);

    //--------------------------------
    // WRITE DIRTY=0 TO LINE 1
    //--------------------------------

    #20;

    index = 1;
    dirty_in = 0;
    write_en = 1;

    #10;

    write_en = 0;

    #20;

    $display("");
    $display("Expected Dirty = 0");
    $display("Actual Dirty   = %b", dirty_out);

    //--------------------------------
    // READ LINE 2 AGAIN
    //--------------------------------

    #20;

    index = 2;

    #20;

    $display("");
    $display("Expected Dirty = 1");
    $display("Actual Dirty   = %b", dirty_out);

    #20;

    $finish;

end

initial begin

    $monitor(
        "Time=%0t clk=%b write_en=%b index=%d dirty_in=%b dirty_out=%b",
        $time,
        clk,
        write_en,
        index,
        dirty_in,
        dirty_out
    );

end

endmodule