`timescale 1ns/1ps

module tb_final_cache_system;

reg clk;
reg rst;

reg cpu_req;
reg cpu_write;

reg [7:0] addr;

wire hit;
wire [2:0] state;

cache_top dut(

    .clk(clk),
    .rst(rst),

    .cpu_write(cpu_write),
    .cpu_req(cpu_req),

    .addr(addr),

    .hit(hit),
    .state(state)

);

always #5 clk = ~clk;

initial begin

    $dumpfile("final_cache_system.vcd");
    $dumpvars(0, tb_final_cache_system);

    clk = 0;
    rst = 1;

    cpu_req   = 0;
    cpu_write = 0;
    addr      = 0;

    #20;
    rst = 0;

    //----------------------------------
    // TEST 1 : COLD MISS
    //----------------------------------

    $display("\n========== TEST 1 : COLD MISS ==========\n");

    addr = 8'd6;
    cpu_req = 1;

    #40;

    cpu_req = 0;

    //----------------------------------
    // TEST 2 : CACHE HIT
    //----------------------------------

    #20;

    $display("\n========== TEST 2 : CACHE HIT ==========\n");

    addr = 8'd6;
    cpu_req = 1;

    #30;

    cpu_req = 0;

    //----------------------------------
    // TEST 3 : WRITE HIT
    //----------------------------------

    #20;

    $display("\n========== TEST 3 : WRITE HIT ==========\n");

    addr = 8'd6;

    cpu_write = 1;
    cpu_req   = 1;

    #30;

    cpu_req   = 0;
    cpu_write = 0;

    //----------------------------------
    // TEST 4 : DIRTY MISS
    //----------------------------------

    #20;

    $display("\n========== TEST 4 : DIRTY MISS ==========\n");

    // same index, different tag
    addr = 8'd22;

    cpu_req = 1;

    #60;

    cpu_req = 0;

    //----------------------------------
    // FINISH
    //----------------------------------

    #50;

    $finish;

end

initial begin

    $monitor(
    "Time=%0t Addr=%d Hit=%b State=%d",
    $time,
    addr,
    hit,
    state
    );

end

endmodule