// Build a module called prod (producer) having inputs clk (1-bit)
// and rst b (1-bit) and outputs val (1-bit) and data (8-bits). The
// module produces random values between 0 and 5. Output val
// (valid handshaking signal) announces when the unit cannot
// produce new data (val == 0).
// The module will generate data for at least 3 and at most 5 clock
// cycles after which it will wait at least 1 and at most 4 clock cycles
// without producing new data. Build:
// 1. the Verilog code
// 2. the script file, ”run prod.txt”
// 3. a testbench generating inputs as in the timing diagram bellow

module prod(input clk, rst_b, output reg val, output reg [7:0] data);
    integer valid_cnt, invalid_cnt;
    always @(posedge clk, negedge rst_b)
        if(!rst_b) begin
            invalid_cnt <= 1;
            val         <= 0;end
        else if(invalid_cnt > 0) begin
            invalid_cnt <= invalid_cnt - 1;
            val         <= 0;
            if(invalid_cnt == 1) begin
                valid_cnt <= $urandom_range(3,5);
                val       <= 1;
                data      <= $urandom_range(0,5);
            end
        end
        else if(valid_cnt > 0) begin
            valid_cnt <= valid_cnt - 1;
            val         <= 1;
            data <= $urandom_range(0,5);
            if(valid_cnt == 1) begin
                invalid_cnt <= $urandom_range(1,4);
                val       <= 1;
            end
        end
endmodule

module prod_tb();
    reg clk, rst_b;
    
    wire val;
    wire [7:0] data;

    prod i0(.clk(clk), .rst_b(rst_b), .val(val), .data(data));

    localparam CLK_PERIOD = 100;
    localparam CLK_CYCLES = 100;

    initial begin
        clk = 1'd0;
        repeat (2*CLK_CYCLES) #(CLK_PERIOD/2) clk = 1-clk;
    end

    localparam RST_DURATION = 25;

    initial begin
        rst_b = 1'd0;
        #RST_DURATION;
        rst_b = 1'd1;
    end

endmodule
