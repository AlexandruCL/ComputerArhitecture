module mux_2_to_1 (
input s,
input [1:0] d0,
input [1:0] d1,
output [1:0] o
);
assign o = s ? d1:d0;
endmodule