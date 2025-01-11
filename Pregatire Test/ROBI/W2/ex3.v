module ex3(input [3:0] in, output reg [3:0] out);

always @(*) begin

    case(in)

        4'b0000: out = 4'b0000;//0
        4'b0001: out = 4'b0111;//1
        4'b0010: out = 4'b0110;//2
        4'b0011: out = 4'b0101;//3
        4'b0100: out = 4'b0100;//4
        4'b0101: out = 4'b1011;//5
        4'b0110: out = 4'b1010;//6
        4'b0111: out = 4'b1001;//7
        4'b1000: out = 4'b1000;//8
        4'b1001: out = 4'b1111;//9
        default: out = 4'b0000; //default case
    endcase
end
endmodule

module ex3_tb;
	reg [3:0] in;
	wire [3:0] out;

	ex3 i0(.in(in), .out(out));

	integer k;
	initial begin
		$display("Time\ti\to");
		$monitor("%0t\t%b\t%b", $time, in, out);
		in = 0;
		for (k = 1; k < 10; k = k + 1)
			#10 in = k;
	end
endmodule