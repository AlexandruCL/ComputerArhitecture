module interval(
	input [9:0] i,
	output o
);

	assign o = i[9]&(~i[8])&((~i[7]) | (~i[6]) | (~i[5])&(~i[4]))&(~i[1])&(~i[0]);
endmodule

module tb_interval;
    reg [9:0] i;  // 10-bit input
    wire o;       // Output

    interval uut (
        .i(i),
        .o(o)
    );

    initial begin
        // Test cases
        i = 10'b0000000000;  #10;  // i = 0, o should be 0
        i = 10'b1000000000;  #10;  // i = 512, o should be 1
        i = 10'b1011010000;  #10;  // i = 720, o should be 0
        i = 10'b1000010000;  #10;  // i = 520, o should be 1
        i = 10'b1000110011;  #10;  // i = 563, o should be 0
    end
endmodule
