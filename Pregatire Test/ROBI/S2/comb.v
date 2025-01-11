module comb(input [3:0] i, output reg [3:0] o);

always @(*) begin
    
    case(i)

        4'b1110: o = 4'b1110;
        4'b1000: o = 4'b1101;
        4'b1100: o = 4'b0111;
        4'b0001: o = 4'b0001;
        4'b1111: o = 4'b1001;
        4'b1001: o = 4'b1100;
        default: o = 4'b0011; //decimal 3 in binary
    endcase
end

endmodule

module comb_tb;

    reg [3:0] i;
    wire [3:0] o;

    comb comb_i(.i(i), .o(o));

    integer k;

initial begin
    $display("Time\ti\to");
    $monitor("%0t\t%b\t%b", $time, i, o);
    i = 4'b0000;
    for(k = 0; k < 16; k = k + 1) //4 bit ==> 2^4 = 16
        #10 i = k;
end
endmodule