module prenc(
	input [5:0] i,
	output [1:0] o,
  output v
);

  always @(*) begin
		case(i)
		6'b000000 : {o[1], o[0], v} = 1'b000;
		6'b1????? : {o[1], o[0], v} = 1'b111;
		6'b010??? : {o[1], o[0], v} = 1'b101;
		6'b001??? : {o[1], o[0], v} = 1'b101;
		6'b011??? : {o[1], o[0], v} = 1'b000;
		6'b0001?? : {o[1], o[0], v} = 1'b011;
		6'b000010 : {o[1], o[0], v} = 1'b001;
		6'b000001 : {o[1], o[0], v} = 1'b001;
		6'b000011 : {o[1], o[0], v} = 1'b000;
		endcase
	end

endmodule

module prenc_tb;
	reg [5:0] i;
	wire [1:0] o;
  	wire v;

	prenc_tb prenc_tb (.i(i), .o(o), .v(v));

	integer k;
	initial begin
		$display("Time\ti\to\tv");
		$monitor("%0t\t%b\t%b\t%b", $time, i, o, v);
		i = 0;
		for (k = 1; k < 10; k = k + 1)
			#10 i = k;
	end
endmodule