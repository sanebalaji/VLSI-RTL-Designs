`timescale 1ns/1ps

module tb_cache_controller_writeback;

reg clk;
reg rst;

reg cpu_req;
reg cpu_write;

reg hit;
reg dirty;

wire [2:0] state;

wire mem_read;
wire mem_write;

wire tag_write_en;
wire data_write_en;
wire dirty_write_en;

wire cpu_ready;

cache_controller dut(

    .clk(clk),
    .rst(rst),

    .cpu_req(cpu_req),
    .cpu_write(cpu_write),

    .hit(hit),
    .dirty(dirty),

    .state(state),

    .mem_read(mem_read),
    .mem_write(mem_write),

    .tag_write_en(tag_write_en),
    .data_write_en(data_write_en),

    .dirty_write_en(dirty_write_en),

    .cpu_ready(cpu_ready)

);

always #5 clk = ~clk;

initial begin

    $dumpfile("cache_controller_writeback.vcd");
    $dumpvars(0,tb_cache_controller_writeback);

end

initial begin

    clk = 0;

    rst = 1;

    cpu_req = 0;
    cpu_write = 0;

    hit = 0;
    dirty = 0;

    #10;

    rst = 0;

    //--------------------------------
    // CASE 1
    // MISS + CLEAN
    //--------------------------------

    cpu_req = 1;

    hit = 0;
    dirty = 0;

    #50;

    //--------------------------------
    // CASE 2
    // WRITE HIT
    //--------------------------------

    cpu_write = 1;
    hit = 1;

    #30;

    //--------------------------------
    // CASE 3
    // MISS + DIRTY
    //--------------------------------

    cpu_write = 0;

    hit = 0;
    dirty = 1;

    #60;

    $finish;

end

initial begin

    $monitor(
"Time=%0t state=%d hit=%b dirty=%b mem_read=%b mem_write=%b dirty_we=%b",
        $time,
        state,
        hit,
        dirty,
        mem_read,
        mem_write,
        dirty_write_en
    );

end

endmodule