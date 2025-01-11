module mschdpath(input clk, rst_b, ld_mreg, upd_mreg, input [511:0] blk, output [31:0] m0);
    function [31:0] RtRotate (input [31:0] x, input [4:0] p);
        reg [63:0] tmp;
        begin
            tmp = {x, x} >> p;
            RtRotate = tmp[31:0];
        end
    endfunction
    
    function [31:0] Sgm0(input [31:0] x);
    begin
        Sgm0 = RtRotate(x, 7) ^ RtRotate(x, 18) ^ (x >> 3);
    end   
    endfunction

    function [31:0] Sgm1(input [31:0] x);
    begin
        Sgm1 = RtRotate(x, 17) ^ RtRotate(x, 19) ^ (x >> 10);
    end   
    endfunction

    function [31:0] MUX(input sel, input [31:0] d0, d1);
        begin
            MUX = (sel) ? d1: d0;
        end
    endfunction

    function [31:0] WORD(input [511:0] blk, input [3:0] idx);
    begin
        WORD = blk[511-32*idx -: 32];
    end 
    endfunction

    wire [31:0] m[0:15]; // array of 16 elements, each one being a 32-bit vector

    generate
        genvar k;
        for(k = 0; k < 16; k = k + 1)
        begin:vec
            if( k < 15)
                rgst #(.w(32)) i0(.clk(clk), .rst_b(rst_b), .ld(upd_mreg), .clr(1'd0), .d(MUX(ld_mreg, m[k+1], WORD(blk, k))), .q(m[k]));
            else
                rgst #(.w(32)) i0(.clk(clk), .rst_b(rst_b), .ld(upd_mreg), .clr(1'd0), .d(MUX(ld_mreg,m[0] + Sgm0(m[1]) + m[9] + Sgm1(m[14]) , WORD(blk, k))), .q(m[k]));
        end
    endgenerate
    assign m0 = m[0];
endmodule

module mschdpath_tb();
    reg clk, rst_b, ld_mreg, upd_mreg;
    reg [511:0] blk;
    wire [31:0] m0;

    mschdpath dut(.clk(clk), .rst_b(rst_b), .ld_mreg(ld_mreg), .upd_mreg(upd_mreg), .blk(blk), .m0(m0));

    localparam CLK_CYCLES = 64;
    localparam CLK_PERIOD = 100;

    initial begin
        clk = 0;
        #CLK_PERIOD;
        clk = 1 - clk;
    end

    localparam RST_DURATION = 25;

    initial begin
        rst_b = 0;
        #RST_DURATION;
        rst_b = 1;
    end

    initial begin
        {ld_mreg, upd_mreg} = 3;
        #CLK_PERIOD
        {ld_mreg, upd_mreg} = 1;
    end

    initial begin
        blk = 'h61626364303132338 << 444 | 8'h40;
    end
endmodule
