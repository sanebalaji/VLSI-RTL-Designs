`timescale 1ns/1ps

module tb_cache_lookup;

reg  [7:0] addr;

reg  [3:0] stored_tag;
reg        valid;

wire [3:0] tag;
wire [1:0] index;
wire [1:0] offset;

wire hit;

cache_lookup dut(

    .addr(addr),

    .stored_tag(stored_tag),
    .valid(valid),

    .tag(tag),
    .index(index),
    .offset(offset),

    .hit(hit)

);

initial begin

    $dumpfile("cache_lookup.vcd");
    $dumpvars(0,tb_cache_lookup);

end

initial begin

    $monitor(
        "Time=%0t addr=%b tag=%b index=%b offset=%b stored_tag=%b valid=%b hit=%b",
        $time,
        addr,
        tag,
        index,
        offset,
        stored_tag,
        valid,
        hit
    );

end

initial begin

    $display("========== CACHE LOOKUP TEST ==========");

    //------------------------------------
    // CASE 1 : HIT
    //------------------------------------

    addr       = 8'b10101001;

    stored_tag = 4'b1010;

    valid      = 1'b1;

    #10;

    $display("");
    $display("CASE 1 : HIT TEST");
    $display("Expected Hit = 1");
    $display("Actual   Hit = %b", hit);

    //------------------------------------
    // CASE 2 : TAG MISMATCH
    //------------------------------------

    addr       = 8'b10101001;

    stored_tag = 4'b0011;

    valid      = 1'b1;

    #10;

    $display("");
    $display("CASE 2 : TAG MISMATCH");
    $display("Expected Hit = 0");
    $display("Actual   Hit = %b", hit);

    //------------------------------------
    // CASE 3 : VALID = 0
    //------------------------------------

    addr       = 8'b10101001;

    stored_tag = 4'b1010;

    valid      = 1'b0;

    #10;

    $display("");
    $display("CASE 3 : INVALID LINE");
    $display("Expected Hit = 0");
    $display("Actual   Hit = %b", hit);

    //------------------------------------
    // CASE 4 : ANOTHER HIT
    //------------------------------------

    addr       = 8'b00111110;

    stored_tag = 4'b0011;

    valid      = 1'b1;

    #10;

    $display("");
    $display("CASE 4 : SECOND HIT");
    $display("Expected Hit = 1");
    $display("Actual   Hit = %b", hit);

    #20;

    $finish;

end

endmodule