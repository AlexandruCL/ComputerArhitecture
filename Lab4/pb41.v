module dff_ar(
    input d,clk,rst,
    output reg q
);
    always @(posedge clk, negedge rst)
    begin
        if(!rst)
            q <= 1'b0;
        else if(clk)
            q <= d;
    end
endmodule