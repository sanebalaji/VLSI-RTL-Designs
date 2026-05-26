module sr_latch(
    input sbar,
    input rbar,
    output q,
    output qbar
);

nand u1(q,sbar,qbar);
nand u2(qbar,rbar,q);
endmodule

