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

/*
module tff_ar(
    input t,en,clk,rst,
    output q
);

wire w;
assign w=(q^t) & en;
dff_ar TFF (.d(w), .clk(clk), .rst(rst), .q(q));
endmodule
*/