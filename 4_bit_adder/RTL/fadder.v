module fadder(
    input a,
    input b,
    input cin,
    output reg s,
    output reg cout
);

always @(*) begin
    {cout,s} = a + b + cin;
end

endmodule