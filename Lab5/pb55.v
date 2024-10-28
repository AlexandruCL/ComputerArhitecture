module reg_fl(
    input [7:0] wr_data,
    input [1:0] wr_addr, rd_addr,
    input wr_e, clk, rst,
    output [7:0] rd_data
);

wire [3:0] ld ;
wire [7:0] q0, q1, q2, q3 ;

dec_2x4 dec(.s(wr_addr), .e(wr_e), .o(ld));

rgst # (.w(8)) rgst0 (.d(wr_data), .ld(ld[0]), .clk(clk), .clr(1'b0), .rst(rst), .q(q0));
rgst # (.w(8)) rgst1 (.d(wr_data), .ld(ld[1]), .clk(clk), .clr(1'b0), .rst(rst), .q(q1));
rgst # (.w(8)) rgst2 (.d(wr_data), .ld(ld[2]), .clk(clk), .clr(1'b0), .rst(rst), .q(q2));
rgst # (.w(8)) rgst3 (.d(wr_data), .ld(ld[3]), .clk(clk), .clr(1'b0), .rst(rst), .q(q3));

mux_2s # (.WIDTH(8)) mux (.d0(q0), .d1(q1), .d2(q2), .d3(q3), .s(rd_addr), .out(rd_data));
endmodule