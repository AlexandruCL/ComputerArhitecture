module mux2s #(parameter w = 4)(input [w-1:0] d0, d1, d2, d3, input [1:0] s, output reg [w-1:0] o);

always @(*)
    case (s)
        0       : o = d0;
        1       : o = d1;
        2       : o = d2;
        default : o = d3;
    endcase
endmodule

module mux2s_tb;

reg [7:0] d0, d1, d2, d3;
reg [1:0] s;
wire [7:0] o;

mux2s #(.w(8)) i0(.s(s), .d0(d0), .d1(d1), .d2(d2), .d3(d3), .o(o));

integer k;
initial
    for(k = 0; k < 32; k = k + 1) begin
        {d0, d1, d2, d3} = $urandom();
        s = $urandom();
        #10;
    end
endmodule