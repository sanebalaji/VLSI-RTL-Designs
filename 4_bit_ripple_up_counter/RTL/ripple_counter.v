module ripple_counter(
    input clk,
    input reset,
    output [3:0] q
);

tff uut1(.q(q[0]),.clk(clk),.reset(reset));
tff uut2(.q(q[1]),.clk(q[0]),.reset(reset));
tff uut3(.q(q[2]),.clk(q[1]),.reset(reset));
tff uut4(.q(q[3]),.clk(q[2]),.reset(reset));
endmodule
