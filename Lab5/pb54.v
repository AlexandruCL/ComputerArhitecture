module mux_2s #(parameter WIDTH = 8) (
    input [WIDTH-1:0] d0,
    input [WIDTH-1:0] d1,
    input [WIDTH-1:0] d2,
    input [WIDTH-1:0] d3,
    input [1:0] s,
    output reg [WIDTH-1:0] out
);

assign o = s[1] ? (s[0] ? d3 : d2) : (s[0] ? d1 : d0);
// always @(*) begin
//     case (s)
//         2'b00: out = d0;
//         2'b01: out = d1;
//         2'b10: out = d2;
//         2'b11: out = d3;
//         default: out = {WIDTH{1'b0}};
//     endcase
endmodule
