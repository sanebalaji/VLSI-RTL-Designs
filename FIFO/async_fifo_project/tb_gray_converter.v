`timescale 1ns/1ps

module tb_gray_converter;

reg [6:0] bin;
wire [6:0] gray;

gray_converter dut(
    .bin(bin),
    .gray(gray)
);

initial begin

    $dumpfile("gray.vcd");
    $dumpvars(0,tb_gray_converter);

    bin = 7'd0; #10;
    bin = 7'd1; #10;
    bin = 7'd2; #10;
    bin = 7'd3; #10;
    bin = 7'd4; #10;
    bin = 7'd5; #10;
    bin = 7'd6; #10;
    bin = 7'd7; #10;

    $finish;

end

endmodule