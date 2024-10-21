module tff_ar(
    input t,en,clk,rst,
    output q
);

wire w;
assign w=(q^t) & en;
dff_ar TFF (.d(w), .clk(clk), .rst(rst), .q(q));
endmodule