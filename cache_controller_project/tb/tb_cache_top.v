`timescale 1ns/1ps

module tb_cache_top;

reg clk;
reg rst;

reg cpu_req;
reg [7:0] addr;

wire hit;
wire [2:0] state;

cache_top dut(

    .clk(clk),
    .rst(rst),

    .cpu_req(cpu_req),
    .addr(addr),

    .hit(hit),
    .state(state)

);

always #5 clk = ~clk;

initial begin

    $dumpfile("cache_top.vcd");
    $dumpvars(0,tb_cache_top);

end

initial begin

    $monitor(
        "Time=%0t addr=%d hit=%b state=%d",
        $time,
        addr,
        hit,
        state
    );

end

initial begin

    clk = 0;
    rst = 1;

    cpu_req = 0;
    addr = 0;

    #10;
    rst = 0;

    //--------------------------------
    // FIRST ACCESS
    //--------------------------------

    addr = 8'd6;
    cpu_req = 1;

    #60;

    cpu_req = 0;

    //--------------------------------
    // SECOND ACCESS
    //--------------------------------

    #20;

    addr = 8'd6;
    cpu_req = 1;

    #40;

    cpu_req = 0;

    #20;

    $finish;

end

endmodule