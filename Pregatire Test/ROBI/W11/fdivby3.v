module fdivby3 (input clk, rst_b, clr, c_up, output fdclk);

localparam S0 = 0;
localparam S1 = 1;
localparam S2 = 2;

reg [2:0] st;
wire [2:0] st_nxt;

assign st_nxt [S0]= (st[2] & (c_up | clr )) | (st[0] & (~c_up | clr));
assign st_nxt [S1]= (st[0] & (c_up & ~clr)) | (st[1] & (~c_up & ~clr));
assign st_nxt [S2]= (st[2] & (~c_up & ~clr)) | (st[1] & (c_up & ~clr));
assign fdclk = st[S0];

always @(posedge clk, negedge rst_b) begin

    if(!rst_b) begin st<=0; st[S0]<=1;end 
    else             st<=st_nxt;
    
end

endmodule

module fdivby3_tb;

reg clk, rst_b, clr, c_up;
wire fdclk;

fdivby3 fdivby3(.clk(clk), .rst_b(rst_b), .clr(clr), .c_up(c_up), .fdclk(fdclk));

localparam CLK_PERIOD = 100;
localparam CLK_CYCLES = 17;
localparam RST_DURATION = 25;

initial begin
clk = 0; repeat (2*CLK_CYCLES) #(CLK_PERIOD/2) clk = 1 - clk; end

initial begin
    rst_b = 0; #(RST_DURATION) rst_b = 1; end

initial begin
    clr = 0;

    #(4 * CLK_PERIOD) clr = 1;
    #(1 * CLK_PERIOD) clr = 0;end

initial begin

    c_up = 1;
    #(6 * CLK_PERIOD) c_up = 0;
    #(1 * CLK_PERIOD) c_up = 1;
    #(4 * CLK_PERIOD) c_up = 0;
    #(2 * CLK_PERIOD) c_up = 1;
end
endmodule