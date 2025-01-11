module sadd(input clk, rst_b, x, y, output reg z);

    localparam S0 = 0;
    localparam S1 = 1;

    reg st;
    reg st_nxt;
    always @(*)
        case (st)
            S0: if(x & y)   st_nxt = S1;
                else        st_nxt = S0;
            S1: if(~x & ~y) st_nxt = S0;
                else        st_nxt = S1;
        endcase

    always @(*) begin
        z = 0;
        case (st)
            S0: if(x ^ y)   z = 1;
                else        z = 0;
            S1: if(x ^ y)   z = 0;
                else        z = 1;
        endcase
    end

    always @(posedge clk, negedge rst_b)
        if(!rst_b)  st <= S0;
        else        st <= st_nxt;
endmodule

module sadd_tb;
    reg clk, rst_b, x, y;
    wire z;
    sadd i0(.clk(clk), .rst_b(rst_b), .x(x), .y(y), .z(z));

    localparam CLK_PERIOD = 100;
    localparam CLK_CYCLES = 4;
    localparam RST_DURATION = 25;

    initial begin
        clk = 0;
        repeat(2*CLK_CYCLES) #(CLK_PERIOD/2) clk = 1 - clk;
    end

    initial begin
        rst_b = 0; #(RST_DURATION) rst_b = 1;
    end

    initial begin
        x = 0; y = 1; #(1*CLK_PERIOD)
        x = 1; y = 1; #(1*CLK_PERIOD)
        x = 1; y = 0; #(1*CLK_PERIOD)
        x = 0; y = 0;
    end
endmodule