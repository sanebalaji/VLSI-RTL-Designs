module synchronizer(
    input clk,
    input rst,
    input [6:0] d,
    output reg [6:0] q
);

reg [6:0] q1;

always @ (posedge clk or posedge rst)
begin
    if(rst)
    begin
        q1<=7'b0;
        q<=7'b0;
    end
    else 
    begin
        q1 <= d;
        q <= q1;
    end
end
endmodule