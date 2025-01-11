module fsm(
  input clk,
  input rst_b,
  input a, b, c,
  output m, n, p
);

    localparam S0 = 0;
    localparam S1 = 1;
    localparam S2 = 2;
    localparam S3 = 3;

    reg [4:0] st;
    wire [4:0] st_next;

    assign st_next[S1] = (st[S0] & a) | (st[S0] & ~a) | (st[S3] & b);
    assign st_next[S2] = (st[2] & (~a & ~b)) | (st[S1] & b);
    assign st_next[S3] = (st[S1] & (a & ~b)) | (st[S2] & (a | b)) | (st[S3] & ~b);

    assign m = (st[S0] & ~a) | (st[S1] & (~a & ~b)) | (st[S1] & (a & ~b)) | (st[S2] & (~a & ~b));
    assign n = (st[S1] & b) | (st[S1] & (a & ~b)) | (st[S2] & (a | b));
    assign p = (st[S0] & ~a) | (st[S2] & (~a & ~b)) | (st[S3] & ~b);

    always @(posedge clk, negedge rst_b) begin
        if(!rst_b)  begin
            st     <=0;
            st[S0] <= 1;
        end
        else  st <= st_next;
    end

endmodule