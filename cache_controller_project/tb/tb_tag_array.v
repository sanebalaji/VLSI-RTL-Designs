`timescale 1ns/1ps

module tb_tag_array;

reg clk;
reg write_en;

reg [1:0] index;
reg [3:0] tag_in;
reg valid_in;

wire [3:0] tag_out;
wire valid_out;

tag_array dut (
    .clk(clk),
    .write_en(write_en),
    .index(index),
    .tag_in(tag_in),
    .valid_in(valid_in),
    .tag_out(tag_out),
    .valid_out(valid_out)
);
always #5 clk = ~clk;
initial begin
    $dumpfile("tag_array.vcd");
    $dumpvars(0, tb_tag_array);
end
initial begin
    $monitor(
        "Time=%0t clk=%b write_en=%b index=%d tag_in=%b valid_in=%b tag_out=%b valid_out=%b",
        $time,
        clk,
        write_en,
        index,
        tag_in,
        valid_in,
        tag_out,
        valid_out
    );
end

initial begin

    clk      = 0;
    write_en = 0;
    index    = 0;
    tag_in   = 0;
    valid_in = 0;

    $display("========== TAG ARRAY TEST ==========");

    #10;

    //----------------------------------
    // Write Tag = 1010 at Line 2
    //----------------------------------

    index    = 2;
    tag_in   = 4'b1010;
    valid_in = 1'b1;
    write_en = 1'b1;

    #10;

    write_en = 0;

    //----------------------------------
    // Read Back Line 2
    //----------------------------------

    #10;

    index = 2;

    #10;

    $display(" ");
    $display("Expected Tag   = 1010");
    $display("Actual Tag     = %b", tag_out);

    $display("Expected Valid = 1");
    $display("Actual Valid   = %b", valid_out);

    //----------------------------------
    // Write another line
    //----------------------------------

    #10;

    index    = 1;
    tag_in   = 4'b0011;
    valid_in = 1'b1;
    write_en = 1'b1;

    #10;

    write_en = 0;

    //----------------------------------
    // Read Line 1
    //----------------------------------

    #10;

    index = 1;

    #10;

    $display(" ");
    $display("Expected Tag   = 0011");
    $display("Actual Tag     = %b", tag_out);

    $display("Expected Valid = 1");
    $display("Actual Valid   = %b", valid_out);

    #20;

    $finish;

end

endmodule