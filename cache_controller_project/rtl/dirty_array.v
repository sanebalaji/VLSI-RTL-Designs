module dirty_array(

    input clk,
    input write_en,

    input dirty_in,
    input [1:0] index,

    output wire dirty_out

);

reg dirty_mem [0:3];

integer i;

initial begin

    for(i=0;i<4;i=i+1)
        dirty_mem[i] = 0;

end

always @(posedge clk)
begin

    if(write_en)
        dirty_mem[index] <= dirty_in;

end

assign dirty_out = dirty_mem[index];

endmodule