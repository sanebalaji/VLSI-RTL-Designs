module ripple_counter_tb;

reg clk;
reg reset;
wire [3:0] q;

ripple_counter uut(
    .clk(clk),
    .reset(reset),
    .q(q)
);

initial begin
    clk = 1'b0;
end

always #5 clk = ~clk;

initial begin

    $dumpfile("ripple_counter_tb.vcd");
    $dumpvars(0, ripple_counter_tb);

    reset = 1'b1;

    #15;
    reset = 1'b0;

   #90;

    $display("test completed");

    $finish;

end

initial begin
    $monitor("time=%0t clk=%b reset=%b q=%b",
              $time, clk, reset, q);
end

endmodule