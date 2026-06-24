`timescale 1ns/1ps

module tb_cache_controller;

reg clk;
reg rst;

reg cpu_req;
reg hit;

wire [2:0] state;
wire mem_read;
wire tag_write_en;
wire data_write_en;
wire cpu_ready;

cache_controller dut(

    .clk(clk),
    .rst(rst),

    .cpu_req(cpu_req),
    .hit(hit),

    .state(state),

    .mem_read(mem_read),
    .tag_write_en(tag_write_en),
    .data_write_en(data_write_en),
    .cpu_ready(cpu_ready)

);

always #5 clk = ~clk;

initial begin

    $dumpfile("cache_controller.vcd");
    $dumpvars(0,tb_cache_controller);

end

initial begin

    $monitor(
        "Time=%0t State=%d cpu_req=%b hit=%b mem_read=%b tag_we=%b data_we=%b cpu_ready=%b",
        $time,
        state,
        cpu_req,
        hit,
        mem_read,
        tag_write_en,
        data_write_en,
        cpu_ready
    );

end

initial begin

    clk = 0;
    rst = 1;

    cpu_req = 0;
    hit = 0;

    #10;

    rst = 0;

    //---------------------------------
    // HIT CASE
    //---------------------------------

    cpu_req = 1;
    hit     = 1;

    #20;

    cpu_req = 0;

    //---------------------------------
    // MISS CASE
    //---------------------------------

    #30;

    cpu_req = 1;
    hit     = 0;

    #50;

    $finish;

end

endmodule