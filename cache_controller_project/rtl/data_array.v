module data_array(
    input clk,
    input write_en,
    input [1:0] index,
    input write_word_en,
    input [31:0] write_data,
    input [1:0] offset,
    input [127:0] block_in,
    output [127:0] block_out
);
reg [127:0] data_mem [0:3];
integer i;

initial begin
    for(i=0;i<4;i=i+1)
        data_mem[i] = 0;
end
always @(posedge clk)
begin

    // Cache refill
    if(write_en)
    begin
        data_mem[index] <= block_in;
    end

    // CPU write hit
    if(write_word_en)
    begin

        case(offset)

            2'b00:
                data_mem[index][31:0] <= write_data;

            2'b01:
                data_mem[index][63:32] <= write_data;

            2'b10:
                data_mem[index][95:64] <= write_data;

            2'b11:
                data_mem[index][127:96] <= write_data;

        endcase

    end

end
assign block_out = data_mem[index];
endmodule
