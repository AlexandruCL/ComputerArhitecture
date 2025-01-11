module prenc(input [5:0] i, output [1:0] o, output v);

assign o[1] = i[5] | (~i[5] & i[4] & i[3]) | (~i[5] & ~i[4] & i[3]);
assign o[0] = i[5] | (~i[5] & ~i[4] & ~i[3] & i[2]);
assign v = i[5] | (~i[5] & i[4] & ~i[3]) | (~i[5] & ~i[4] & i[3]) | (~i[5] & ~i[4] & ~i[3] & i[2]) | (~i[5] & ~i[4] & ~i[3] & ~i[2] & i[1] & i[0]) | (~i[5] & ~i[4] & ~i[3] & ~i[2] & ~i[1] & i[0]);


endmodule


module prenc_tb;

reg [5:0] i;  // 6 bit input
wire [1:0] o; // 2 bit output
wire v;       // 1 bit valid signal

prenc i0(.i(i), .o(o), .v(v));

integer k;

initial begin 

    $display("Time\ti\to");
    $monitor("%0t\t%b\t%b\t%b", $time, i, o, v);
    i = 0;

    //exhaustive testing for all possible input combinations
    for(k = 0; k < 64; k = k + 1) begin
        #10 i = k; // wait for 10 time units before next iteration
    end
end
endmodule

// ---------------------------------------------------------------------------------------------
// SAU ASA
// module prenc(
//     input [5:0] i,
//     output reg [1:0] o,
//     output reg v
// );

//     always @(*) begin
//         o = 2'b00;
//         v = 1'b0;
//         case(i)
//             6'b1?????: begin o = 2'b11; v = 1'b1; end
//             6'b010???: begin o = 2'b10; v = 1'b1; end
//             6'b001???: begin o = 2'b10; v = 1'b1; end
//             6'b011???: begin o = 2'b00; v = 1'b0; end
//             6'b0001??: begin o = 2'b01; v = 1'b1; end
//             6'b000010: begin o = 2'b00; v = 1'b1; end
//             6'b000001: begin o = 2'b00; v = 1'b1; end
//             6'b000011: begin o = 2'b00; v = 1'b0; end
//         endcase
//     end

// endmodule

// module prenc_tb;
//     reg [5:0] i;

//     wire [1:0] o;
//     wire v;

//     prenc maical(.i(i), .o(o), .v(v));

//     integer k;
// 	initial begin
// 		$display("Time\ti\to\tv");
// 		$monitor("%0t\t%b\t%b\t%b", $time, i, o, v);
// 		i = 0;
// 		for (k = 1; k < 64; k = k + 1)
// 			#10 i = k;
// 	end
// endmodule