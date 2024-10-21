module tff_ar(
    input t,clk,rst,
    output reg q
);
    always @(posedge clk, negedge rst)
    begin
        if(!rst)
            q <= 1'b0;
        else if(clk)
            q <= q^t;
    end
endmodule