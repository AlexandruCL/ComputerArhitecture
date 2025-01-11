module count11 #(parameter width = 4, initial_value = 0)(
    input clk, rst_b, c_up, output reg [width - 1: 0] q
);

always @(posedge clk, negedge rst_b)
    if(!rst_b)    q <= initial_value;
    else if(c_up) q <= q + 11;
endmodule

module count11_tb;

    reg clk, rst_b, c_up;
    wire [9:0] q;

    count11 #(.width(10), .initial_value('h3fb)) i0(.clk(clk), .rst_b(rst_b), .c_up(c_up), .q(q));
    localparam CLK_PERIOD = 200, CLK_CYCLES = 7, RST_DURATION = 10;
    
    initial begin
        clk = 0;
        repeat (2*CLK_CYCLES) #(CLK_PERIOD/2) clk = 1 - clk;
    end
    
    initial begin
        rst_b = 0; #(RST_DURATION) rst_b = 1;
    end

    initial begin

    #(1*CLK_PERIOD)     c_up = 1;
    #(1*CLK_PERIOD)     c_up = 0;
    #(1*CLK_PERIOD)     c_up = 1;
    #(2*CLK_PERIOD)     c_up = 0; 
    #(2*CLK_PERIOD)     c_up = 1;

    end
endmodule