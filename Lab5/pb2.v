module dec_2x4_tb(
    output reg [1:0]s,
    output reg e,
    output [3:0]o
);

dec_2x4 DUD (.s(s), .e(e), .o(o));
initial begin
    s = 2'h0;
    #10 s = 2'h2;
    #10 s = 2'h1;
    #10 s = 2'h3;
    #10 s = 2'h0;
    #10 s = 2'h1;
    #10 s = 2'h3;
    #10 s = 2'h2;
    #10 s = 2'h1;
    #10 s = 2'h0;
end
initial begin
        e = 1'b1;
        #10 e = 1'b0;
        #10 e = 1'b1;
        #20 e = 1'b0;
        #10 e = 1'b1;
        #30 e = 1'b0;
        #10 e = 1'b1;
end
endmodule

