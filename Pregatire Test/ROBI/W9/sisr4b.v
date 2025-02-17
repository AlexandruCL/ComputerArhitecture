module sisr4b(input clk, rst_b, i, output [3:0] q);
    genvar k;
    generate
        for(k = 0; k < 4; k = k + 1) begin:arr
            if(k == 0)          d_ff i0(.clk(clk), .rst_b(rst_b), .set_b(1'd1), .d(i ^ q[3]), .q(q[k]));
            else if(k == 1)     d_ff i0(.clk(clk), .rst_b(rst_b), .set_b(1'd1), .d(q[0] ^ q[3]), .q(q[k]));
            else                d_ff i0(.clk(clk), .rst_b(rst_b), .set_b(1'd1), .d(q[k-1]), .q(q[k]));
        end    
    endgenerate
endmodule