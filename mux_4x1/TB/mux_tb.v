module mux_tb;

reg i0;
reg i1;
reg i2;
reg i3;

reg [1:0] s;

wire y;

mux uut(
    .i0(i0),
    .i1(i1),
    .i2(i2),
    .i3(i3),
    .s(s),
    .y(y)
);

initial begin

    $dumpfile("mux4to1_tb.vcd");
    $dumpvars(0,mux_tb);

    i0 = 0;
    i1 = 1;
    i2 = 0;
    i3 = 1;

    s = 2'b00;
    #10;

    s = 2'b01;
    #10;

    s = 2'b10;
    #10;

    s = 2'b11;
    #10;

    $finish;

end

initial begin
    $monitor("time=%0t s=%b y=%b",$time,s,y);
end

endmodule
