`timescale 1ps/1ps
module sr_latch_tb;
reg sbar,rbar;
wire q,qbar;

sr_latch uut(
    .sbar(sbar),
    .rbar(rbar),
    .q(q),
    .qbar(qbar)
);

initial begin
    $dumpfile("sr_latch.vcd");
    $dumpvars(0, sr_latch_tb);
    $monitor("sbar=%b rbar=%b qbar=%b q=%b",sbar,rbar,qbar,q);

    sbar= 1;
    rbar=1;

    #10;

    sbar=0;
    rbar=1;

    #10;

    sbar=1;
    rbar=0;

    #10;
    
    sbar=0;
    rbar=0;

    #10;

    $finish;

end
endmodule

