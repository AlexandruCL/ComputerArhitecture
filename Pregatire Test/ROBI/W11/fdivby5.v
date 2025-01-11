module fdivby5(input clk, rst_b, clr, c_up, output fdclk);

    wire [2:0] d, q;

    rgst #(.w(3)) i0(.clk(clk), .rst_b(rst_b), .ld(c_up), .clr(clr | q[2]), .d(d), .q(q));

    assign d[2] = q[2]^(q[1] & q[0]);
    assign d[1] = q[1]^q[0];
    assign d[0] = ~q[0];
    assign fdclk = ~(q[2] | q[1] | q[0]);

endmodule

module fdivby5_tb;

reg clk, rst_b, clr, c_up;
wire fdclk;

fdivby5 fdivby5(.clk(clk), .rst_b(rst_b), .clr(clr), .c_up(c_up), .fdclk(fdclk));

localparam CLK_PERIOD = 100;
localparam CLK_CYCLES = 15;
localparam RST_DURATION = 25;

initial begin
clk = 0; repeat (2*CLK_CYCLES) #(CLK_PERIOD/2) clk = 1 - clk; end

initial begin
    rst_b = 0; #(RST_DURATION) rst_b = 1; end

initial begin
    c_up = 1; clr = 0;

    #(6 * CLK_PERIOD) clr = 1;
    #(1 * CLK_PERIOD) clr = 0;
    #(5 * CLK_PERIOD) clr = 1;
    #(1 * CLK_PERIOD) clr = 0; end


endmodule

//assign s = expression <=> always @(*) s = expression ------this is reg