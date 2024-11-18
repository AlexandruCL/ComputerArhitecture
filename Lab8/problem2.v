module lfsr_4b(
    input clk, set,
    output [0:3] q
);

dflipflop dff1(.d(q[3]), .rst(1'b1), .set(set), .clk(clk), .q(q[0]));
dflipflop dff2(.d(q[0]^q[3]), .rst(1'b1), .set(set), .clk(clk), .q(q[1]));
dflipflop dff3(.d(q[1]), .rst(1'b1), .set(set), .clk(clk), .q(q[2]));
dflipflop dff4(.d(q[2]), .rst(1'b1), .set(set), .clk(clk), .q(q[3]));

endmodule