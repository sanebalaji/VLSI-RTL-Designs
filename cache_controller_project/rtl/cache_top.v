module cache_top(
    input clk,
    input rst,
    input cpu_write,
    input cpu_req,
    input [7:0] addr,

    output hit ,
    output [2:0] state,
    output [31:0] hit_count,
    output [31:0] miss_count
);


wire [3:0] tag;
wire [1:0] index;
wire [1:0] offset;

wire [3:0] stored_tag;
wire valid;

wire mem_read;
wire tag_write_en;
wire data_write_en;
wire cpu_ready;

wire [127:0] block_data;
wire [127:0] cache_block;

wire dirty;
wire dirty_write_en;
wire mem_write;

wire miss;
assign miss = cpu_req & ~hit;

cache_stats stats_inst(

    .clk(clk),
    .rst(rst),

    .hit(hit),
    .miss(miss),

    .hit_count(hit_count),
    .miss_count(miss_count)

);
cache_lookup lookup_inst(

    .addr(addr),

    .stored_tag(stored_tag),
    .valid(valid),

    .tag(tag),
    .index(index),
    .offset(offset),

    .hit(hit)

);


cache_controller ctrl_inst(

    .clk(clk),
    .rst(rst),

    .cpu_req(cpu_req),
    .hit(hit),

    .state(state),

    .cpu_write(cpu_write),

    .mem_read(mem_read),
    .tag_write_en(tag_write_en),
    .data_write_en(data_write_en),

    .cpu_ready(cpu_ready),

    .dirty(dirty),
    .dirty_write_en(dirty_write_en),

    .mem_write(mem_write)

);
tag_array tag_inst(

    .clk(clk),

    .write_en(tag_write_en),

    .tag_in(tag),

    .valid_in(1'b1),

    .index(index),

    .tag_out(stored_tag),
    .valid_out(valid)

);

data_array data_inst(

    .clk(clk),

    .write_en(data_write_en),

    .index(index),

    .block_in(block_data),

    .block_out(cache_block)

);
main_memory mem_inst(

    .clk(clk),

    .addr({24'd0,addr}),

    .mem_read(mem_read),
    .mem_write(mem_write),

    .write_block(cache_block),

    .block_data(block_data),

    .mem_ready()

);

dirty_array dirty_inst(

    .clk(clk),

    .write_en(dirty_write_en),

    .index(index),

    .dirty_in(1'b1),

    .dirty_out(dirty)

);

endmodule
