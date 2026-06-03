module empty_logic(
    input [6:0] wr_ptr,
    input [6:0] rd_ptr,

    output empty
);

assign empty = (wr_ptr == rd_ptr);

endmodule
