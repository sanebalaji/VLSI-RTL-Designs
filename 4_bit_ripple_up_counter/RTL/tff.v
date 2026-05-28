module tff(
    input clk,
    input reset,
    output q
);
wire d;
assign d = ~q;
dff uut(.d(d),.clk(clk),.reset(reset),.q(q));
endmodule