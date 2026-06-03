module async_fifo(
    input wr_clk,
    input rd_clk,
    input re,
    input we,
    input wr_rst,
    input rd_rst,
    input [7:0] data_in,
    output [7:0] data_out,
    output full,
    output empty
);

wire [6:0] wr_ptr;
wire [6:0] rd_ptr;

wire [6:0] wr_gray;
wire [6:0] rd_gray;


write_pointer wp (
    .wr_clk(wr_clk),
    .wr_rst(wr_rst),
    .we(we),
    .full(full),
    .wr_ptr(wr_ptr)
);

read_pointer rp(
    .rd_clk(rd_clk),
    .rd_rst(rd_rst),
    .re(re),
    .empty(empty),
    .rd_ptr(rd_ptr)
);

gray_converter wr_gray_gen(
    .bin(wr_ptr),
    .gray(wr_gray)
);

gray_converter rd_gray_gen(
    .bin(rd_ptr),
    .gray(rd_gray)
);

wire [6:0] wr_gray_sync;
wire [6:0] rd_gray_sync;

synchronizer wr_sync(
    .clk(rd_clk),
    .rst(rd_rst),
    .d(wr_gray),
    .q(wr_gray_sync)
);

synchronizer rd_sync(
    .clk(wr_clk),
    .rst(wr_rst),
    .d(rd_gray),
    .q(rd_gray_sync)
);

wire [5:0] wr_addr;
wire [5:0] rd_addr;

assign wr_addr = wr_ptr[5:0];
assign rd_addr = rd_ptr[5:0];

fifo_mem mem(
    .wr_clk(wr_clk),
    .we(we),
    .data_in(data_in),
    .data_out(data_out),

    .wr_addr(wr_addr),
    .rd_addr(rd_addr)
);

full_logic full_flag(
    .wr_ptr(wr_ptr),
    .rd_ptr(rd_ptr),
    .full(full)
);

empty_logic empty_flag(
    .wr_ptr(wr_ptr),
    .rd_ptr(rd_ptr),
    .empty(empty)
);

endmodule





