module sm_unit (
	input clk, rst_b, bgn, [7:0] ibus,
	output fin, [7:0] obus
);
  wire [7:0] a, q, m;
  wire [2:0] cnt;
  wire c0, c1, c2, c3, c4, c5, c6;
  
  reg_a i0(.clk(clk), .rst_b(rst_b), .clr(c0), .sh_r(c3), .ld_sgn(c4), .ld_obus(c5), .ld_sum(c2), .sh_i(1'd0), .sgn(q[0]^m[7]), .sum(a[6:0] + m[6:0]), .obus(obus), .q(a));

  reg_q i1(.clk(clk), .rst_b(rst_b), .clr_lsb(c4), .ld_ibus(c1), .ld_obus(c6), .sh_r(c3), .sh_i(a[0]), .ibus(ibus), .obus(obus), .q(q));

  reg_m i2(.clk(clk), .rst_b(rst_b), .ld_ibus(c0), ibus(ibus), q(m));

  cntr #(.w(3)) i4(.clk(clk), .rst_b(rst_b), .c_up(c3), .clr(c0), .q(cnt));

  ctrl_u i5(.clk(~clk), .rst_b(rst_b), .bgn(bgn), q_0(q[0]), .cnt_is_7(cnt == 7), .c0(c0), .c1(c1), .c2(c2), .c3(c3), .c4(c4), .c5(c5), .c6(c6), .fin(fin));
endmodule

module sm_unit_tb;
    reg clk, rst_b, bgn; reg [7:0] ibus; wire fin; wire [7:0] obus;

    sm_unit i0(.clk(clk), .rst_b(rst_b), .bgn(bgn), .ibus(ibus),.fin(fin), .obus(obus));
    localparam CLK_PERIOD=100, CLK_CYCLES=17, RST_DURATION=25;

    initial begin
        rst_b = 0; #(RST_DURATION) #(CLK_PERIOD/2) clk = clk - 1;end
    
    initial begin
    rst_b = 0; #(RST_DURATION) rst_b = 1;end

    localparam X=8'b10010111/*=-23*2^(-7)*/, Y=8'b10000011;/*=-3*2^(-7)*/

    initial begin 
    bgn = 1; #(2*CLK_PERIOD) bgn = 0; end;

    initial begin
    ibus = 0; #(1*CLK_PERIOD) ibus = X; #(1*CLK_PERIOD) ibus = Y;end
endmodule