module check(
    input [3:0] i,
    output o
);

assign o = (i%3 == 0) ? 1'b1 : 1'b0;
endmodule