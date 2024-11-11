// module div5crtr (
//     input clk, rst, clr, cl_up,
//     output dclk
// );
// wire mod;
// wire [2:0] q;
// assign mod = clr | q[2];

//// Instantiator

// rgst # (.w(3)) divScounter(
//     .clk(clk),
//     .rst(1'b1),
//     .clr(mod),
//     .ld(cl_up),
//     .d({q[2] ^ (q[1] & q[0]), q[1] ^ q[0], ~q[0]}),
//     .q(q)
// );
// assign dlck = ~(q[2] | q[1] | q[0]);
// endmodule

//One hot encoding

module div5crtr_fsm(
    input clk, rst, c_up, clr,
    output dclk
);

//Step 1

reg [4:0]din;
wire [4:0]din_nxt;

//Step 2

assign din_nxt[1] = (din[0] & c_up & ~clr) | (din[1] & ~c_up & ~clr);
assign din_nxt[2] = (din[1] & c_up & ~clr) | (din[2] & ~c_up & ~clr);
assign din_nxt[3] = (din[2] & c_up & ~clr) | (din[3] & ~c_up & ~clr);
assign din_nxt[4] = (din[3] & c_up & ~clr) | (din[4] & ~c_up & ~clr);
assign din_nxt[0] = (din[4] & c_up & ~clr) | (din[0] & (~c_up | clr)) | (clr & (din[1]  | din[2] | din[3] | din[4]));

//Step 3

always @ (posedge clk, negedge rst) begin
    if(!rst)
        din <= 5'b1;
    else
        din <= din_nxt;
end
endmodule