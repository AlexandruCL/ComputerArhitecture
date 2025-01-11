module bist(input clk, rst_b, output [3:0] sig);

    wire [4:0] lfsr_output;
    wire check_output;

    lfsr5b i0(.clk(clk), .rst_b(rst_b), .q(lfsr_output));
    check  i1(.i(lfsr_output), .o(check_output));
    sisr4b i2(.clk(clk), .rst_b(rst_b), .i(check_output), .q(sig));
endmodule

module bist_tb();
    reg clk, rst_b;
    wire [3:0] sig;

    bist dut(.clk(clk), .rst_b(rst_b), .sig(sig));

    localparam CLK_PERIOD = 100;
    localparam CLK_CYCLES = 32;

    initial begin
        clk = 1'd0;
        repeat (2*CLK_CYCLES) #(CLK_PERIOD/2) clk = 1-clk;
    end

    localparam RST_DURATION = 25;
    initial begin
        rst_b = 0;
        #RST_DURATION
        rst_b = 1;
    end
endmodule