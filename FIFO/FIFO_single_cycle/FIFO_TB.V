`timescale 1ns/1ps

module fifo_tb;

reg clk;
reg rst;
reg we_en;
reg rd_en;
reg [7:0] data_in;

wire [7:0] data_out;
wire buf_full;
wire buf_empty;
wire [6:0] fifo_counter;

fifo dut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .data_out(data_out),
    .we_en(we_en),
    .rd_en(rd_en),
    .buf_full(buf_full),
    .buf_empty(buf_empty),
    .fifo_counter(fifo_counter)
);



initial begin
    clk = 0;
    forever #5 clk = ~clk;
end


// Test Sequence
initial begin
    
    $dumpfile("fifo.vcd");
    $dumpvars(0, fifo_tb);


    // Initialize
    rst = 1;
    we_en = 0;
    rd_en = 0;
    data_in = 0;

    #20;
    rst = 0;

   
    // Write 10 values
   

    $display("Writing Data...");

    repeat(60)
    begin
        @(posedge clk);
        we_en = 1;
        data_in = data_in + 8'd1;
    end

    @(posedge clk);
    we_en = 0;

    #20;

    
    // Read 10 values
    
    $display("Reading Data...");

    repeat(10)
    begin
        @(posedge clk);
        rd_en = 1;
    end

    @(posedge clk);
    rd_en = 0;

    #20;

   
    // Simultaneous Read & Write
    

    $display("Simultaneous Read and Write...");

    repeat(5)
    begin
        @(posedge clk);
        we_en = 1;
        rd_en = 1;
        data_in = data_in + 8'd1;
    end

    @(posedge clk);
    we_en = 0;
    rd_en = 0;

    #50;

    $finish;

end



initial begin
    $monitor(
        "Time=%0t rst=%b we=%b rd=%b din=%d dout=%d count=%d full=%b empty=%b",
        $time,
        rst,
        we_en,
        rd_en,
        data_in,
        data_out,
        fifo_counter,
        buf_full,
        buf_empty
    );
end

endmodule