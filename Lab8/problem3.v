module sisr_4b(
    input clk, rst,i,
    output [0:3] q
);

dflipflop dff1(.d(i ^ q[3]), .rst(rst), .set(1'b1), .clk(clk), .q(q[0]));
dflipflop dff2(.d(q[0]^q[3]), .rst(rst), .set(1'b1), .clk(clk), .q(q[1]));
dflipflop dff3(.d(q[1]), .rst(rst), .set(1'b1), .clk(clk), .q(q[2]));
dflipflop dff4(.d(q[2]), .rst(rst), .set(1'b1), .clk(clk), .q(q[3]));

endmodule