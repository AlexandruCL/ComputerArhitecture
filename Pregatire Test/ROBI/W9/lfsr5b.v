module lfsr5b(input clk, rst_b, output [4:0] q);
    genvar k;
    generate
    for(k = 0; k < 5; k = k + 1)    begin:arr 
        if(k == 0)          d_ff i0(.clk(clk), .rst_b(1'd1), .set_b(rst_b), .d(q[4]), .q(q[k]));
        else if(k == 2)     d_ff i0(.clk(clk), .rst_b(1'd1), .set_b(rst_b), .d(q[1] ^ q[4]), .q(q[k]));
        else                d_ff i0(.clk(clk), .rst_b(1'd1), .set_b(rst_b), .d(q[k-1]), .q(q[k]));
    end
    endgenerate
endmodule

module lfsr5b_tb;
    reg clk, rst_b;
    wire [4:0] q;

    lfsr5b i1(.clk(clk), .rst_b(rst_b), .q(q));

    localparam CLK_PERIOD = 100;
    localparam CLK_CYCLES = 35;

    initial begin
        clk = 1'd0;
        repeat (2*CLK_CYCLES) #(CLK_PERIOD/2) 
        clk = 1 - clk;
    end

    localparam RST_DURATION = 25;
    initial begin
        rst_b = 0;
        #RST_DURATION
        rst_b = 1;
    end
endmodule