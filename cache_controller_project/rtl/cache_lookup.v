module cache_lookup(
    input [7:0] addr,

    input [3:0] stored_tag,
    input valid,

    output [3:0] tag,
    output [1:0] index,
    output [1:0] offset,

    output hit
);

assign tag    = addr[7:4];
assign index  = addr[3:2];
assign offset = addr[1:0];

assign hit = (valid && (stored_tag == tag));

endmodule   
