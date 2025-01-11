module csua(
  input [4:0] x,
  input [4:0] y,
  output [4:0] z,
  output co
);


genvar k;
reg[5:0] c1o,c0o,s1o,s0o;
reg[11:0] mo1;

generate
    for(k=0;k<5;k=k+1)begin
        A i0(.x(x[k]), .y(y[k]),.c1(c1o[k]),.c0(c0o[k]),.s1(s1o[k]),.s0(s0o[k]) );
    end
endgenerate

assign z[0] =s0o[0];

mux_2_to_1 i1 (.d1(s1o[1])  , .d0(s0o[1]) , .s(c0o[0]) , .o(mo1[0]));

assign z[1]= mo1[0];

mux_2_to_1 i2 (.d1(c1o[1])  , .d0(c0o[1]) , .s(c0o[0]) , .o(mo1[1]));

mux_2_to_1 i3 (.d1(s1o[2])  , .d0(s0o[2]) , .s(mo1[1]) , .o(mo1[2]));

assign z[2]= mo1[2];

mux_2_to_1 i4 (.d1(s1o[3])  , .d0(s0o[3]) , .s(c0o[2]) , .o(mo1[3]));
mux_2_to_1 i5 (.d1(s1o[1])  , .d0(s0o[1]) , .s(c1o[2]) , .o(mo1[4]));

mux_2_to_1 i6 (.d1(mo1[3])  , .d0(mo1[4]) , .s(mo1[1]) , .o(mo1[5]));

assign z[3]= mo1[5];

mux_2_to_1 i7 (.d1(c1o[4])  , .d0(c0o[4]) , .s(c0o[4]) , .o(mo1[6]));
mux_2_to_1 i8 (.d1(c1o[4])  , .d0(c0o[4]) , .s(c1o[4]) , .o(mo1[7]));

mux_2_to_1 i9 (.d1(mo1[7])  , .d0(mo1[6]) , .s(mo1[1]) , .o(mo1[8]));


mux_2_to_1 i10 (.d1(s1o[5])  , .d0(s0o[5]) , .s(mo1[8]) , .o(mo1[9]));

assign z4=mo1[9];

mux_2_to_1 i11 (.c1(s1o[5])  , .c0(s0o[5]) , .s(mo1[8]) , .o(mo1[10]));

assign co=mo1[10];

endmodule

/*
CHAT

// Module for block A
module A(
    input x,       // Bit from x input
    input y,       // Bit from y input
    input s0,      // Selection signal 0
    input s1,      // Selection signal 1
    input c0,      // Carry-in 0
    input c1,      // Carry-in 1
    output reg z,  // Output z[i]
    output reg co  // Carry-out
);
    always @(*) begin
        // Logic based on selection signals
        case ({s1, s0})
            2'b00: z = x & y;           // AND operation
            2'b01: z = x | y;           // OR operation
            2'b10: {co, z} = x + y + c0; // Addition with carry
            2'b11: z = x ^ y;           // XOR operation
            default: z = 0;
        endcase
    end
endmodule

// Top-level module
module csua(
    input [4:0] x,    // 5-bit input x
    input [4:0] y,    // 5-bit input y
    input s0,         // Selection signal 0
    input s1,         // Selection signal 1
    input c0,         // Carry-in signal 0
    input c1,         // Carry-in signal 1
    output [4:0] z,   // 5-bit output z
    output co         // Carry-out
);
    // Internal signals for carry propagation
    wire [4:0] carry;

    // Instantiate "A" modules for each bit
    A A4 (.x(x[4]), .y(y[4]), .s0(s0), .s1(s1), .c0(c1), .c1(1'b0), .z(z[4]), .co(carry[4]));
    A A3 (.x(x[3]), .y(y[3]), .s0(s0), .s1(s1), .c0(carry[4]), .c1(1'b0), .z(z[3]), .co(carry[3]));
    A A2 (.x(x[2]), .y(y[2]), .s0(s0), .s1(s1), .c0(carry[3]), .c1(1'b0), .z(z[2]), .co(carry[2]));
    A A1 (.x(x[1]), .y(y[1]), .s0(s0), .s1(s1), .c0(carry[2]), .c1(1'b0), .z(z[1]), .co(carry[1]));
    A A0 (.x(x[0]), .y(y[0]), .s0(s0), .s1(s1), .c0(carry[1]), .c1(1'b0), .z(z[0]), .co(co));

endmodule

*/