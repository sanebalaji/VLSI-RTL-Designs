module cache_stats(

    input clk,
    input rst,

    input hit,
    input miss,

    output reg [31:0] hit_count,
    output reg [31:0] miss_count

);

always @(posedge clk or posedge rst)
begin

    if(rst)
    begin
        hit_count  <= 0;
        miss_count <= 0;
    end
    else
    begin

        if(hit)
            hit_count <= hit_count + 1;

        if(miss)
            miss_count <= miss_count + 1;

    end

end

endmodule