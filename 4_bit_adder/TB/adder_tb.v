`timescale 1ns/1ps

module tb_adder;

    reg [3:0] a, b;
    reg cin;
    wire [3:0] s;
    wire cout;

    adder uut (
        .a(a),
        .b(b),
        .cin(cin),
        .s(s),
        .cout(cout)
    );

    initial begin
        $dumpfile("adder.vcd");
        $dumpvars(0, tb_adder);

        $display("Time\t a\t b\t cin\t sum\t cout");
        $monitor("%0t\t %b\t %b\t %b\t %b\t %b",
                 $time, a, b, cin, s, cout);

        
        a = 4'b0000;
        b = 4'b0000;
        cin = 0;
        #10;

        
        a = 4'b0011;   
        b = 4'b0101;   
        cin = 0;
        #10;

        
        a = 4'b0111;   // 7
        b = 4'b0001;   // 1
        cin = 0;
        #10;

        
        a = 4'b1111;   // 15
        b = 4'b0001;   // 1
        cin = 0;
        #10;

        
        a = 4'b1010;   // 10
        b = 4'b0101;   // 5
        cin = 1;
        #10;

        $finish;
    end

endmodule