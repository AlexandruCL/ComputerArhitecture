/* Truth Table
e s[1] s[0] | o[3] o[2] o[1] o[0]
1  0    0      0    0     0    1
1  0    1      0    0     1    0
1  1    0      0    1     0    0
1  1    1      1    0     0    0
0  x    x      0    0     0    0
*/

// module dec_2x4(
//     input [1:0]s,
//     input e,
//     output [4:0]o
// );

// assign o[0] = e & (~s[1]) & (~s[0]);
// assign o[1] = e & (~s[1]) & s[0];
// assign o[2] = e & s[1] & (~s[0]);
// assign o[3] = e & s[1] & s[0];

// endmodule

// Alta varianta in loc de assign


module dec_2x4(
    input [1:0]s,
    input e,
    output reg [4:0]o
);

always @(*)
begin
    case({e,s})
        3'b100: o = 4'b0001; //adica 4'd0
        3'b101: o = 4'b0010; //adica 4'd1
        3'b110: o = 4'b0100; //adica 4'd2
        3'b111: o = 4'b1000; //adica 4'd3
        3'b0??: o = 4'b0000; //adica 4'd4
    endcase
end
endmodule
