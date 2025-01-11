module A(
    input x,y,
    output c1,c0,s1,s0
);
assign s0 = (x^y);
assign s1 = ~(x^y);
assign c0 = y&x;
assign c1 = x|y;
endmodule