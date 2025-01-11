module regfl(input clk, rst_b, we, input [2:0] s, input [63:0]  d, output [511:0] q);
    wire [7:0] l;
    dec #(.w(3)) i0(.s(s), .e(we), .o(l));
    generate
        genvar k;
        for( k = 0; k < 8; k = k + 1)
            begin:theo
                rgst #(.w(64)) i1(.clk(clk), .rst_b(rst_b), .clr(1'd0), .d(d), .ld(l[k]), .q(q[511-64*k: 448-64*k]));
            end
    endgenerate
endmodule

module regfl_tb;
    reg clk, rst_b, we;
    reg [2:0] s;
    reg [63:0] d;

    wire [511:0] q;

    regfl i0(.clk(clk), .rst_b(rst_b), .we(we), .s(s), .d(d), .q(q));

    localparam CLK_PERIOD = 100, CLK_CYCLES = 13, RST_DURATION = 25;
    
    initial begin
    clk = 0;
    repeat(2*CLK_CYCLES) #(CLK_PERIOD/2) clk = 1- clk;
    end

    initial begin
        rst_b = 0; #RST_DURATION rst_b = 1;
    end

    initial begin
        we = 1; #(6*CLK_PERIOD);
        we = 0; #(1*CLK_PERIOD);
        we = 1;
    end 

    task urand64(output reg [63:0] r);
        begin
            r[63:32] = $urandom;
            r[31:0] = $urandom;
        end
    endtask

    initial 
        repeat(CLK_CYCLES) begin
            s = $urandom;
            urand64(d);
            #(CLK_PERIOD);
        end
endmodule