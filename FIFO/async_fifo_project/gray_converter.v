module gray_converter(
    input [6:0] bin,
    output [6:0] gray
);

assign gray = bin ^ (bin>>1);
endmodule

