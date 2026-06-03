module full_logic(
    input [6:0] wr_ptr,
    input [6:0] rd_ptr,
    output full
);

assign full = (wr_ptr[5:0]==rd_ptr[5:0]) &&  (wr_ptr[6] != rd_ptr[6]);

endmodule
