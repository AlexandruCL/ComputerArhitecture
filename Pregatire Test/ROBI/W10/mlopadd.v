module mlopadd(input clk, rst_b, input [9:0] x, output [15:0] a);
    wire [9:0] xb;
    rgst #(.w(10)) i0(.clk(clk), .rst_b(rst_b), .ld(1'd1), .clr(1'd0), .d(x), .q(xb));
    rgst #(.w(16)) i1(.clk(clk), .rst_b(rst_b), .ld(1'd1), .clr(1'd0), .d(xb+a), .q(a));
endmodule

module mlopadd_tb();
    reg clk, rst_b;
    reg [9:0] x;
    wire [15:0] a;

    mlopadd dut(.clk(clk), .rst_b(rst_b), .x(x), .a(a));

    localparam CLK_PERIOD = 100;
    localparam CLK_CYCLES = 202;
    
    initial begin
        clk = 0;
        repeat (2*CLK_CYCLES) #(CLK_PERIOD/2) clk = 1 - clk;
    end

    localparam RST_DURATION = 25;

    initial begin
        rst_b = 0;
        #(RST_DURATION) 
        rst_b = 1;
    end

    initial begin
        x = 1;
        repeat (198)  #(CLK_PERIOD) x = x + 3;
        #(CLK_PERIOD)   x = 0;
    end
endmodule