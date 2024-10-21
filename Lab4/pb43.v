module tff_ar_an(
    input t,en,clk,rst,
    output reg q
);
    always @(posedge clk, negedge rst)
    begin
        if(!rst)
            q <= 1'b0;
        else if(clk) 
            if(en == 1)
                q <= q^t;
            else
                q<= 1'b0;
    end
endmodule