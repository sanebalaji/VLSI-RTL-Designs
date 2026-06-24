`timescale 1ns/1ps

module tb_main_memory;

reg clk;
reg mem_read;
reg [31:0] addr;

wire [127:0] block_data;
wire mem_ready;

main_memory dut (

    .clk(clk),
    .mem_read(mem_read),
    .addr(addr),

    .block_data(block_data),
    .mem_ready(mem_ready)

);

always #5 clk = ~clk;

initial begin

    $display("Simulation Started");

    clk = 0;
    mem_read = 0;
    addr = 0;

    #10;

    addr = 6;
    mem_read = 1;

    #10;

    $display("Ready = %b", mem_ready);

    $display("Word0 = %d", block_data[31:0]);
    $display("Word1 = %d", block_data[63:32]);
    $display("Word2 = %d", block_data[95:64]);
    $display("Word3 = %d", block_data[127:96]);
    
    


    #20;

    $finish;

end

initial begin
    $dumpfile("main_memory.vcd");
    $dumpvars(0, tb_main_memory);
end

initial begin
    $monitor(
        "Time=%0t clk=%b mem_read=%b addr=%d ready=%b block=%h",
        $time,
        clk,
        mem_read,
        addr,
        mem_ready,
        block_data
    );
end
endmodule