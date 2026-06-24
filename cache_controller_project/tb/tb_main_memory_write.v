`timescale 1ns/1ps

module tb_main_memory_write;

reg clk;

reg mem_read;
reg mem_write;

reg [31:0] addr;

reg [127:0] write_block;

wire [127:0] block_data;
wire mem_ready;

main_memory dut(

    .clk(clk),

    .mem_read(mem_read),
    .mem_write(mem_write),

    .addr(addr),

    .write_block(write_block),

    .block_data(block_data),
    .mem_ready(mem_ready)

);

always #5 clk = ~clk;

initial begin

    $dumpfile("main_memory_write.vcd");
    $dumpvars(0,tb_main_memory_write);

end

initial begin

    clk = 0;

    mem_read = 0;
    mem_write = 0;

    addr = 0;

    write_block = 0;

    //----------------------------------
    // WRITE BLOCK
    //----------------------------------

    #10;

    addr = 8;

    write_block = {

        32'd400,
        32'd300,
        32'd200,
        32'd100

    };

    mem_write = 1;

    #10;

    mem_write = 0;

    //----------------------------------
    // READ SAME BLOCK
    //----------------------------------

    #20;

    mem_read = 1;

    #10;

    mem_read = 0;

    //----------------------------------
    // CHECK RESULTS
    //----------------------------------

    #20;

    $display("");
    $display("Expected Word0 = 100");
    $display("Actual   Word0 = %d", block_data[31:0]);

    $display("Expected Word1 = 200");
    $display("Actual   Word1 = %d", block_data[63:32]);

    $display("Expected Word2 = 300");
    $display("Actual   Word2 = %d", block_data[95:64]);

    $display("Expected Word3 = 400");
    $display("Actual   Word3 = %d", block_data[127:96]);

    #20;

    $finish;

end

initial begin

    $monitor(
        "Time=%0t clk=%b read=%b write=%b addr=%d ready=%b block=%h",
        $time,
        clk,
        mem_read,
        mem_write,
        addr,
        mem_ready,
        block_data
    );

end

endmodule