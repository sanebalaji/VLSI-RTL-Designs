module  main_memory (
    input clk,
    input [31:0] addr,
    input mem_read,
    input mem_write,
    input [127:0] write_block,
    output reg [127:0] block_data,
    output reg mem_ready
);
reg [31:0] mem [0:255];
integer i;
initial begin
    for(i=0;i<256;i=i+1)
        mem[i]=i;
end
wire [31:0] block_addr;
assign block_addr = {addr[31:2],2'b00};
always @(posedge clk)
begin
    mem_ready <= 0;
    if(mem_read)
    begin
        block_data <= {
            mem[block_addr + 3],
            mem[block_addr + 2],
            mem[block_addr + 1],
            mem[block_addr]
        };
        mem_ready <= 1;
    end
    if(mem_write)
    begin
        mem[block_addr]     <= write_block[31:0];
        mem[block_addr + 1] <= write_block[63:32];
        mem[block_addr + 2] <= write_block[95:64];
        mem[block_addr + 3] <= write_block[127:96];
        mem_ready <= 1;
    end
end
endmodule