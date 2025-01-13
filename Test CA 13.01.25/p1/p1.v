module pal_4b (
    input [3:0] i,
    output [3:0] o
);

assign o[0] = (i[1] & i[0]) | ((~i[1]) & i[0] & i[2]) | ((~i[3]) & i[0]);
assign o[1] = (i[1] & i[0]) | (i[3] & (~i[2]) & i[0]) | (i[1] & i[3]) | (i[1] & (~i[3]) & (~i[2]));
assign o[2] = ((~i[1]) & i[2]) | (i[0] & i[2]) | (i[3] & i[2]) | (i[0] & (~i[1]) & i[3]);
assign o[3] = ((~i[1]) & (~i[0]) & i[3]) | (i[3] & i[2]) | (i[3] & i[1]) | (i[1] & i[2] & (~i[0]));

endmodule

module pal_4b_tb (
    output reg [3:0] i,
    wire [3:0] o
);

pal_4b p4(.i(i), .o(o));

    initial begin
        i = 4'b000;
        $monitor("o = %b", o);
        #20;
        i = 4'b1100;
        #20;
        i = 4'b0110;
    end
endmodule