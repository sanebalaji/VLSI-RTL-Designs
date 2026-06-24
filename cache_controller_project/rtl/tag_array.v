module tag_array (
    input clk ,
    input write_en,

    input [3:0] tag_in,
    input valid_in,

    input [1:0] index,

    output wire [3:0] tag_out,
    output wire valid_out
);

reg [3:0] tag_mem [0:3];
reg valid_mem [0:3];

integer i;

initial begin
    for(i=0;i<4;i=i+1)
    begin
        tag_mem[i]   = 0;
        valid_mem[i] = 0;
    end
end

always @(posedge clk)
begin
    if(write_en)
    begin
        tag_mem[index] <= tag_in;
        valid_mem[index] <= valid_in;
    end
end
assign tag_out = tag_mem[index];
assign valid_out = valid_mem[index];    
endmodule
