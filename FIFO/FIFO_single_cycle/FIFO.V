module fifo(clk,rst,data_in,data_out,we_en,rd_en,buf_full,buf_empty,fifo_counter);
input clk,rst,we_en,rd_en;
input [7:0] data_in;
output reg [7:0] data_out;
output  buf_empty,buf_full;
output reg [6:0] fifo_counter;


reg [7:0] buf_mem[0:63];
reg [5:0] rd_ptr,wr_ptr;



assign buf_empty = (fifo_counter==0);
assign buf_full  = (fifo_counter==64);

always @(posedge clk or posedge rst)
begin
    if(rst)
        fifo_counter <= 0;

    else begin
        case ({we_en && !buf_full, rd_en && !buf_empty})

            2'b10:
                fifo_counter <= fifo_counter + 1;

            2'b01:
                fifo_counter <= fifo_counter - 1;

            2'b11:
                fifo_counter <= fifo_counter;

            default:
                fifo_counter <= fifo_counter;

        endcase
    end
end

always @(posedge clk or posedge rst)begin
    if(rst)
        data_out<=0;
    else if(rd_en && !buf_empty)
        data_out<=buf_mem[rd_ptr];
end

always @ (posedge clk)
begin
    if(we_en && !buf_full)
        buf_mem[wr_ptr]<=data_in;
end

always @ (posedge clk or posedge rst)
begin
    if(rst) begin
        wr_ptr<=0;
        rd_ptr<=0;
    end
    else begin
        if(rd_en && !buf_empty )
            rd_ptr<=rd_ptr+1;
        if(we_en && !buf_full)
            wr_ptr<=wr_ptr+1;
    end    
end
endmodule
