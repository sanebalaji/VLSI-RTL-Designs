module read_pointer(
    input rd_clk,
    input rd_rst,
    input re,
    input empty,
    output reg [6:0] rd_ptr
);

always @(posedge rd_clk or posedge rd_rst)
begin
    if(rd_rst)
        rd_ptr<=7'b0000000;
    else if(re && !empty)
        rd_ptr <= rd_ptr + 1;
end
endmodule
