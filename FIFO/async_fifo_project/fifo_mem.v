module fifo_mem (
    input wr_clk,
    input we,
    input [7:0] data_in,
    input [5:0] wr_addr,
    input [5:0] rd_addr,
    output [7:0] data_out
);

reg [7:0] mem[0:63];

always @(posedge wr_clk) begin
    if(we)
        mem[wr_addr]<=data_in;
end

assign data_out=mem[rd_addr];
endmodule

