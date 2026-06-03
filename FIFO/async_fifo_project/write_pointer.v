module write_pointer(
    input wr_clk,
    input wr_rst,
    input we,
    input full,
    output reg [6:0] wr_ptr
);


always @ (posedge wr_clk or posedge wr_rst)
begin
    if(wr_rst)
        wr_ptr<= 7'b0000000;
    else if(we && !full)
        wr_ptr <= wr_ptr + 1;
end    


endmodule

