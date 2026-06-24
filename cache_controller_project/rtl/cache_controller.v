module cache_controller(
    input clk,
    input rst,

    input cpu_req,
    input hit,

    input cpu_write,

    input dirty,

    output reg [2:0] state,

    output reg mem_read,
    output reg tag_write_en,
    output reg data_write_en,
    output reg cpu_ready,

    output reg dirty_write_en,

    output reg mem_write
);

parameter IDLE        = 3'd0,
          COMPARE_TAG = 3'd1,
          WRITE_HIT   = 3'd2,
          MISS        = 3'd3,
          WRITE_BACK = 3'd4,
          ALLOCATE   = 3'd5,
          DONE       = 3'd6;
          
          

reg [2:0] next_state;

always @(posedge clk or posedge rst)
begin
    if(rst)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    case(state)
        IDLE:
            begin
            if(cpu_req)
                next_state = COMPARE_TAG;
            else
                next_state = IDLE;
        end
        COMPARE_TAG:
        begin
            if(hit)
            begin
                if(cpu_write)
                    next_state = WRITE_HIT;
                else
                    next_state = DONE;
            end
            else
                next_state = MISS;
        end

        WRITE_HIT:
        begin
            next_state = DONE;
        end
        WRITE_BACK:
        begin
            next_state = ALLOCATE;
        end
        MISS:
        begin
        if(dirty)
            next_state = WRITE_BACK;
        else
            next_state = ALLOCATE;
        end
        ALLOCATE:
        begin
            next_state = DONE;
        end
        DONE:
        begin
            next_state = IDLE;
        end

        default:
            next_state = IDLE;
    endcase
end

always @(*)
begin
    mem_read      = 0;
    tag_write_en  = 0;
    data_write_en = 0;
    cpu_ready     = 0;
    dirty_write_en = 0;
    mem_write = 0;
    case(state)
        MISS:
        begin
            mem_read = 1;
        end
        ALLOCATE:
        begin
            tag_write_en  = 1;
            data_write_en = 1;
        end
        WRITE_HIT:
        begin
            data_write_en  = 1;
            dirty_write_en = 1;
        end
        WRITE_BACK:
        begin
           mem_write = 1;
        end
        DONE:
        begin
            cpu_ready = 1;
        end
    endcase
end
endmodule
