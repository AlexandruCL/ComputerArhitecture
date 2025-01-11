module reg_a(
  input clk, rst_b, clr, sh_r, ld_sgn, ld_obus, ld_sum,
  input sh_i, sgn, [7:0] sum,
  output reg [7:0] obus, [7:0] q
);

    always @(posedge clk, negedge rst_b)

        if(!rst_b)          q <= 0;
        else if(clr)        q <= 0;
        else if(sh_r)       q <= {sh_i, q[7:1]};
        else if(ld_sgn)     q[7] <= sgn;
        else if(ld_ibus)    q <= sum;
    
    always @(*)
        obus = (ld_obus) ? : 8'bz;
endmodule